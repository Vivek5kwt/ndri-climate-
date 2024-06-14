import 'package:flutter/material.dart';
import 'package:ndri_climate/main.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:ndri_climate/screen/Feeding_management.dart';
import 'package:ndri_climate/screen/Healthcare.dart';

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
            title: 'Murrah Buffalo',
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
                'Climate Resillient Murrah Buffalo Rearing practices',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                      'Murrah Buffalo',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
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
                        'Feeding Management',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
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
                  Container(
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
                      'Fodder Management',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
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
                        'Health Care Management ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
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
                  Container(
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
                      'Management Practices',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  Container(
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
                      'Thermal Stress Management ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
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
