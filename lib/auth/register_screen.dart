import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/material/Validation/validation_services.dart';
import 'package:ndri_climate/material/resuseabelButton.dart';
import 'package:ndri_climate/material/reuseablefeild.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../material/asset_image_loader.dart';
import '../screen/English/Feedback.dart';

class RegisterScreen extends StatefulWidget {
  final String district;

  const RegisterScreen({super.key, required this.district});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();

  final Valid _valid = Valid();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarContrastEnforced: false,
    ));
  }

  Future<void> _storeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text.trim());
    await prefs.setString('mobile', _mobileNoController.text.trim());
    await prefs.setString('district', widget.district);
  }

  @override
  void dispose() {
    _mobileNoController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = 1.sw;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/background.webp'),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.4),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            top: true,
            bottom: false,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 1.sh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
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
                        child: const AssetImageLoader(
                          assetPath: 'assets/icon/logo1.webp',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: Container(
                          width: screenWidth * 0.9,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.88),
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20.r,
                                offset: Offset(0, 10.h),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                ReuseableFeild(
                                  validator: _valid.formvaild,
                                  controller: _nameController,
                                  lable: 'Full Name'.tr,
                                  hinttext: 'Enter your Full Name'.tr,
                                  fillcolor: Colors.white,
                                  textInputType: TextInputType.text,
                                  color: true,
                                  hinttextcolor: Colors.black,
                                ),
                                SizedBox(height: 16.h),
                                ReuseableFeild(
                                  controller: _emailController,
                                  validator: _valid.formvaild,
                                  lable: 'Email ID'.tr,
                                  hinttext: 'Enter your Email Id'.tr,
                                  fillcolor: Colors.white,
                                  textInputType: TextInputType.emailAddress,
                                  color: true,
                                  hinttextcolor: Colors.black,
                                ),
                                SizedBox(height: 16.h),
                                ReuseableFeild(
                                  maxlength: 10,
                                  controller: _mobileNoController,
                                  validator: _valid.formvaild,
                                  lable: 'Mobile Number'.tr,
                                  hinttext: 'Enter your Mobile Number'.tr,
                                  fillcolor: Colors.white,
                                  textInputType: TextInputType.number,
                                  color: true,
                                  hinttextcolor: Colors.black,
                                ),
                                SizedBox(height: 20.h),
                                ReuseableContainerButton(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await _storeData();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FeedBack(),
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Register'.tr,
                                  textcolor: Colors.white,
                                  colors: const [Colors.green, Colors.green],
                                  alignment: Alignment.center,
                                  height: 50.h,
                                  width: screenWidth * 0.74,
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already Have Accounts - '.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    InkWell(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FeedBack(),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        'Login'.tr,
                                        style: TextStyle(
                                          color: Colors.green.shade800,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      AssetImageLoader(
                        assetPath: 'assets/icon/logo2.webp',
                        width: screenWidth * 0.25,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          'भा कृ अनु प-राष्ट्रीय डेरी अनुसंधान संस्थान\nकरनाल-132001, हरियाणा',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'ICAR-National Dairy Research Institute\nKarnal – 132001, Haryana',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                          height:
                              MediaQuery.of(context).viewPadding.bottom + 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
