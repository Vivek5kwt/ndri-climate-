import 'package:flutter/material.dart';
import 'package:ndri_climate/auth/login_screen.dart';
import 'package:ndri_climate/auth/otp_screen.dart';
import 'package:ndri_climate/auth/register_screen.dart';
import 'package:ndri_climate/screen/Dashboard.dart';
import 'package:ndri_climate/screen/homescreen.dart';

// import 'package:ndri_climate/auth/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NDRI Climate Service',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Home()

        // RegisterScreen(),
        );
  }
}
