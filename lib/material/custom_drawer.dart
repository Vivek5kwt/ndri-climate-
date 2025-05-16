import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndri_climate/auth/register_screen.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/screen/English/Climate_Services.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/screen/English/Feeding_management.dart';
import 'package:ndri_climate/screen/English/Healthcare.dart';
import 'package:ndri_climate/screen/English/Thermal_stress.dart';
import 'package:ndri_climate/screen/English/aboutndri.dart';
import 'package:ndri_climate/screen/English/dashboard2.dart';
import 'package:ndri_climate/screen/English/managemental_practices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? district = '';
  String? date1 = '';
  String? date2 = '';
  String? language = '';

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        district = value.getString('district');
        date1 = value.getString('date1');
        date2 = value.getString('date2');
        language = value.getString('language'); // Corrected here
      });
    });
    super.initState();
  }

  Widget buildDrawerIcon(Widget icon) {
    // For responsive icon container
    return Container(
      width: ResponsiveUtils.wp(7.2), // Responsive width
      height: ResponsiveUtils.wp(7.2),
      alignment: Alignment.center,
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sidePadding = ResponsiveUtils.wp(2.5);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF2C96D2),
            ),
            child: Center(
              child: Text(
                'NDRI, Karnal'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveUtils.wp(4.8),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // About NDRI
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: ResponsiveUtils.hp(1)),
            leading: buildDrawerIcon(
                Icon(CupertinoIcons.building_2_fill, size: ResponsiveUtils.wp(6.4))),
            title: Text(
              'About NDRI, Karnal'.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(3.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AboutNdri()));
            },
          ),
          // Home
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: ResponsiveUtils.hp(1)),
            leading: buildDrawerIcon(
                Icon(Icons.home_filled, size: ResponsiveUtils.wp(6.4))),
            title: Text(
              'Home'.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(3.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard(
                          selectdist: district.toString(),
                          selectstate: '',
                          selectlang: language.toString())));
            },
          ),
          // Open Climate Advisory
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: ResponsiveUtils.hp(1)),
            leading: buildDrawerIcon(
                Icon(Icons.cloud, size: ResponsiveUtils.wp(6.4))),
            title: Text(
              'Open Climate Advisory'.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(3.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Climate_services(Date1: date1.toString(),Date2: date2.toString(), District: district.toString(),title: 'Climate Services'.tr,Language: language!,)));
            },
          ),
          // Feeding Management
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: ResponsiveUtils.hp(1)),
            leading: buildDrawerIcon(
              ImageIcon(
                NetworkImage('https://cdn-icons-png.flaticon.com/128/16686/16686199.png'),
                size: ResponsiveUtils.wp(6.4),
              ),
            ),
            title: Text(
              'Feeding Management'.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(3.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Feeding_management()));
            },
          ),
          // Health Care Management
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: ResponsiveUtils.hp(1)),
            leading: buildDrawerIcon(
              ImageIcon(
                NetworkImage('https://cdn-icons-png.flaticon.com/128/16924/16924841.png'),
                size: ResponsiveUtils.wp(6.4),
              ),
            ),
            title: Text(
              'Health Care Management'.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(3.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Healthcare()));
            },
          ),
          // Management Practices
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: ResponsiveUtils.hp(1)),
            leading: buildDrawerIcon(
              ImageIcon(
                NetworkImage('https://cdn-icons-png.flaticon.com/128/7521/7521598.png'),
                size: ResponsiveUtils.wp(6.4),
              ),
            ),
            title: Text(
              'Management Practices'.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(3.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Managemental()));
            },
          ),
          // Thermal Stress Management
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: ResponsiveUtils.hp(1)),
            leading: buildDrawerIcon(
              ImageIcon(
                NetworkImage('https://cdn-icons-png.flaticon.com/128/10414/10414431.png'),
                size: ResponsiveUtils.wp(6.4),
              ),
            ),
            title: Text(
              'Thermal Stress Management'.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(3.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Thermal_Stress()));
            },
          ),
          // Feedback
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: ResponsiveUtils.hp(1)),
            leading: buildDrawerIcon(
              ImageIcon(
                NetworkImage('https://cdn-icons-png.flaticon.com/128/17276/17276633.png'),
                size: ResponsiveUtils.wp(6.4),
              ),
            ),
            title: Text(
              'Feedback'.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(3.4),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(district: district.toString())));
            },
          ),
          SizedBox(height: ResponsiveUtils.hp(2)),
        ],
      ),
    );
  }
}
