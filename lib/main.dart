import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/presentation/home_screen.dart';
import 'package:provider_test/style/custom_color.dart';
import 'package:sizer/sizer.dart';

import 'provider/list_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: CustomColor.primaryColor,
            primarySwatch: Colors.teal,
          ),
          home: const HomeScreen()),
    );
  }
}
