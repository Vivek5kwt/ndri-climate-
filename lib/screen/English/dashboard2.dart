import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ndri_climate/apiservices/Forecast.dart';
import 'package:ndri_climate/apiservices/api_provider.dart';
import 'package:ndri_climate/material/bottom_sheet.dart';
import 'package:ndri_climate/main.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:ndri_climate/model/Repo.dart';
import 'package:ndri_climate/model/Weather_Forecast.dart';
import 'package:ndri_climate/model/Weather_model.dart';
import 'package:ndri_climate/screen/English/Climate_Services.dart';
import 'package:ndri_climate/screen/English/cattle.dart';
import 'package:ndri_climate/screen/English/consts.dart';
import 'package:ndri_climate/screen/English/Feeding_management.dart';
import 'package:ndri_climate/screen/English/murrahbuffalo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // final WeatherFactory _wf=WeatherFactory(OPENWEATHER_API_KEY);
  // Weather? _weather;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate2) {
      setState(() {
        selectedDate2 = picked;
      });
    }
  }

  WeatherResponse? weatherResponse;
  Weathermodel? weathermodel;
  TextEditingController _stateController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _languageController = TextEditingController();
  List<String> init_distict_list = [];
  ForecastData? _weatherdata;
  String? id = '0';

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        id = value.getString('forecast_id');
      });
      ApiProvider().getWeatherData(id: id.toString()).then((data) {
        // Forecast _forecastdata = Forecast.fromJson(data);
        setState(() {
          _weatherdata = ForecastData.fromJson(data);
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _stateController.dispose();
    _districtController.dispose();
    _languageController.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showStateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      scrollControlDisabledMaxHeightRatio: 0.05,
      builder: (BuildContext context) {
        return StateBottomSheet(
          selected_state: (state) async {
            setState(() {
              _stateController.text = state.tr;
            });
            if (_districtController.text.isNotEmpty) {
              weatherResponse =
                  await Repo().getweather(_districtController.text);
              ApiProvider().storeWeatherData(
                max_temp: weatherResponse?.list[1].main.tempMax ?? 0.0,
                min_temp: weatherResponse?.list[1].main.tempMin ?? 0.0,
                rainfall: weatherResponse?.list[1].rain?.h3 ?? 0.0,
                relative_humidity:
                    weatherResponse?.list[1].main.humidity.toDouble() ?? 0.0,
                wind_speed: weatherResponse?.list[1].wind.speed ?? 0.0,
                wind_direction:
                    weatherResponse?.list[1].wind.deg.toDouble() ?? 0.0,
                cloud_cover:
                    weatherResponse?.list[1].clouds.all.toDouble() ?? 0.0,
                temp_humidity_index:
                    weatherResponse?.list[1].main.humidity.toDouble() ?? 0.0,
              );
            }
          },
          onStateSelected: (state, district) {
            setState(() {
              init_distict_list = district;
            });
          },
        );
      },
    );
  }

  void _showDistrictBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DistrictBottomSheet(
          districts: init_distict_list,
          selected_district: (district) async {
            setState(() {
              _districtController.text = district.tr;
            });
            weatherResponse = await Repo().getweather(district);
            ApiProvider().storeWeatherData(
              max_temp: weatherResponse?.list[1].main.tempMax ?? 0.0,
              min_temp: weatherResponse?.list[1].main.tempMin ?? 0.0,
              rainfall: weatherResponse?.list[1].rain?.h3 ?? 0.0,
              relative_humidity:
                  weatherResponse?.list[1].main.humidity.toDouble() ?? 0.0,
              wind_speed: weatherResponse?.list[1].wind.speed ?? 0.0,
              wind_direction:
                  weatherResponse?.list[1].wind.deg.toDouble() ?? 0.0,
              cloud_cover:
                  weatherResponse?.list[1].clouds.all.toDouble() ?? 0.0,
              temp_humidity_index:
                  weatherResponse?.list[1].main.humidity.toDouble() ?? 0.0,
            );
          },
        );
      },
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LanguageBottomSheet(
          selected_language: (language) async {
            setState(() {
              _languageController.text = language.tr;
              Navigator.pop(context);
            });
            weatherResponse = await Repo().getweather(_districtController.text);
            ApiProvider().storeWeatherData(
              max_temp: weatherResponse?.list[1].main.tempMax ?? 0.0,
              min_temp: weatherResponse?.list[1].main.tempMin ?? 0.0,
              rainfall: weatherResponse?.list[1].rain?.h3 ?? 0.0,
              relative_humidity:
                  weatherResponse?.list[1].main.humidity.toDouble() ?? 0.0,
              wind_speed: weatherResponse?.list[1].wind.speed ?? 0.0,
              wind_direction:
                  weatherResponse?.list[1].wind.deg.toDouble() ?? 0.0,
              cloud_cover:
                  weatherResponse?.list[1].clouds.all.toDouble() ?? 0.0,
              temp_humidity_index:
                  weatherResponse?.list[1].main.humidity.toDouble() ?? 0.0,
            );

//                               Future.delayed(Duration(milliseconds: 800)).then((value) =>              Navigator.pop(context)
// ,);
          },
        );
      },
    );
  }

  void _showStateSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: AlertDialog(
                alignment: Alignment.topCenter,
                contentPadding:
                    EdgeInsets.only(top: 20, bottom: 0, left: 0, right: 0),
                backgroundColor: Color(0xFF2C96D2),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Please Select One'.tr,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                content: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.75),
                                ),
                                width: MediaQuery.of(context).size.width / 1.5,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  keyboardType: TextInputType.none,
                                  validator: (value) {
                                    if (_stateController.text.isEmpty) {
                                      return "This field is Required";
                                    }
                                    return null;
                                  },
                                  controller: _stateController,
                                  readOnly: true,
                                  onTap: () {
                                    _showStateBottomSheet(context);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Select State'.tr,
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                  ),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF878787)),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.75),
                                ),
                                width: MediaQuery.of(context).size.width / 1.5,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  keyboardType: TextInputType.none,
                                  controller: _districtController,
                                  readOnly: true,
                                  validator: (value) {
                                    if (_stateController.text.isEmpty) {
                                      return "Above field is Required";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    _showDistrictBottomSheet(context);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Select District'.tr,
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                  ),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF878787)),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey, width: 0.75),
                                ),
                                width: MediaQuery.of(context).size.width / 1.5,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  keyboardType: TextInputType.none,
                                  readOnly: true,
                                  controller: _languageController,
                                  // validator: (value) {
                                  //   if (_districtController.text.isEmpty&& _stateController.text.isEmpty) {
                                  //     return "Above fields are Required";
                                  //   }
                                  //   return null;

                                  // },
                                  onTap: () async {
                                    if (_formkey.currentState!.validate()) {
                                      _showLanguageBottomSheet(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please select the state and district frist!'),
                                        ),
                                      );
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Select Language'.tr,
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                  ),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF878787)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
          preferredSize: Size(40, 60),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            show_back_arrow: false,
            title: 'Dashboard'.tr,
          )),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: ApiProvider().getWeatherData(id: id.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                );
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 20, left: 30, right: 30, bottom: 5),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Climate services by ICAR-National Dairy Research Institute (NDRI), Karnal'
                            .tr,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                                          image: AssetImage(
                                              'assets/images/buffalo.png'),
                                          fit: BoxFit.cover)),
                                ),
                                Text(
                                  'Murrah Buffalo'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
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
                                            image: AssetImage(
                                                'assets/images/buffalo.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                  Text(
                                    'Cattle'.tr,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Climate_services(
                                            Date1:
                                                '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ',
                                            Date2:
                                                '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                                            District:
                                                '${_districtController.text}',
                                          )));
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
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
                                            image: AssetImage(
                                                'assets/images/forecast.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                  Text(
                                    'Climate Advisory'.tr,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
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
                                          image: AssetImage(
                                              'assets/images/forecast.png'),
                                          fit: BoxFit.cover)),
                                ),
                                Text(
                                  'Daily forecast'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
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
                                          image: AssetImage(
                                              'assets/images/forecast.png'),
                                          fit: BoxFit.cover)),
                                ),
                                Text(
                                  'Past advisories'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
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
                            'Weekly Weather Forecast'.tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 5,
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
                                      InkWell(
                                          onTap: () {
                                            _selectDate1(context);
                                          },
                                          child: Text(
                                            '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF1B3A69),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            _selectDate2(context);
                                          },
                                          child: Text(
                                            '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1B3A69)),
                                          )),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        child: Icon(
                                          Icons.location_pin,
                                          color: Color(0xFF1B3A69),
                                          size: 21,
                                        ),
                                        onTap: () {
                                          _showStateSelectionDialog();
                                          // Navigator.push(context,MaterialPageRoute(builder: (context)=>Dialogue()));
                                        },
                                      ),
                                      Text(
                                        '${_districtController.text.tr}',
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
                            margin: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                                      'Tmax'.tr,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text('Tmin'.tr,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                    Text('Rainfall(mm)'.tr,
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
                                      '${weatherResponse?.list[0].main.tempMax ?? _weatherdata?.maxTemp ?? '0'}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text(
                                        '${weatherResponse?.list[0].main.tempMin ?? _weatherdata?.minTemp ?? '0'}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                    Text(
                                        '${weatherResponse?.list[0].rain?.h3 ?? _weatherdata?.rainfall ?? '0'}',
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
                                      'RH(%)'.tr,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text('Wind Speed(kmph)'.tr,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                    Text('Cloud cover(octa)'.tr,
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
                                      '${weatherResponse?.list[0].main.humidity ?? _weatherdata?.relativeHumidity ?? '0'}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text(
                                        '${weatherResponse?.list[0].wind.speed ?? _weatherdata?.windSpeed ?? '0'}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                    Text(
                                        '${weatherResponse?.list[0].clouds.all ?? _weatherdata?.cloudCover ?? '0'}',
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ' +
                              '${DateFormat('dd-MM-yyyy').format(selectedDate2)} ' +
                              'Climate services for the period of'.tr,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
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
                                    image:
                                        AssetImage('assets/images/murrah.jpeg'),
                                    fit: BoxFit.cover),
                              ),
                              child: Text(
                                'Murrah Buffalo'.tr,
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
                                      builder: (context) =>
                                          const Murrah_buffalo()));
                            },
                          ),
                          InkWell(
                            onTap: () {},
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
                                        'assets/images/sorghum.jpeg'),
                                    fit: BoxFit.cover),
                              ),
                              child: Text(
                                'Major crops'.tr,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Cattle'.tr,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(11),
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
                                        image: AssetImage(
                                            'assets/images/murrah.jpeg'),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Text(
                                    'Cattle'.tr,
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
                                          builder: (context) =>
                                              const Cattle()));
                                },
                              ),
                              InkWell(
                                onTap: () {},
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
                                            'assets/images/sorghum.jpeg'),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Text(
                                    'Major crops'.tr,
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
                  ],
                ),
              );
            }),
      ),
    );
  }
}
