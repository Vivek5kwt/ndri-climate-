import 'package:flutter/material.dart';
import 'package:ndri_climate/auth/login_screen.dart';
import 'package:ndri_climate/material/Validation/validation_services.dart';
import 'package:ndri_climate/material/resuseabelButton.dart';
import 'package:ndri_climate/material/reuseablefeild.dart';
import 'package:get/get.dart';

class OTPScreen extends StatefulWidget {
  final String mob_no;
  const OTPScreen({super.key, required this.mob_no, 
  });
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _mobilenocontroller = TextEditingController();
  Valid _valid = Valid();
  bool canpop = false;

  @override
  void initState() {
    super.initState();
    if (widget.mob_no.isNotEmpty) {
      _mobilenocontroller.text = widget.mob_no;
    }
    canpop = Navigator.canPop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _mobilenocontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight - 20,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: canpop
            ? IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined),
              )
            : null,
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
                          maxlength: 10,
                          controller: _mobilenocontroller,
                          validator: _valid.formvaild,
                          lable: 'Mobile Number'.tr,
                          hinttext: 'Enter your Mobile Number'.tr,
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(
                                    ),
                                ),
                              );
                            }
                          },
                          text: 'Send OTP'.tr,
                          textcolor: Colors.white,
                          colors: [Colors.green, Colors.green],
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.26),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ReuseableContainerButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                  ),
                              ),
                            );
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     backgroundColor: Colors.green,
                            //     content: Text(
                            //       'Further Screen Will be available soon!',
                            //       style: TextStyle(
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //   ),
                            // );
                          },
                          text: 'Skip'.tr,
                          textcolor: Colors.green,
                          colors: [Colors.white, Colors.white],
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
