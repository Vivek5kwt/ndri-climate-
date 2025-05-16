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
    final double width = MediaQuery.of(context).size.width;
    final double gridSpacing = ResponsiveUtils.wp(3);

    final double cardWidth = (width - (3 * gridSpacing)) / 2;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size(40, 60),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          show_back_arrow: false,
          title: 'Dairy Animal and Climate Change'.tr,
        ),
      ),
      body: Container(
        color: Colors.white,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: gridSpacing),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: gridSpacing * 2, bottom: gridSpacing / 2),
                child: Text(
                  'Climate Resilient Dairy Farming practices'.tr,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.wp(3.5),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: gridSpacing),
              Wrap(
                spacing: gridSpacing,
                runSpacing: gridSpacing,
                children: [
                  ReusableContainer(
                    width: cardWidth,
                    title: 'Impact of climate change on dairy animal',
                    image: 'assets/images/murrah.webp',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About_Murrah()),
                      );
                    },
                  ),
                  ReusableContainer(
                    width: cardWidth,
                    title: 'Feeding Management',
                    image: 'assets/images/feeding_management.webp',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Feeding_management()),
                      );
                    },
                  ),
                  ReusableContainer(
                    width: cardWidth,
                    title: 'Fodder Management',
                    image: 'assets/images/fodder.webp',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Fodder()),
                      );
                    },
                  ),
                  ReusableContainer(
                    width: cardWidth,
                    title: 'Health Care Management',
                    image: 'assets/images/healthcare.webp',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Healthcare()),
                      );
                    },
                  ),
                  ReusableContainer(
                    width: cardWidth,
                    title: 'Management Practices',
                    image: 'assets/images/management.webp',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Managemental()),
                      );
                    },
                  ),
                  ReusableContainer(
                    width: cardWidth,
                    title: 'Thermal Stress Management',
                    image: 'assets/images/thermal_stress.webp',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Thermal_Stress()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: gridSpacing * 2),
            ],
          ),
        ),
      ),
    );
  }
}
