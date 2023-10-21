import 'package:flutter/material.dart';
import 'package:photo_gallery_app/utils.dart';

import 'init_app.dart';
import 'screens/home_screen.dart';

void main() async{
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: HomeScreen()
    );
  }
}

