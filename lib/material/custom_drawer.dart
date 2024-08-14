import 'package:flutter/material.dart';
import 'package:ndri_climate/auth/register_screen.dart';
import 'package:ndri_climate/screen/English/Climate_Services.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/screen/English/Feeding_management.dart';
import 'package:ndri_climate/screen/English/Healthcare.dart';
import 'package:ndri_climate/screen/English/Thermal_stress.dart';
import 'package:ndri_climate/screen/English/dashboard2.dart';
import 'package:ndri_climate/screen/English/managemental_practices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}
class _CustomDrawerState extends State<CustomDrawer> {
  String? district = '';
  String? date1='';
  String? date2='';


  @override
  void initState() {
   SharedPreferences.getInstance().then((value) {
      setState(() {
        district = value.getString('district');
        date1=value.getString('date1');
        date2=value.getString('date2');

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'NDRI, Karnal'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text('Home'.tr),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(selectdist: district.toString(), selectstate: '')));
            },
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text('Open Climate Advisory'.tr),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Climate_services(Date1: date1.toString(),Date2: date2.toString(), District: district.toString(),title: 'Climate Services'.tr,)));
            },
          ),
          ListTile(
            leading: ImageIcon(NetworkImage('https://cdn-icons-png.flaticon.com/128/16686/16686199.png')),
            title: Text('Feeding Management'.tr),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Feeding_management()));
            },
          ),
          ListTile(
            leading: ImageIcon(NetworkImage('https://cdn-icons-png.flaticon.com/128/16924/16924841.png')),
            title: Text('Health Care Management'.tr),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Healthcare()));
            },
          ),
          ListTile(
            leading: ImageIcon(NetworkImage('https://cdn-icons-png.flaticon.com/128/7521/7521598.png')),
            title: Text('Management Practices'.tr),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Managemental()));
            },
          ),
          ListTile(
            leading: ImageIcon(NetworkImage('https://cdn-icons-png.flaticon.com/128/10414/10414431.png')),
            title: Text('Thermal Stress Management'.tr),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Thermal_Stress()));
            },
          ),
          ListTile(
            leading: ImageIcon(NetworkImage('https://cdn-icons-png.flaticon.com/128/17276/17276633.png')),
            title: Text('Feedback'.tr),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen(district:district.toString() ,)));
            },
          ),
        ],
      ),
    );
  }
}
