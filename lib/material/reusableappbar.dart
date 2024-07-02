import 'package:flutter/material.dart';
import 'package:ndri_climate/material/bottom_sheet.dart';

class ReuseAppbar extends StatelessWidget {
  final String title;
  // final String language
  final bool show_back_arrow;
  final Widget? widget;
  final PreferredSizeWidget? bottom;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ReuseAppbar({
    super.key,
    required this.title,
    required this.show_back_arrow,
    this.widget,
    required this.scaffoldKey,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final bgcolor = Color(0xFF2C96D2);
    return AppBar(
        actionsIconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        backgroundColor: bgcolor,
        leading: widget,
        bottom: bottom,
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
                      scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
              // LanguageBottomSheet(selected_language: '');
              },
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
