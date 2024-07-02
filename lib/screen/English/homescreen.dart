import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ndri_climate/screen/English/dashboard2.dart';
// import 'package:ndri_climate/screen/Dashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    Timer(Duration(milliseconds: 1500), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(preferredSize: Size(40,60),child: ReuseAppbar(title: 'Dasboard',backgroundColor: Colors.transparent,)),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(),
              image: DecorationImage(
                  filterQuality: FilterQuality.high,
                  opacity: 0.4,
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(vertical: 35),
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 50),
                      alignment: Alignment.center,
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topRight,
                              colors: [Colors.white70, Colors.white]),
                          shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icon/logo1.png',
                        scale: 1.25,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'राष्ट्रीय डेरी अनुसंधान संस्थान द्वारा जलवायु सेवाएं',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 45),
                      alignment: Alignment.center,
                      child: Text(
                        'NDRI CLIMATE SERVICES',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 8),
                      alignment: Alignment.center,
                      child: Text(
                        'जलवायु अनुकूल मुर्रा भैंस पालन अभ्यासओं को बढ़ावा देने के लिए भारतीय कृषि अनुसंधान परिषद-राष्ट्रीय डेरी अनुसंधान संस्थान,करनाल द्वारा एक प्रयास',
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, left: 15),
                      alignment: Alignment.center,
                      child: Text(
                        '(An effort by ICAR-National Dairy Research Institute, Karnal to promote climate resilient Murrah buffalo rearing practices)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 60),
                      child: Image.asset(
                        'assets/icon/logo2.png',
                        scale: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 65),
                      child: Image.asset(
                        'assets/images/text1.png',
                        scale: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/images/text2.png',
                        scale: 1.1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
