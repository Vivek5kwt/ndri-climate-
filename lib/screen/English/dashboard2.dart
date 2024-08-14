import 'package:adaptive_pop_scope/adaptive_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ndri_climate/apiservices/api_provider.dart';
import 'package:ndri_climate/material/bottom_sheet.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:ndri_climate/model/Repo.dart';
import 'package:ndri_climate/model/Weather_Forecast.dart';
import 'package:ndri_climate/screen/English/Climate_Services.dart';
import 'package:ndri_climate/screen/English/daily_forecast.dart';
import 'package:ndri_climate/screen/English/murrahbuffalo.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/screen/English/parmukh_faslein.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final String selectdist;
  final String selectstate;

  const Dashboard(
      {super.key, required this.selectdist, required this.selectstate});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Weather? _weather;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now().add(Duration(days: 7));
  WeatherResponse? weatherResponse;
  WeatherMetrics weatherMetrics = WeatherMetrics();

  // Weathermodel? weathermodel;
  TextEditingController _stateController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _languageController = TextEditingController();
  List<String> init_distict_list = [];
  String? id = '0';
  Map<String, dynamic> ranges = {};
  Repo _repo = Repo();

  Future<void> _selectDate1(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
        selectedDate2 = selectedDate1.add(Duration(days: 7));
        _prefs.setString('date1', DateFormat('dd-MM-yyyy').format(selectedDate1).toString());
        _prefs.setString('date2', DateFormat('dd-MM-yyyy').format(selectedDate2).toString());
      });
    }
  }

  void calculateRanges(List<Map<String, dynamic>> dailyData) {
    final tempMinValues = dailyData.map((day) => day['temp_min']).toList();
    final tempMaxValues = dailyData.map((day) => day['temp_max']).toList();
    final humidityValues = dailyData.map((day) => day['humidity']).toList();
    final cloudCoverValues = dailyData.map((day) => day['clouds']).toList();
    final precipitationValues = dailyData.map((day) => day['rain']).toList();
    final windSpeedValues = dailyData.map((day) => day['wind_speed']).toList();
    final windDirectionValues =
        dailyData.map((day) => day['wind_direction']).toList();
    final rainfallValues = dailyData.map((day) => day['rainfall']).toList();
    final THIValues = dailyData.map((day) => day['THI']).toList();
    final RHValues = dailyData.map((day) => day['RH']).toList();

    setState(() {
      ranges = {
        'Temperature Min': [
          tempMinValues.reduce((a, b) => a < b ? a : b),
          tempMinValues.reduce((a, b) => a > b ? a : b)
        ],
        'Temperature Max': [
          tempMaxValues.reduce((a, b) => a < b ? a : b),
          tempMaxValues.reduce((a, b) => a > b ? a : b)
        ],
        'Humidity': [
          humidityValues.reduce((a, b) => a < b ? a : b),
          humidityValues.reduce((a, b) => a > b ? a : b)
        ],
        'Cloud Cover': [
          cloudCoverValues.reduce((a, b) => a < b ? a : b),
          cloudCoverValues.reduce((a, b) => a > b ? a : b)
        ],
        'Wind Speed': [
          windSpeedValues.reduce((a, b) => a < b ? a : b),
          windSpeedValues.reduce((a, b) => a > b ? a : b)
        ],
        'Precipitation': [
          precipitationValues.reduce((a, b) => a < b ? a : b),
          precipitationValues.reduce((a, b) => a > b ? a : b)
        ],
        'Wind Direction': [
          windDirectionValues.reduce((a, b) => a < b ? a : b),
          windDirectionValues.reduce((a, b) => a > b ? a : b)
        ],
        'Rainfall': [
          rainfallValues.reduce((a, b) => a < b ? a : b),
          rainfallValues.reduce((a, b) => a > b ? a : b)
        ],
        'THI': [
          THIValues.reduce((a, b) => a < b ? a : b),
          THIValues.reduce((a, b) => a > b ? a : b)
        ],
        'RH': [
          RHValues.reduce((a, b) => a < b ? a : b),
          RHValues.reduce((a, b) => a > b ? a : b)
        ],
      };
      ApiProvider().storeWeatherData(
                District: _districtController.text,
                max_temp_high: ranges['Temperature Max'][1].ceil(),
                max_temp_low: ranges['Temperature Max'][0].ceil(),
                min_temp_high: ranges['Temperature Min'][1].ceil(),
                min_temp_low: ranges['Temperature Min'][0].ceil(),
                rainfall_high: ranges['Rainfall'][1].ceil(),
                rainfall_low: ranges['Rainfall'][0].ceil(),
                relative_humidity_high: ranges['RH'][1].ceil(),
                relative_humidity_low: ranges['RH'][0].ceil(),
                wind_speed_high: ranges['Wind Speed'][1].ceil(),
                wind_speed_low: ranges['Wind Speed'][0].ceil(),
                wind_direction_high: ranges['Wind Direction'][1].ceil(),
                wind_direction_low: ranges['Wind Direction'][0].ceil(),
                cloud_cover_high: ranges['Cloud Cover'][1].ceil(),
                cloud_cover_low: ranges['Cloud Cover'][0].ceil(),
                temp_humidity_index_high: ranges['THI'][1].ceil(),
                temp_humidity_index_low: ranges['THI'][0].ceil(),
              );
    });
  }

  void getweather() async {
    _repo.fetchWeatherData(district: _districtController.text).then((data) {
      calculateRanges(data ?? [{}]);
    });
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        id = value.getString('forecast_id');
        value.setString('date1', DateFormat('dd-MM-yyyy').format(selectedDate1).toString());
        value.setString('date2', DateFormat('dd-MM-yyyy').format(selectedDate2).toString());
      });
      // ApiProvider().getWeatherData(id: id.toString()).then((data) {
        
      //   setState(() {
      //     _weatherdata = ForecastData.fromJson(data ?? {});
      //   });
      // });

      if (widget.selectstate.isNotEmpty || widget.selectdist.isNotEmpty) {
        setState(() {
          _districtController.text = widget.selectdist;
          _stateController.text = widget.selectstate;
          getweather();
        });
      }
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
                 District: _districtController.text,
            max_temp_high:ranges['Temperature Max'][1].ceil() ,
            max_temp_low:ranges['Temperature Max'][0].ceil() ,
            min_temp_high: ranges['Temperature Min'][1].ceil(),
            min_temp_low: ranges['Temperature Min'][0].ceil(),
            rainfall_high: ranges['Rainfall'][1].ceil(),
            rainfall_low: ranges['Rainfall'][0].ceil(),
            relative_humidity_high: ranges['RH'][1].ceil(),
            relative_humidity_low:ranges['RH'][0].ceil() ,
            wind_speed_high:ranges['Wind Speed'][1].ceil() ,
            wind_speed_low:ranges['Wind Speed'][0].ceil() ,
            wind_direction_high: ranges['Wind Direction'][1].ceil(),
            wind_direction_low: ranges['Wind Direction'][0].ceil(),
            cloud_cover_high: ranges['Cloud Cover'][1].ceil(),
            cloud_cover_low:ranges['Cloud Cover'][0].ceil() ,
            temp_humidity_index_high:ranges['THI'][1].ceil(),
            temp_humidity_index_low:ranges['THI'][0].ceil() ,
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
              // Navigator.pop(context);
            });
            weatherResponse = await Repo().getweather(_districtController.text);
          await  ApiProvider().storeWeatherData(
            District: _districtController.text,
            max_temp_high:ranges['Temperature Max'][1].ceil() ,
            max_temp_low:ranges['Temperature Max'][0].ceil() ,
            min_temp_high: ranges['Temperature Min'][1].ceil(),
            min_temp_low: ranges['Temperature Min'][0].ceil(),
            rainfall_high: ranges['Rainfall'][1].ceil(),
            rainfall_low: ranges['Rainfall'][0].ceil(),
            relative_humidity_high: ranges['RH'][1].ceil(),
            relative_humidity_low:ranges['RH'][0].ceil() ,
            wind_speed_high:ranges['Wind Speed'][1].ceil() ,
            wind_speed_low:ranges['Wind Speed'][0].ceil() ,
            wind_direction_high: ranges['Wind Direction'][1].ceil(),
            wind_direction_low: ranges['Wind Direction'][0].ceil(),
            cloud_cover_high: ranges['Cloud Cover'][1].ceil(),
            cloud_cover_low:ranges['Cloud Cover'][0].ceil() ,
            temp_humidity_index_high:ranges['THI'][1].ceil(),
            temp_humidity_index_low:ranges['THI'][0].ceil() ,
            );
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
                title: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Please Select One'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          ),
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white,),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
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

  Future<bool> _showExitConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (context) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              alignment: Alignment.topCenter,
              contentPadding:
                  EdgeInsets.only(top: 20, bottom: 0, left: 0, right: 0),
              backgroundColor: Color(0xFF2C96D2),
              title: Text(
                'Exit Confirmation',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              content: Text(
                'Are you sure you want to Exit?',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () => SystemNavigator.pop(), // Confirm
                  child: Text('Yes',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Cancel
                  child: Text('No',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePopScope(
      onWillPop: _showExitConfirmationDialog,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        drawer: CustomDrawer(
         
        ),
        appBar: PreferredSize(
            preferredSize: Size(40, 60),
            child: ReuseAppbar(
              onTap: () {
                setState(() {
                   _showLanguageBottomSheet(context);
                });
              },
              scaffoldKey: _scaffoldKey,
              show_back_arrow: false,
              title: 'Dashboard'.tr,
            )),
        body: ranges.isNotEmpty
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 0),
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
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
                              padding: EdgeInsets.only(top: 0),
                              width: 146,
                              height: 114,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xFFABABAB),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Murrah_buffalo()));
                                    },
                                    child: Container(
                                      width: 126,
                                      height: 77,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/buffalo.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    'Dairy Animal and Climate Change'.tr,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Climate_services(
                                              Date1:
                                                  '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ',
                                              Date2:
                                                  '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                                              District:
                                                  '${_districtController.text}',
                                                  title: 'Climate Advisory'.tr,
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
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Daily_Forecast(district:'${_districtController.text}' , date:'${DateFormat('MMMM dd, yyyy').format(selectedDate1)}' ),));
                              },
                              child: Container(
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
                        height: 180,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ' +
                                                  '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF1B3A69),
                                                  fontWeight:
                                                      FontWeight.w600),
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
                              height: 73,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF1B3A69),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              color: Colors.white)),
                                      Text('THI'.tr,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${ranges['Temperature Max'][0].ceil() ?? 0.0} - ${ranges['Temperature Max'][1].ceil() ?? 0.0}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                      Text(
                                          '${ranges['Temperature Min'][0].ceil() ?? 0.0} - ${ranges['Temperature Min'][1].ceil() ?? 0.0}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      Text(
                                          '${ranges['Rainfall'][0].ceil() ?? 0.0} - ${ranges['Rainfall'][1].ceil() ?? 0.0}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      Text(
                                          '${ranges['THI'][0].ceil() ?? 0.0} - ${ranges['THI'][1].ceil() ?? 0.0}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              color: Colors.white)),
                                      Text('Wind Direction (Degree)'.tr,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${ranges['RH'][0] ?? 0.0} - ${ranges['RH'][1] ?? 0.0}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                      Text(
                                          '${ranges['Wind Speed'][0].ceil() ?? 0.0} - ${ranges['Wind Speed'][1].ceil() ?? 0.0}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      Text(
                                          '${ranges['Cloud Cover'][0] ?? 0.0} - ${ranges['Cloud Cover'][1] ?? 0.0}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      Text(
                                          '${ranges['Wind Direction'][0].ceil() ?? 0.0} - ${ranges['Wind Direction'][1].ceil() ?? 0.0}',
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
                        height: MediaQuery.of(context).size.height/1.823,
                      decoration: ShapeDecoration(shape: RoundedRectangleBorder(),image: DecorationImage(image: 
                      AssetImage('assets/images/agri.jpg',),
                      fit: BoxFit.cover,
                      opacity: 0.5
                      )),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Text(
                                  'Climate services for the period of '.tr +
                                      ' ${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ' +
                                      '${DateFormat('dd-MM-yyyy').format(selectedDate2)} ',
                                  style: TextStyle(
                                    color: Colors.black,
                                      fontSize: 14, fontWeight: FontWeight.w600),
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
                                      height: 170,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            filterQuality: FilterQuality.high,
                                            opacity: 0.8,
                                            image: AssetImage(
                                                'assets/images/murrah.jpeg'),
                                            fit: BoxFit.cover),
                                      ),
                                      child: Text(
                                        'Dairy Animal'.tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
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
                                              builder: (context) =>
                                                  Climate_services(
                                                    Date1:
                                                        '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ',
                                                    Date2:
                                                        '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                                                    District:
                                                        '${_districtController.text}',
                                                        title: 'Dairy Animal'.tr,
                                                  )));
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Major_crops(
                                                     Date1:
                                                        '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ',
                                                    Date2:
                                                        '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                                                    District:
                                                        '${_districtController.text}',
                                                  )));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 15),
                                        alignment: Alignment.bottomCenter,
                                        height: 170,
                                        width: 170,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              filterQuality: FilterQuality.high,
                                              opacity: 0.8,
                                              image: AssetImage(
                                                  'assets/images/sorghum.jpeg'),
                                              fit: BoxFit.cover),
                                        ),
                                        child: Text(
                                          'Major crops'.tr,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height / 1.2,
                child:
                    Center(child: CircularProgressIndicator.adaptive())),
      ),
    );
  }
}
