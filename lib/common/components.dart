import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: customLoading(),
    );
  }
}

Widget customLoading() => LoadingAnimationWidget.flickr(
      leftDotColor: Colors.black,
      rightDotColor: Colors.red,
      size: 25,
    );

Widget errorIcon() => const Icon(
      Icons.image_not_supported,
      color: Colors.grey,
    );

showToast(String msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0);
