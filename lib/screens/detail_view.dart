import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_gallery_app/services/download_helper.dart';

import '../controller/app_controller.dart';

class DetailsView extends StatelessWidget {
  DetailsView({super.key, required this.index});

  final int index;

  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Hero(
          tag: appController.photos[index].id!,
          child: CachedNetworkImage(
            imageUrl: appController.photos[index].urls!.regular!,
            imageBuilder: (BuildContext context, imageProvider) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _image(imageProvider),
                _backButton(context),
                _saveImage(context),
              ],
            ),
            placeholder: (context, url) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_rounded,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  _backButton(BuildContext context) => Positioned(
        left: 20,
        top: MediaQuery.of(context).viewPadding.top + 20,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(24)),
          child: IconButton(
              highlightColor: Colors.white24,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
      );

  _saveImage(BuildContext context) {
    return Positioned(
      right: 40,
      top: MediaQuery.of(context).viewPadding.top + 20,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(24)),
        child: IconButton(
            highlightColor: Colors.white24,
            onPressed: () async {
              await DownloadHelper().downloadFile(
                  url: appController.photos[index].urls!.regular!);
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            )),
      ),
    );
  }

  _image(imageProvider) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      );
}
