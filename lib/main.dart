import 'package:flutter/material.dart';
import 'package:ndri_climate/screen/English/homescreen.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/screen/localStrings.dart';

String api_key = '3c16971b948395ea13a34a7880b2a9d0';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      locale: Locale('en','US'),
        title: 'NDRI Climate Service',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:Home()

        // RegisterScreen(),
        );
  }
}
