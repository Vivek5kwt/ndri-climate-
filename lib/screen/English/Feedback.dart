import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndri_climate/apiservices/api_provider.dart';
import 'package:ndri_climate/auth/register_screen.dart';
import 'package:ndri_climate/material/Reusable_textfield.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/plugin.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/screen/English/dashboard2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({
    super.key, 
    });

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _districtcontroller = TextEditingController();
  TextEditingController _mobilenocontroller = TextEditingController();
  TextEditingController _messagecontroller = TextEditingController();
  String name='';
  String mobile='';
  String district='';

   void _getdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? '');
      mobile = (prefs.getString('mobile') ?? '');
      district = (prefs.getString('district') ?? '');
      if(name.isNotEmpty){
      _namecontroller.text=name;
    }
    if(mobile.isNotEmpty){
      _mobilenocontroller.text=mobile;
    }
    if(district.isNotEmpty){
      _districtcontroller.text=district.tr;
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
    super.dispose();
    _mobilenocontroller.dispose();
    _districtcontroller.dispose();
    _namecontroller.dispose();
    _messagecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size(60, 60),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          title: 'Feedback'.tr,
          show_back_arrow: false,
          onBackPress: () => Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterScreen(district: district),))
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Feedback'.tr,
                      style: TextStyle(fontSize: ResponsiveUtils.wp(3), fontWeight: FontWeight.w700,color: Color(0xFF2C96D2)),
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Text(
                  'Name'.tr,
                  style: TextStyle(fontSize: ResponsiveUtils.wp(2.5), fontWeight: FontWeight.w500),
                ),
                ReusableField(
                  controller: _namecontroller,
                  validator:(value) {
                    if (value=='') {
                      return 'This field is required!';
                    }
                  },
                  onChanged: (p0) {
                    name=_namecontroller.text;
                  },
                    lable: 'name',
                    textInputType: TextInputType.name,
                    color: false,
                    hinttextcolor: Colors.black,
                    hinttext: 'Enter Your Name'.tr,
                    CircleBorder: false),
                    SizedBox(height:20,),
                    
                Text(
                  'Phone Number'.tr,
                  style: TextStyle(fontSize: ResponsiveUtils.wp(2.5), fontWeight: FontWeight.w500),
                ),
                ReusableField(
                  controller: _mobilenocontroller,
                    lable: 'phone',
                    textInputType: TextInputType.phone,
                    validator:(value) {
                    if (value=='') {
                      return 'This field is required!';
                    }
                  },
                    color: false,
                    hinttextcolor: Colors.black,
                    hinttext: 'Enter Your Phone number'.tr,
                    CircleBorder: false),
                    SizedBox(height:20,),
                    
                Text(
                  'District'.tr,
                  style: TextStyle(fontSize: ResponsiveUtils.wp(2.5), fontWeight: FontWeight.w500),
                ),
                ReusableField(
                  controller: _districtcontroller,
                    lable: 'District'.tr,
                    validator:(value) {
                    if (value=='') {
                      return 'This field is required!';
                    }
                  },
                    textInputType: TextInputType.text,
                    color: false,
                    hinttextcolor: Colors.black,
                    hinttext: 'Enter Your District'.tr,
                    CircleBorder: false),
                    SizedBox(height:20,),
                Text(
                  'FeedBack/Message'.tr,
                  style: TextStyle(fontSize: ResponsiveUtils.wp(2.5), fontWeight: FontWeight.w500),
                ),
                ReusableField(
                  maxlength: 200,
                  validator:(value) {
                    if (value=='') {
                      return 'This field is required!';
                    }
                  },
                  controller: _messagecontroller,
                  lable: '', textInputType: TextInputType.text, color: false, hinttextcolor: Colors.black, hinttext: 'Write your Feedback here'.tr, CircleBorder: false),
                  SizedBox(height: 30,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: ()async{
                        showDialog(context: context, barrierDismissible: false,builder: (context) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(backgroundColor: Color(0xFF2C96D2),),
                          );
                        },);
                         if (_formkey.currentState!.validate()) {
      await ApiProvider().storeFeedback(customer_name:_namecontroller.text,district: _districtcontroller.text,message: _messagecontroller.text,phone_number: _mobilenocontroller.text ).then((v){
       Navigator.pop(context);
       Plugin.dialogpopup(
     context: context, 
     dialog:'FeedBack Submitted Successfully!',
     onPressed: () {
       Navigator.pop(context);
       _messagecontroller.clear();
              
     },);
      });
    }
    else{
      Navigator.pop(context);
    }
                       
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF2C96D2),
                        ),
                        child: Text('Submit'.tr,
                        style: GoogleFonts.lexend(
                              color: Colors.white,
                              fontSize: ResponsiveUtils.wp(2.5),
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.3),),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
