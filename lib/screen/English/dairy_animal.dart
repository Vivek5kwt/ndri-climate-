import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/auth/register_screen.dart';

class DairyAnimal extends StatefulWidget {
  final String date1;
  final String date2;

  const DairyAnimal({
    Key? key,
    required this.date1,
    required this.date2,
  }) : super(key: key);

  @override
  _DairyAnimalState createState() => _DairyAnimalState();
}

class _DairyAnimalState extends State<DairyAnimal> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _district = '---';

  @override
  void initState() {
    super.initState();
    _loadDistrict();
  }

  Future<void> _loadDistrict() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _district = prefs.getString('selected_dist') ?? '---';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive sizing
    ScreenUtil.init(
      context,
      designSize: Size(360, 690),
      minTextAdapt: true,
    );

    final dateRange = '${widget.date1} - ${widget.date2}';

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: ReuseAppbar(
        scaffoldKey: _scaffoldKey,
        show_back_arrow: false,
        title: 'Dairy Animal'.tr,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top bar with date and district
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Color(0xFF9BDBFF),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, size: 20.sp, color: Color(0xFF1B3A69)),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      dateRange,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B3A69),
                      ),
                    ),
                  ),
                  Icon(Icons.location_on, size: 20.sp, color: Color(0xFF1B3A69)),
                  SizedBox(width: 4.w),
                  Text(
                    _district.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B3A69),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Weather Summary card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weather Summary/Warning:'.tr,
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'The weather is likely to remain dry in the coming days in the district area. Maximum temperature is likely to be 38°C-43°C, minimum temperature is likely to be 24°C-26°C and temperature humidity index is likely to be 68.22 to 87.47.\n\nAs per IMD forecast, the temperature is likely to be comfortable and based on the calculated temperature humidity index, the environment for dairy animals will be comfortable to moderately stressful.',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Climate Advisory card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Climate Advisory for Dairy Animal'.tr,
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Due to changing weather and rising temperature during the day, animals should be kept in sheds with fans during the scorching heat of the day. Clean the shed and surrounding area to avoid infestation of house flies and others. To keep the animal healthy, give 50 grams of iodised salt and 50 to 100 grams of mineral mixture daily along with adequate concentrates and green fodder. Provide adequate clean, fresh and cool drinking water to keep the animals hydrated. Ensure bathing of buffaloes at least twice a day to reduce heat load on animals. Look for signs of mastitis in lactating animals and treat it immediately. Pregnant animals (more than 6 months) should be given extra feed.',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Feedback button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterScreen(district: _district)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                ),
                child: Text('Feedback'.tr, style: TextStyle(fontSize: 14.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
