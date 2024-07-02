import 'package:flutter/material.dart';
import 'package:ndri_climate/main.dart';
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
            show_back_arrow: true,
            title: 'Murrah Buffalo'.tr,
          )),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Climate Resillient Murrah Buffalo Rearing practices'.tr,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>About_Murrah()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.bottomCenter,
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            filterQuality: FilterQuality.high,
                            opacity: 0.8,
                            image: AssetImage('assets/images/murrah.jpeg'),
                            fit: BoxFit.cover),
                      ),
                      child: Text(
                        'Murrah Buffalo'.tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.bottomCenter,
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            filterQuality: FilterQuality.high,
                            opacity: 0.8,
                            image: AssetImage(
                                'assets/images/feeding_management.jpeg'),
                            fit: BoxFit.cover),
                      ),
                      child: Text(
                        'Feeding Management'.tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Feeding_management()));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Fodder()));
                    },

                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.bottomCenter,
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            filterQuality: FilterQuality.high,
                            opacity: 0.8,
                            image: AssetImage('assets/images/fodder.jpeg'),
                            fit: BoxFit.cover),
                      ),
                      child: Text(
                        'Fodder Management'.tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 40, right: 10),
                      alignment: Alignment.bottomCenter,
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            filterQuality: FilterQuality.high,
                            opacity: 0.8,
                            image: AssetImage('assets/images/healthcare.jpeg'),
                            fit: BoxFit.cover),
                      ),
                      child: Text(
                        'Health Care Management'.tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Healthcare()));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Managemental()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.bottomCenter,
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            filterQuality: FilterQuality.high,
                            opacity: 0.8,
                            image: AssetImage('assets/images/management.jpeg'),
                            fit: BoxFit.cover),
                      ),
                      child: Text(
                        'Management Practices'.tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Thermal_Stress()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 40, right: 10),
                      alignment: Alignment.bottomCenter,
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            filterQuality: FilterQuality.high,
                            opacity: 0.8,
                            image:
                                AssetImage('assets/images/thermal_stress.jpeg'),
                            fit: BoxFit.cover),
                      ),
                      child: Text(
                        'Thermal Stress Management'.tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
