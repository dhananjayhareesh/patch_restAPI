import 'package:flutter/material.dart';
import 'package:patch_imp/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rest API",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.orangeAccent,
      ),
      home: HomeScreen(),
    );
  }
}
