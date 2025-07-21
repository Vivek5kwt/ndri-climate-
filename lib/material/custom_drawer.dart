import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'network_icon.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? district = '';
  String? state = '';
  String? language = '';
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now().add(Duration(days: 7));

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        district = prefs.getString('selected_dist') ?? '';
        state = prefs.getString('selected_state') ?? '';
        language = prefs.getString('selected_lang') ?? '';
      });
    });
  }

  Widget buildDrawerIcon(Widget icon) {
    return Container(
      width: ResponsiveUtils.wp(8),
      height: ResponsiveUtils.wp(8),
      alignment: Alignment.center,
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sidePadding = ResponsiveUtils.wp(3);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: ResponsiveUtils.hp(25),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.webp'),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2C96D2).withOpacity(0.8), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: ResponsiveUtils.wp(15),
                      height: ResponsiveUtils.wp(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                          image: AssetImage('assets/images/app_logo.webp'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.hp(1)),
                    Text(
                      'NDRI, Karnal'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveUtils.wp(5),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildDrawerItem(
            icon: Icon(CupertinoIcons.building_2_fill, size: ResponsiveUtils.wp(6), color: Color(0xFF2C96D2)),
            title: 'About NDRI, Karnal'.tr,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AboutNdri()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icon(Icons.home_filled, size: ResponsiveUtils.wp(6), color: Color(0xFF2C96D2)),
            title: 'Home'.tr,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(
                    selectDist: district.toString(),
                    selectState: state.toString(),
                    selectLang: language.toString(),
                  ),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icon(Icons.cloud, size: ResponsiveUtils.wp(6), color: Color(0xFF2C96D2)),
            title: 'Open Climate Advisory'.tr,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClimateServices(
                    date1: '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ',
                    date2: '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                    initialDistrict: district.toString(),
                    title: 'Climate Services'.tr,
                    initialLanguage: language!, initialState: state.toString(),
                  ),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: NetworkIcon(
              url: 'https://cdn-icons-png.flaticon.com/128/16686/16686199.png',
              size: ResponsiveUtils.wp(6),
              color: const Color(0xFF2C96D2),
            ),
            title: 'Feeding Management'.tr,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Feeding_management()),
              );
            },
          ),
          _buildDrawerItem(
            icon: NetworkIcon(
              url: 'https://cdn-icons-png.flaticon.com/128/16924/16924841.png',
              size: ResponsiveUtils.wp(6),
              color: const Color(0xFF2C96D2),
            ),
            title: 'Health Care Management'.tr,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Healthcare()),
              );
            },
          ),
          _buildDrawerItem(
            icon: NetworkIcon(
              url: 'https://cdn-icons-png.flaticon.com/128/7521/7521598.png',
              size: ResponsiveUtils.wp(6),
              color: const Color(0xFF2C96D2),
            ),
            title: 'Management Practices'.tr,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Managemental()),
              );
            },
          ),
          _buildDrawerItem(
            icon: NetworkIcon(
              url: 'https://cdn-icons-png.flaticon.com/128/10414/10414431.png',
              size: ResponsiveUtils.wp(6),
              color: const Color(0xFF2C96D2),
            ),
            title: 'Thermal Stress Management'.tr,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Thermal_Stress()),
              );
            },
          ),
          _buildDrawerItem(
            icon: NetworkIcon(
              url: 'https://cdn-icons-png.flaticon.com/128/17276/17276633.png',
              size: ResponsiveUtils.wp(6),
              color: const Color(0xFF2C96D2),
            ),
            title: 'Feedback'.tr,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen(district: district.toString())),
              );
            },
          ),
          SizedBox(height: ResponsiveUtils.hp(2)),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required Widget icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xFF2C96D2), width: 3),
          top: BorderSide(color: Colors.grey.shade300, width: 0.5),
          bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.wp(3),
          vertical: ResponsiveUtils.hp(1),
        ),
        leading: buildDrawerIcon(icon),
        title: Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveUtils.wp(3.5),
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
