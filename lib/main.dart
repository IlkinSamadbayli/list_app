import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/style.dart';
import 'package:sizer/sizer.dart';

import 'provider/list_provider.dart';
import 'presentation/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Test Page',
        theme: ThemeData(
          primaryColor: CustomColor.primaryColor,
          primarySwatch: Colors.teal,
        ),
        home: const Home(title: "Home Page"),
      ),
    );
  }
}
