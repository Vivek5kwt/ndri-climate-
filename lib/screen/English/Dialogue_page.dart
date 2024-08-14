
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/material/bottom_sheet.dart';
import 'package:ndri_climate/model/Repo.dart';
import 'package:ndri_climate/model/Weather_Forecast.dart';
import 'package:ndri_climate/screen/English/dashboard2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dialogue_page extends StatefulWidget {
  const Dialogue_page({super.key});
  @override
  State<Dialogue_page> createState() => _Dialogue_pageState();
}

class _Dialogue_pageState extends State<Dialogue_page> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _languageController = TextEditingController();
  List<String> init_distict_list = [];
  //  bool _dialogShown = false;
  Map<String, dynamic> ranges = {};
  Repo _repo = Repo();
  WeatherMetrics weatherMetrics = WeatherMetrics();

  void calculateRanges(List<Map<String, dynamic>> dailyData) {
    final tempMinValues = dailyData.map((day) => day['temp_min']).toList();
    final tempMaxValues = dailyData.map((day) => day['temp_max']).toList();
    final humidityValues = dailyData.map((day) => day['humidity']).toList();
    final cloudCoverValues = dailyData.map((day) => day['clouds']).toList();
    final windSpeedValues = dailyData.map((day) => day['wind_speed']).toList();
    final precipitationValues = dailyData.map((day) => day['rain']).toList();
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
    });
  }

  void getweather(String dis){
    _repo.fetchWeatherData(district: dis).then((data){
      calculateRanges(data ?? [{}]);
    });
    return null;
    
  }

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

              // weatherMetrics =await _repo.fetchWeatherData(district: _districtController.text);
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
    getweather(district);
            // Future.delayed(Duration(milliseconds: 1000));
            SharedPreferences _prefs = await SharedPreferences.getInstance();
            setState(() {
              _districtController.text = district;
            });
              _prefs.setString('district', _districtController.text);
              // await ApiProvider().storeWeatherData(
              //   District: _districtController.text,
              //   max_temp_high: ranges['Temperature Max'][1].ceil(),
              //   max_temp_low: ranges['Temperature Max'][0].ceil(),
              //   min_temp_high: ranges['Temperature Min'][1].ceil(),
              //   min_temp_low: ranges['Temperature Min'][0].ceil(),
              //   rainfall_high: ranges['Rainfall'][1].ceil(),
              //   rainfall_low: ranges['Rainfall'][0].ceil(),
              //   relative_humidity_high: ranges['RH'][1].ceil(),
              //   relative_humidity_low: ranges['RH'][0].ceil(),
              //   wind_speed_high: ranges['Wind Speed'][1].ceil(),
              //   wind_speed_low: ranges['Wind Speed'][0].ceil(),
              //   wind_direction_high: ranges['Wind Direction'][1].ceil(),
              //   wind_direction_low: ranges['Wind Direction'][0].ceil(),
              //   cloud_cover_high: ranges['Cloud Cover'][1].ceil(),
              //   cloud_cover_low: ranges['Cloud Cover'][0].ceil(),
              //   temp_humidity_index_high: ranges['THI'][1].ceil(),
              //   temp_humidity_index_low: ranges['THI'][0].ceil(),
              // );
            
          },
        );
      },
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LanguageBottomSheet(selected_language: (language) async {
          setState(() {
            _languageController.text = language.tr;
            WidgetsBinding.instance.addPostFrameCallback((v) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard(
                            selectdist: _districtController.text,
                            selectstate: _stateController.text,
                          )));
            });
          });
         
        });

//
// ,);
      },
    );
  }


  

  Widget _buildStateSelectionDialog() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: AlertDialog(
        alignment: Alignment.topCenter,
        contentPadding: EdgeInsets.only(top: 10, bottom: 0, left: 0, right: 0),
        backgroundColor: Color(0xFF2C96D2),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Please Select One'.tr,
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {},
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
                      border: Border.all(color: Colors.grey, width: 0.75),
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
                      border: Border.all(color: Colors.grey, width: 0.75),
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
                      border: Border.all(color: Colors.grey, width: 0.75),
                    ),
                    width: MediaQuery.of(context).size.width / 1.5,
                    alignment: Alignment.center,
                    child: TextFormField(
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      controller: _languageController,
                      onTap: () async {
                        if (_formkey.currentState!.validate() && _districtController.text.isNotEmpty) {
                          _showLanguageBottomSheet(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please select the state and district first!'),
                            ),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Select Language'.tr,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(),
              image: DecorationImage(
                  filterQuality: FilterQuality.high,
                  opacity: 0.4,
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(vertical: 18),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.center,
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topRight,
                              colors: [Colors.white70, Colors.white]),
                          shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icon/logo1.png',
                        scale: 1.75,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'राष्ट्रीय डेरी अनुसंधान संस्थान द्वारा जलवायु सेवाएं',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      child: Text(
                        'NDRI CLIMATE SERVICES',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                    ),
                    _buildStateSelectionDialog(),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Image.asset(
                        'assets/icon/logo2.png',
                        scale: 1.6,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Image.asset(
                        'assets/images/text1.png',
                        scale: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/images/text2.png',
                        scale: 1.1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
