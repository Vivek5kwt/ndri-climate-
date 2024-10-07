import 'package:flutter/material.dart';
import 'package:ndri_climate/material/bottom_sheet.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReuseAppbar extends StatefulWidget {
  final String title;
  // final String language
  final bool show_back_arrow;
  final Widget? widget;
  final PreferredSizeWidget? bottom;
  final Function()? onTap;
  final Function(String)? onselected;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onBackPress; //

  ReuseAppbar({
    super.key,
    required this.title,
    required this.show_back_arrow,
    this.widget,
    required this.scaffoldKey,
    this.bottom,  this.onTap, this.onBackPress, this.onselected,
  });

  @override
  State<ReuseAppbar> createState() => _ReuseAppbarState();
}

class _ReuseAppbarState extends State<ReuseAppbar> {


void  _showLanguageBottomSheet(BuildContext context) async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LanguageBottomSheet(
          selected_language: (language) async {
            setState(() {
              _prefs.setString('language', language);
            });
           if (widget.onselected!=null) {
            widget.onselected!(language);
             
           }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgcolor = Color(0xFF2C96D2);
    return AppBar(
      centerTitle: true,
        actionsIconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        backgroundColor: bgcolor,
        leading: widget.show_back_arrow? IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: widget.onBackPress?? ()=>Navigator.pop(context),):null,
        bottom: widget.bottom,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 20,
                    ),
                    onTap: () {
                      widget.scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: ResponsiveUtils.wp(2.7),
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap:(){_showLanguageBottomSheet(context);},
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icon/translate.png'),
                        fit: BoxFit.cover)),
              ),
            )
          ],
        ));
  }
}
