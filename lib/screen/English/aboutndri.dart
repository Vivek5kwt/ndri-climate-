import 'package:flutter/material.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutNdri extends StatelessWidget {
  const AboutNdri({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          show_back_arrow: false,
          title: 'About NDRI'.tr,
        ),
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.all(18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                      'The National Dairy Research Institute, Karnal, India is a Deemed University under the Indian Council of Agricultural Research of the Ministry of Agriculture and Farmers Welfare, Government of India. The premier ‘Research Institute’ of India in the field of dairy, the National Dairy Research Institute has developed considerable expertise over the last five decades in different areas of Dairy Production, Processing, Management and Human Resource Development.\n\n'
                          .tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text:
                      'Being the National Institute, it conducts basic and applied research with the objective to enhance animal productivity and also to develop cost-effective technologies for the benefit of the millions of the farming community. The Institute has had been continuously working to develop its research and developed as well as human resource development programmes to better serve the nation in terms of food security, employment generation, poverty alleviation and economic prosperity.'
                          .tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
