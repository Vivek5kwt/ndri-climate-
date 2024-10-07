import 'package:flutter/material.dart';
import 'package:ndri_climate/auth/otp_screen.dart';
import 'package:ndri_climate/material/Validation/validation_services.dart';
import 'package:ndri_climate/material/resuseabelButton.dart';
import 'package:ndri_climate/material/reuseablefeild.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  final String district;
  RegisterScreen({super.key, required this.district});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _mobilenocontroller = TextEditingController();
   String name = '';
   String mobile = '';
  String district = '';

  Valid _valid = Valid();
  bool canpop = false;

  Future<void> StoreData(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefs.setString('name', _namecontroller.text);
      _prefs.setString('mobile', _mobilenocontroller.text);
      _prefs.setString('district', widget.district);
      print('name: $name');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _mobilenocontroller.dispose();
    _emailcontroller.dispose();
    _namecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      margin: EdgeInsets.only(top: 10),
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 30, right: 30),
                          child: ReuseableFeild(
                              validator: _valid.formvaild,
                              controller: _namecontroller,
                              lable: 'Full Name'.tr,
                              hinttext: 'Enter your Full Name'.tr,
                              fillcolor: Colors.white,
                              textInputType: TextInputType.text,
                              color: true,
                              hinttextcolor: Colors.black),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: ReuseableFeild(
                              controller: _emailcontroller,
                              validator: _valid.formvaild,
                              lable: 'Email ID'.tr,
                              hinttext: 'Enter your Email Id'.tr,
                              fillcolor: Colors.white,
                              textInputType: TextInputType.emailAddress,
                              color: true,
                              hinttextcolor: Colors.black),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: ReuseableFeild(
                              maxlength: 10,
                              controller: _mobilenocontroller,
                              validator: _valid.formvaild,
                              lable: 'Mobile Number'.tr,
                              hinttext: 'Enter your Mobile Number'.tr,
                              fillcolor: Colors.white,
                              textInputType: TextInputType.number,
                              color: true,
                              hinttextcolor: Colors.black),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ReuseableContainerButton(
                          onTap: ()async {
                            if (_formkey.currentState!.validate()) {
                             await StoreData(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPScreen(mob_no: _mobilenocontroller.text,),
                                ),
                              );
                            }
                          },
                          text: 'Register'.tr,
                          textcolor: Colors.white,
                          colors: [Colors.green, Colors.green],
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.26),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have Account - '.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () async{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPScreen(mob_no: _mobilenocontroller.text,),
                                ),
                              );
                            },
                            child: Text(
                              'Login'.tr,
                              style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
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
