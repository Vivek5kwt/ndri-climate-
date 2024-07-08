import 'package:flutter/material.dart';
import 'package:ndri_climate/screen/English/Climate_Services.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/screen/English/Feeding_management.dart';
import 'package:ndri_climate/screen/English/Healthcare.dart';
import 'package:ndri_climate/screen/English/Thermal_stress.dart';
import 'package:ndri_climate/screen/English/managemental_practices.dart';

class CustomDrawer extends StatelessWidget {
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
              'Custom Drawer'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text('Open Climate Advisory'.tr),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Climate_services(Date1: '',Date2: '', District: '',)));
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
            leading: Icon(Icons.terminal),
            title: Text('Open Terminal'.tr),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Shut Down'.tr),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
