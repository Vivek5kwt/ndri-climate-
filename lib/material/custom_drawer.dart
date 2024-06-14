import 'package:flutter/material.dart';

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
              'Custom Drawer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.web),
            title: Text('Open Google'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Open GitHub'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('Open Documents'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.file_copy),
            title: Text('Open Important Document'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.terminal),
            title: Text('Open Terminal'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Shut Down'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
