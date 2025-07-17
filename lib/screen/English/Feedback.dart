import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndri_climate/apiservices/api_provider.dart';
import 'package:ndri_climate/auth/register_screen.dart';
import 'package:ndri_climate/material/Reusable_textfield.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/plugin.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:ndri_climate/screen/English/dashboard2.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _districtcontroller = TextEditingController();
  final TextEditingController _mobilenocontroller = TextEditingController();
  final TextEditingController _messagecontroller = TextEditingController();
  String name = '';
  String mobile = '';
  String district = '';
  String state = '';
  String language = '';
  void _getdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? '');
      mobile = (prefs.getString('mobile') ?? '');
      district = (prefs.getString('district') ?? '');
      state = (prefs.getString('selected_state') ?? '');
      language = (prefs.getString('selected_lang') ?? '');
      if (name.isNotEmpty) {
        _namecontroller.text = name;
      }
      if (mobile.isNotEmpty) {
        _mobilenocontroller.text = mobile;
      }
      if (district.isNotEmpty) {
        _districtcontroller.text = district.tr;
      }
    });
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  void dispose() {
    _mobilenocontroller.dispose();
    _districtcontroller.dispose();
    _namecontroller.dispose();
    _messagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ResponsiveUtils.hp(7)),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          title: 'Feedback'.tr,
          show_back_arrow: false,
          onBackPress: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterScreen(district: district),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(5), vertical: ResponsiveUtils.hp(2)),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Feedback'.tr,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(4.5),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C96D2),
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveUtils.hp(2.5)),
                _buildLabel('Name'.tr),
                ReusableField(
                  controller: _namecontroller,
                  validator: (value) {
                    if (value == '') {
                      return 'This field is required!';
                    }
                    return null;
                  },
                  onChanged: (p0) {
                    name = _namecontroller.text;
                  },
                  lable: 'name',
                  textInputType: TextInputType.name,
                  color: false,
                  hinttextcolor: Colors.black,
                  hinttext: 'Enter Your Name'.tr,
                  CircleBorder: false,
                ),
                SizedBox(height: ResponsiveUtils.hp(2)),
                _buildLabel('Phone Number'.tr),
                ReusableField(
                  controller: _mobilenocontroller,
                  lable: 'phone',
                  textInputType: TextInputType.phone,
                  validator: (value) {
                    if (value == '') {
                      return 'This field is required!';
                    }
                    return null;
                  },
                  color: false,
                  hinttextcolor: Colors.black,
                  hinttext: 'Enter Your Phone number'.tr,
                  CircleBorder: false,
                ),
                SizedBox(height: ResponsiveUtils.hp(2)),
                _buildLabel('District'.tr),
                ReusableField(
                  controller: _districtcontroller,
                  lable: 'District'.tr,
                  validator: (value) {
                    if (value == '') {
                      return 'This field is required!';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                  color: false,
                  hinttextcolor: Colors.black,
                  hinttext: 'Enter Your District'.tr,
                  CircleBorder: false,
                ),
                SizedBox(height: ResponsiveUtils.hp(2)),
                _buildLabel('FeedBack/Message'.tr),
                ReusableField(
                  maxlength: 200,
                  validator: (value) {
                    if (value == '') {
                      return 'This field is required!';
                    }
                    return null;
                  },
                  controller: _messagecontroller,
                  lable: '',
                  textInputType: TextInputType.text,
                  color: false,
                  hinttextcolor: Colors.black,
                  hinttext: 'Write your Feedback here'.tr,
                  CircleBorder: false,
                ),
                SizedBox(height: ResponsiveUtils.hp(3)),
                Center(
                  child: InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Color(0xFF2C96D2),
                            ),
                          );
                        },
                      );
                      if (_formkey.currentState!.validate()) {
                        await ApiProvider()
                            .storeFeedback(
                            customerName: _namecontroller.text,
                            district: _districtcontroller.text,
                            message: _messagecontroller.text,
                            phoneNumber: _mobilenocontroller.text)
                            .then((v) {
                          Navigator.pop(context);
                          Plugin.dialogpopup(
                            context: context,
                            dialog: 'FeedBack Submitted Successfully!'.tr,
                            onPressed: () {
                              _messagecontroller.clear();
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Dashboard(
                                    selectDist: district,
                                    selectState: state,
                                    selectLang: language,
                                  ),
                                ),
                              );
                            },
                          );
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: ResponsiveUtils.wp(25),
                      height: ResponsiveUtils.hp(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF2C96D2),
                      ),
                      child: Text(
                        'Submit'.tr,
                        style: GoogleFonts.lexend(
                          color: Colors.white,
                          fontSize: ResponsiveUtils.wp(3.5),
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(0.5)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: ResponsiveUtils.wp(3.2),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
