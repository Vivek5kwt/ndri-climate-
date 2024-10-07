import 'package:flutter/material.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:ndri_climate/material/reusablecontainer.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 10),
                child: Text(
                  'Climate Resilient Dairy Farming practices'.tr,
                  style: TextStyle(fontSize: ResponsiveUtils.wp(3), fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableContainer(title: 'Impact of climate change on dairy animal', image: 'assets/images/murrah.jpeg', onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => About_Murrah()));
                    },),
                  ReusableContainer(title: 'Feeding Management', image: 'assets/images/feeding_management.jpeg', onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Feeding_management()));
                    },),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableContainer(title:  'Fodder Management', image: 'assets/images/fodder.jpeg', onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Fodder()));
                    },),
                 ReusableContainer(title: 'Health Care Management', image: 'assets/images/healthcare.jpeg', onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Healthcare()));
                    },),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableContainer(title: 'Management Practices', image: 'assets/images/management.jpeg', onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Managemental()));
                    },),
                    ReusableContainer(title: 'Thermal Stress Management', image: 'assets/images/thermal_stress.jpeg', onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Thermal_Stress()));
                    },),
                  
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
