import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Modules/Home/home_binding.dart';
import 'Modules/Home/home_view.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Github',
      getPages: [
        GetPage(name: '/home', page: ()=> HomeView(), binding: HomeBinding()),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
    );
  }
}

