import 'package:flutter/material.dart';
import 'package:ndri_climate/material/Validation/validation_services.dart';
import 'package:ndri_climate/material/resuseabelButton.dart';
import 'package:ndri_climate/material/reuseablefeild.dart';
import 'package:ndri_climate/screen/English/Feedback.dart';
import 'package:get/get.dart';
class LoginScreen extends StatefulWidget {
  
  const LoginScreen({super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _otpcontroller = TextEditingController();
  Valid _valid = Valid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight - 20,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
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
                      margin: EdgeInsets.only(top: 40),
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
                      margin: EdgeInsets.only(top: 80, left: 30, right: 30),
                      child: ReuseableFeild(
                          maxlength: 4,
                          controller: _otpcontroller,
                          validator: _valid.formvaild,
                          lable: 'Enter OTP'.tr,
                          hinttext: 'Enter OTP'.tr,
                          fillcolor: Colors.white,
                          textInputType: TextInputType.name,
                          color: true,
                          hinttextcolor: Colors.black),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ReuseableContainerButton(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FeedBack(),
                                ),
                              );
                            }
                          },
                          text: 'Login'.tr,
                          textcolor: Colors.white,
                          colors: [Colors.green, Colors.green],
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.26),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Image.asset(
                        'assets/icon/logo2.png',
                        scale: 1.3,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
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
