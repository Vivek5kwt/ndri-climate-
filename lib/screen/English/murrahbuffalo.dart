import 'package:flutter/material.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:ndri_climate/screen/English/Feeding_management.dart';
import 'package:ndri_climate/screen/English/Fodder_management.dart';
import 'package:ndri_climate/screen/English/Healthcare.dart';
import 'package:ndri_climate/screen/English/Thermal_stress.dart';
import 'package:ndri_climate/screen/English/aboutmuraah.dart';
import 'package:ndri_climate/screen/English/managemental_practices.dart';
import 'package:get/get.dart';

class Murrah_buffalo extends StatelessWidget {
  const Murrah_buffalo({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
          preferredSize: Size(40, 60),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            show_back_arrow: false,
            title: 'Dairy Animal and Climate Change'.tr,
          )),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                'Climate Resilient Dairy Farming practices'.tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => About_Murrah()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.bottomCenter,
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          opacity: 0.7,
                          image: AssetImage('assets/images/murrah.jpeg'),
                          fit: BoxFit.cover),
                    ),
                    child: Text(
                      'Impact of climate change on dairy animal'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.bottomCenter,
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          opacity: 0.7,
                          image: AssetImage(
                              'assets/images/feeding_management.jpeg'),
                          fit: BoxFit.cover),
                    ),
                    child: Text(
                      'Feeding Management'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Feeding_management()));
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Fodder()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(bottom: 10, left: 30, right: 10),
                    alignment: Alignment.bottomCenter,
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          opacity: 0.7,
                          image: AssetImage('assets/images/fodder.jpeg'),
                          fit: BoxFit.cover),
                    ),
                    child: Text(
                      'Fodder Management'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.clip,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(bottom: 10, left: 40, right: 10),
                    alignment: Alignment.bottomCenter,
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          opacity: 0.7,
                          image: AssetImage('assets/images/healthcare.jpeg'),
                          fit: BoxFit.cover),
                    ),
                    child: Text(
                      'Health Care Management'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Healthcare()));
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Managemental()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.bottomCenter,
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          opacity: 0.7,
                          image: AssetImage('assets/images/management.jpeg'),
                          fit: BoxFit.cover),
                    ),
                    child: Text(
                      'Management Practices'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Thermal_Stress()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(bottom: 10, left: 40, right: 10),
                    alignment: Alignment.bottomCenter,
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          opacity: 0.7,
                          image:
                              AssetImage('assets/images/thermal_stress.jpeg'),
                          fit: BoxFit.cover),
                    ),
                    child: Text(
                      'Thermal Stress Management'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
