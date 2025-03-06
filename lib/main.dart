import 'package:flutter/material.dart';
import 'package:flutter_application_agronom_ai/view/pages/home_page.dart';
import 'package:flutter_application_agronom_ai/view/pages/landing_page.dart';
import 'package:flutter_application_agronom_ai/viewmodel/image_provider.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ImageUploadProvider()..getPredictData(),)
    ],
    child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: HomePage(),
    );
  }
}
