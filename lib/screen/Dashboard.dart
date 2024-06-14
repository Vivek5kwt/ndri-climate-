import 'package:flutter/material.dart';
import 'package:ndri_climate/main.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:ndri_climate/screen/Feeding_management.dart';
import 'package:ndri_climate/screen/murrahbuffalo.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
          preferredSize: Size(40, 60),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            show_back_arrow: false,
            title: 'Dashboard',
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.topCenter,
              child: Text(
                'Climate Services by ICAR-National Dairy Research Institute (NDRI), Karnal',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 10, bottom: 10, left: 25, right: 10),
                    padding: EdgeInsets.only(top: 10),
                    width: 146,
                    height: 113,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFABABAB),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          width: 126,
                          height: 77,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/buffalo.png'),
                                  fit: BoxFit.cover)),
                        ),
                        Text(
                          'Murrah Buffalo',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 146,
                    height: 113,
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFABABAB),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          width: 126,
                          height: 77,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/forecast.png'),
                                  fit: BoxFit.cover)),
                        ),
                        Text(
                          'Daily Forecast',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(top: 10),
                    width: 146,
                    height: 113,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFABABAB),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          width: 126,
                          height: 77,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/forecast.png'),
                                  fit: BoxFit.cover)),
                        ),
                        Text(
                          'Past Actr ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Color(0xFF9BDBFF),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              height: 152,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'WEEKLY WEATHER FORECAST',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 10),
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                '22 Jun, 2022 - 28 Jun, 2022',
                                style: TextStyle(
                                  fontSize: 14,
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
                                'Jind',
                                style: TextStyle(
                                  fontSize: 14,
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
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 390,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1B3A69),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tmax(°c):',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text('Tmin(°c):',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                            Text('Rainfall(mm):',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '8.5-16.3',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text('30.0-306',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                            Text('1-6',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tmax(°c):',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text('Tmin(°c):',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                            Text('Rainfall(mm):',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '8.5-16.3',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text('30.0-306',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                            Text('1-6',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  '22 Jun,2022 - 28 Jun, 2022 Climate Services for the Period of',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                )),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                            opacity: 0.9,
                            image: AssetImage('assets/images/murrah.jpeg'),
                            fit: BoxFit.cover),
                      ),
                      child: Text(
                        'Murrah Buffalo',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Murrah_buffalo()));
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Feeding_management()));
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
                            opacity: 0.9,
                            image: AssetImage(
                                'assets/images/feeding_management.jpeg'),
                            fit: BoxFit.cover),
                      ),
                      child: Text(
                        'Feeding Management',
                        style: TextStyle(
                            fontSize: 14,
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
