import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:photo_gallery_app/controller/app_controller.dart';

import '../../common/components.dart';
import 'detail_view.dart';

class HomeScreen extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Scaffold(
              appBar: AppBar(
                elevation: 3,
                backgroundColor: Colors.white,
                centerTitle: true,
                title: const Text("Photo Gallery App"),
              ),
              body: Obx(() => _body()),
            ),
        onLoading: const CustomLoader());
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 8,right: 8),
      child: GridView.custom(
        controller: Get.find<AppController>().scrollController,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: const [
            QuiltedGridTile(2, 2),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
            childCount: Get.find<AppController>().photos.length,
            (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => DetailsView(index: index),
                  ),
                );
              },
              child: Hero(
                tag: Get.find<AppController>().photos[index].id!,
                child: Container(
                  margin: const EdgeInsets.all(2),
                  child: CachedNetworkImage(
                    imageUrl:
                        Get.find<AppController>().photos[index].urls!.regular!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
