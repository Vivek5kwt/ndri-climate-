import 'package:flutter/material.dart';
import 'package:ndri_climate/screen/English/Climate_Services.dart';
import 'package:get/get.dart';

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
            leading: Icon(Icons.web),
            title: Text('Open Google'.tr),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Open GitHub'.tr),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('Open Documents'.tr),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.file_copy),
            title: Text('Open Important Document'.tr),
            onTap: () {},
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
