import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/model/Repo.dart';
import 'package:ndri_climate/model/Weather_Forecast.dart';

class Daily_Forecast extends StatefulWidget {
  final String district;
  final String date;
  Daily_Forecast({super.key, required this.district, required this.date});

  @override
  State<Daily_Forecast> createState() => _Daily_ForecastState();
}

class _Daily_ForecastState extends State<Daily_Forecast> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String Date = '';
  String District = '';
  String _temp = '';
  List<String> finalDate=[];
  bool loading =true;

  late final DateTime time;
  late final String a;
  List<WeatherForecast> _weatherdata = [];

  String formatTime(String dateTime) {
    // Parse the input date and time string
    DateTime parsedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);

    // Format the time in 12-hour format with AM/PM
    String formattedTime = DateFormat('HH:mm').format(parsedDateTime);

    return formattedTime;
  }

  String kelvinToCelsius(double kelvin) {
    // Convert Kelvin to Celsius
    double celsius = kelvin - 273.15;

    // Return the Celsius value as a string, formatted to 2 decimal places
    return celsius.toStringAsFixed(2);
  }

  Future<void> getData() async {
    WeatherResponse _weatherForecastv = await Repo().getweather(District);

    setState(() {
      _weatherdata = _weatherForecastv.list;
      _temp = kelvinToCelsius(_weatherdata.first.main.temp);
      loading=false;
    });
  }

  @override
  void initState() {
    setState(() {
      Date = widget.date;
      finalDate = Date.split(' ');

      District = widget.district;
      time = DateTime.now();
      a = DateFormat('hh:mm a').format(time).toString();
      getData();
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
            title: 'Daily forecast'.tr,
          )),
      body: loading
      ? Center(
        child: CircularProgressIndicator(color: Colors.blue.shade400,)) // Display loader while fetching data
      : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                District.tr,
                style: TextStyle(
                    fontSize: ResponsiveUtils.wp(5),
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                finalDate[0].tr +" "+ finalDate[1] + " "+finalDate[2],
                style: TextStyle(
                    fontSize: ResponsiveUtils.wp(4),
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/128/2469/2469994.png',
                    width: ResponsiveUtils.wp(20),
                    height: ResponsiveUtils.hp(10),
                    fit: BoxFit.cover,
                  ),
                  Text(
                    _temp+'°C',
                    style: TextStyle(
                        fontSize: ResponsiveUtils.wp(9),
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: ResponsiveUtils.wp(25),
                    height: ResponsiveUtils.hp(12),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200),
                    child: Column(
                      children: [
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/128/4005/4005767.png',
                          width: ResponsiveUtils.wp(12),
                    height: ResponsiveUtils.hp(6),
                        ),
                        Text(
                          '${_weatherdata[0].wind.speed} ' +'kmps'.tr,
                          style: TextStyle(
                              fontSize: ResponsiveUtils.wp(2.6),
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                     width: ResponsiveUtils.wp(25),
                    height: ResponsiveUtils.hp(12),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200),
                    child: Column(
                      children: [
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/128/414/414927.png',
                           width: ResponsiveUtils.wp(12),
                    height: ResponsiveUtils.hp(6),
                        ),
                        Text(
                          '${_weatherdata[0].clouds.all}'+'(octa)'.tr,
                          style: TextStyle(
                              fontSize: ResponsiveUtils.wp(2.8),
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                     width: ResponsiveUtils.wp(25),
                    height: ResponsiveUtils.hp(12),
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200),
                    child: Column(
                      children: [
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/128/10271/10271656.png',
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          '${_weatherdata[0].rain?.h3 ??0.0}'+'mm'.tr,
                          style: TextStyle(
                              fontSize: ResponsiveUtils.wp(2.5),
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Today'.tr,
                style: TextStyle(
                    fontSize: ResponsiveUtils.wp(4),
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                    height: ResponsiveUtils.hp(24),
                child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    WeatherForecast _data = _weatherdata[index];
                    String time = formatTime(_data.dtTxt);
                    String temp = kelvinToCelsius(_data.main.temp);
                    return Container(
                      width:ResponsiveUtils.wp(36),
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade200,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.8),
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Image.network(
                            'https://cdn-icons-png.flaticon.com/128/1163/1163657.png',
                            width: ResponsiveUtils.wp(18),
                    height: ResponsiveUtils.hp(8),
                            fit: BoxFit.cover,
                          ),
                          Text(
                            temp + '°C'.tr,
                            style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.8),
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Next Days'.tr,
                style: TextStyle(
                    fontSize: ResponsiveUtils.wp(4),
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: ResponsiveUtils.hp(40),
                decoration: BoxDecoration(
                    color: Colors.lightBlue.shade100,
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    WeatherForecast _data = _weatherdata[index];
                    String tempmax = kelvinToCelsius(_data.main.tempMax);
                    return Container(
                      color: Colors.lightBlue.shade100,
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            days[index].tr,
                            style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.8),
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Image.network(
                            'https://cdn-icons-png.flaticon.com/128/1163/1163657.png',
                            width: ResponsiveUtils.wp(10),
                    height: ResponsiveUtils.hp(5),
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '$tempmax'+'°C'.tr,
                            style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.8),
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<String> days = ['MON', 'TUE', 'WED', 'THUR', 'FRI', 'SAT', 'SUN'];
