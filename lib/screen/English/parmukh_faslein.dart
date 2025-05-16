import 'package:flutter/material.dart';
import 'package:ndri_climate/auth/register_screen.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';

class Major_crops extends StatefulWidget {
  final String Date1;
  final String Date2;
  final String District;
  const Major_crops({super.key, required this.Date1, required this.Date2, required this.District});

  @override
  State<Major_crops> createState() => _Major_cropsState();
}

class _Major_cropsState extends State<Major_crops> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String first_date;
  late String second_date;
  late String district;

  @override
  void initState() {
    first_date = widget.Date1;
    second_date = widget.Date2;
    district = widget.District;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double sidePadding = ResponsiveUtils.wp(3);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size(40, 60),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          show_back_arrow: false,
          title: 'Major crops'.tr,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF9BDBFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 8,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_month, color: Color(0xFF1B3A69), size: 21),
                      const SizedBox(width: 6),
                      Text(
                        '$first_date - $second_date',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(2.2),
                          color: const Color(0xFF1B3A69),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_pin, color: Color(0xFF1B3A69), size: 21),
                      const SizedBox(width: 4),
                      Text(
                        district.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(2.3),
                          color: const Color(0xFF1B3A69),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: ResponsiveUtils.hp(2)),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 14),
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WEATHER SUMMARY'.tr,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(2.7),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.hp(1)),
                  Text(
                    'Due to the dry weather, farmers can irrigate the moong crop as per the crop requirement. Weeds are a big problem during the first 4-5 weeks of sowing. Therefore, weeding should be done within 15-20 days of sowing.'.tr,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(2.2),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 18),
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ADVISORY SERVICES FOR MAJOR CROPS'.tr,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(2.7),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.hp(1)),
                  Text(
                    'Due to the dry weather, farmers can irrigate the moong crop as per the crop requirement. Weeds are a big problem during the first 4-5 weeks of sowing. Therefore, weeding should be done within 15-20 days of sowing.'.tr,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(2.1),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(district: district),
                    ),
                  );
                },
                child: Chip(
                  color: WidgetStateProperty.all(const Color(0xFF2C96D2)),
                  label: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(3),
                      vertical: ResponsiveUtils.hp(0.8),
                    ),
                    child: Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.wp(2.4),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(2)),
          ],
        ),
      ),
    );
  }
}
