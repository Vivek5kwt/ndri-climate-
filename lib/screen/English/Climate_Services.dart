import 'package:flutter/material.dart';
import 'package:ndri_climate/apiservices/advisory.dart';
import 'package:ndri_climate/apiservices/api_provider.dart';
import 'package:ndri_climate/auth/register_screen.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Climate_services extends StatefulWidget {
  final String Date1;
  final String Date2;
  final String District;
  final String Language;
  final String title;

  Climate_services({
    super.key,
    required this.Date1,
    required this.Date2,
    required this.District,
    required this.title,
    required this.Language,
  });

  @override
  State<Climate_services> createState() => _Climate_servicesState();
}

class _Climate_servicesState extends State<Climate_services> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String firstDate = '';
  String secondDate = '';
  String district = '';
  String language = '';
  List<Advisory> advisoryData = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    firstDate = widget.Date1;
    secondDate = widget.Date2;
    district = widget.District;
    SharedPreferences.getInstance().then((v) {
      setState(() {
        language = v.getString('language') ?? widget.Language;
      });
    });
    _fetchAdvisoryData();
  }

  void _fetchAdvisoryData() async {
    try {
      final response = await ApiProvider().fetchAdvisory();
      setState(() {
        advisoryData = response.reversed.toList();
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          show_back_arrow: false,
          title: widget.title.tr,
          onselected: (lang) {
            setState(() {
              language = lang;
            });
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 1.sw,
            height: 55.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            color: const Color(0xFF9BDBFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.calendar_month,
                  color: const Color(0xFF1B3A69),
                  size: 22.sp,
                ),
                SizedBox(width: 5.w),
                Text(
                  '$firstDate $secondDate',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF1B3A69),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: const Color(0xFF1B3A69),
                      size: 22.sp,
                    ),
                    Text(
                      district.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF1B3A69),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator.adaptive())
                : hasError
                ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Text(
                  'Error fetching data',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
                : advisoryData.isEmpty
                ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Text(
                  'No data found',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
              itemCount: advisoryData.length,
              itemBuilder: (context, index) {
                Advisory advisory = advisoryData[index];
                String description;

                switch (language.toLowerCase()) {
                  case 'hindi':
                  case 'हिंदी':
                  case 'ਹਿੰਦੀ':
                  case 'হিন্দি':
                    description = advisory.descriptionHi;
                    break;
                  case 'english':
                  case 'अंग्रेज़ी':
                  case 'ਅੰਗਰੇਜ਼ੀ':
                  case 'ইংরেজি':
                    description = advisory.descriptionEn;
                    break;
                  case 'bengali':
                  case 'বেঙ্গলি':
                  case 'বাঙালি':
                  case 'বাংলা':
                    description = advisory.descriptionBn;
                    break;
                  case 'punjabi':
                  case 'ਪੰਜਾਬੀ':
                  case 'पंजाबी':
                  case 'পাঞ্জাবি':
                    description = advisory.descriptionPa;
                    break;
                  default:
                    description = advisory.descriptionEn;
                    break;
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 1.sw,
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 8.h),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            advisory.title,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index == advisoryData.length - 1)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RegisterScreen(district: district),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding:
                          EdgeInsets.symmetric(vertical: 5.h),
                          child: Chip(
                            backgroundColor: Colors.transparent,
                            label: Text(
                              'Feedback'.tr,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2C96D2),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
