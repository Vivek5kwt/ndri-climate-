
import 'package:flutter/material.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/screen/English/homescreen.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/screen/localStrings/hindi.dart';

String api_key = '3c16971b948395ea13a34a7880b2a9d0';

void main() { 
  runApp(const MyApp()); 
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    
    super.initState();
    Future.delayed(Durations.extralong3).then((v){
      ResponsiveUtils().init(context);
    });
  }
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
        home:
        Home()

        // RegisterScreen(),
        );
  }
}
