import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery_app/model/photo_model.dart';
import 'package:photo_gallery_app/services/api_services.dart';
import 'package:photo_gallery_app/utils.dart';

class AppController extends GetxController with StateMixin {
  RxList<PhotoModel> photos = <PhotoModel>[].obs;
  int page = 1;
  bool lastPage = false;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    getPictureData();
    scrollController = ScrollController();

    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (lastPage == false) {
            _loadMorePhotos();
          }
        }
      });
  }

  getPictureData() async {
    change(null, status: RxStatus.loading());
    photos.clear();
    log("after clear:: ${photos.length}");
    http.Response response = await ApiServices().getReq(
        "https://api.unsplash.com/photos/?page=$page&per_page=30&client_id=$API_KEY");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> element in data) {
        photos.add(PhotoModel.fromJson(element));
      }
      log("Res data:: ${photos.toString()}");
      log("after adding photos:: ${photos.length}");
      if (photos.isNotEmpty && photos.length < 30) {
        lastPage = true;
        log("last page value if:: $lastPage");
      } else {
        lastPage = false;
        page = page + 1;
        log("last page value else:: $lastPage");
      }
      log(photos.toString());
    }
    change(null, status: RxStatus.success());
  }

  _loadMorePhotos() async {
    http.Response response = await ApiServices().getReq(
        "https://api.unsplash.com/photos/?page=$page&per_page=30&client_id=$API_KEY");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> element in data) {
        photos.add(PhotoModel.fromJson(element));
      }
      log("after adding more photos:: ${photos.length}");
      if (photos.isNotEmpty && photos.length < 30) {
        lastPage = true;
        log("last page value if after adding more:: $lastPage");
      } else {
        lastPage = false;
        page = page + 1;
        log("last page value else after adding more:: $lastPage");
      }
    }
  }
}
