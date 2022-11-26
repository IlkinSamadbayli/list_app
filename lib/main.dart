import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'app_provider.dart';
import 'presentation/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
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
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Test Page',
        theme: ThemeData(
          primaryColor: const Color(0xffD23369),
          primarySwatch: Colors.blue,
        ),
        home: const Home(title: "Home Page"),
      ),
    );
  }
}
