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
   Major_crops({super.key, required this.Date1, required this.Date2, required this.District});

  @override
  State<Major_crops> createState() => _Major_cropsState();
}

class _Major_cropsState extends State<Major_crops> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String first_date = '';
  String second_date = '';
  String district = '';


  @override
  void initState() {
    setState(() {
      first_date = widget.Date1;
      second_date = widget.Date2;
      district =widget.District;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
          preferredSize: Size(40, 60),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            show_back_arrow: false,
            title: 'Major crops'.tr,
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 61,
                padding: EdgeInsets.all(20),
                color: Color(0xFF9BDBFF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Color(0xFF1B3A69),
                            size: 21,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$first_date-$second_date',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.wp(2.3),
                              color: Color(0xFF1B3A69),
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Color(0xFF1B3A69),
                            size: 21,
                          ),
                          Text(
                            district.tr,
                            style: TextStyle(
                              fontSize: ResponsiveUtils.wp(2.5),
                              color: Color(0xFF1B3A69),
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
        
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WEATHER SUMMARY'.tr,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.wp(2.8),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.',
                      style:
                          TextStyle(fontSize: ResponsiveUtils.wp(2.7), fontWeight: FontWeight.w500),
                    )
                  ],
                )),
                Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 2,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),

                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ADVISORY SERVICES FOR MAJOR CROPS'.tr,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.wp(2.8),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.',
                      style:
                          TextStyle(fontSize: ResponsiveUtils.wp(2.5), fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
                SizedBox(height: 30,),
             InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(district: district),));
              },
               child: Chip(
                color: WidgetStateProperty.all(Color(0xFF2C96D2)),
                label: Text('Feedback',style: TextStyle(
                fontSize: ResponsiveUtils.wp(3),fontWeight: FontWeight.bold,color: Colors.white
               ),)),
             )
          ],
        ),
      ),
    );
  }
}
