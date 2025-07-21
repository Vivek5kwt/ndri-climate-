import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/screen/English/Dialogue_page.dart';
import '../../material/asset_image_loader.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ResponsiveUtils().init(context);
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Dialogue_page()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = 1.sw;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: AssetImageLoader(
              assetPath: 'assets/images/background.webp',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              color: Colors.white.withOpacity(0.4),
              colorBlendMode: BlendMode.srcOver,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 20.h),
                    Container(
                      height: 140.w,
                      width: 140.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topRight,
                          colors: [Colors.white70, Colors.white],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: AssetImageLoader(
                        assetPath: 'assets/icon/logo1.webp',
                        fit: BoxFit.contain,
                        width: 100.w,
                        height: 100.w,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'राष्ट्रीय डेरी अनुसंधान संस्थान\nद्वारा जलवायु सेवाएं',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'NDRI CLIMATE SERVICES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.15,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        '(जलवायु अनुकूल मुर्राह भैंस पालन अभ्यासों को बढ़ावा देने के लिए '
                            'भारतीय कृषि अनुसंधान परिषद-राष्ट्रीय डेरी अनुसंधान संस्थान, करनाल द्वारा एक प्रयास)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        '(An effort by ICAR-National Dairy Research Institute, Karnal to '
                            'promote climate resilient Murrah buffalo rearing practices)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: AssetImageLoader(
                      assetPath: 'assets/icon/logo2.webp',
                      width: screenWidth * 0.25,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'भा कृ अनु प-राष्ट्रीय डेरी अनुसंधान संस्थान\n'
                            'करनाल-132001, हरियाणा',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      'ICAR-National Dairy Research Institute\n'
                          'Karnal – 132001, Haryana',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
