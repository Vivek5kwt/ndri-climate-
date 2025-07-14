import 'package:flutter/material.dart';
import 'package:ndri_climate/material/bottom_sheet.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReuseAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool show_back_arrow;
  final Widget? widget;
  final PreferredSizeWidget? bottom;
  final Function()? onTap;
  final Function(String)? onselected;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onBackPress;

  ReuseAppbar({
    super.key,
    required this.title,
    required this.show_back_arrow,
    this.widget,
    required this.scaffoldKey,
    this.bottom,
    this.onTap,
    this.onBackPress,
    this.onselected,
  });

  @override
  State<ReuseAppbar> createState() => _ReuseAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(
    bottom == null
        ? kToolbarHeight
        : kToolbarHeight + bottom!.preferredSize.height,
  );
}

class _ReuseAppbarState extends State<ReuseAppbar> {
  void _showLanguageBottomSheet(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LanguageBottomSheet(
          selected_language: (language) async {
            setState(() {
              _prefs.setString('language', language);
            });
            if (widget.onselected != null) {
              widget.onselected!(language);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color bgcolor = const Color(0xFF2C96D2);

    final double iconSize = ResponsiveUtils.wp(6); // roughly 24px at 400px width
    final double sidePadding = ResponsiveUtils.wp(2.5);

    return AppBar(
      backgroundColor: bgcolor,
      elevation: 4, // slight shadow for depth
      automaticallyImplyLeading: false,
      bottom: widget.bottom,
      centerTitle: true,
      titleSpacing: 0, // remove default left padding
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12),
        ),
      ),
      leading: widget.show_back_arrow
          ? IconButton(
        icon: Icon(Icons.arrow_back_ios, size: iconSize, color: Colors.white),
        onPressed: widget.onBackPress ?? () => Navigator.pop(context),
      )
          : null,
      title: Row(
        children: [
          // Menu Icon without extra leading space
          InkWell(
            borderRadius: BorderRadius.circular(iconSize),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sidePadding),
              child: Icon(Icons.menu, color: Colors.white, size: iconSize),
            ),
            onTap: () {
              widget.scaffoldKey.currentState?.openDrawer();
            },
          ),
          // Expanded title centered
          Expanded(
            child: Text(
              widget.title.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(4),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          // Language Icon
          InkWell(
            borderRadius: BorderRadius.circular(iconSize),
            onTap: () {
              _showLanguageBottomSheet(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sidePadding),
              child: SizedBox(
                width: iconSize,
                height: iconSize,
                child: Image.asset(
                  'assets/icon/translate.webp',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
