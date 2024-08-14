import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/material/bottom_sheet.dart';
// import 'package:ndri_climate/model/Repo.dart';
import 'package:ndri_climate/model/Weather_Forecast.dart';
import 'package:ndri_climate/screen/English/dashboard2.dart';

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
  // Repo _repo = Repo();
  WeatherMetrics weatherMetrics= WeatherMetrics();
  
  
   void calculateRanges(List<Map<String, dynamic>> dailyData) {
    final tempMinValues = dailyData.map((day) => day['temp_min']).toList();
    final tempMaxValues = dailyData.map((day) => day['temp_max']).toList();
    final humidityValues = dailyData.map((day) => day['humidity']).toList();
    final cloudCoverValues = dailyData.map((day) => day['clouds']).toList();
    final windSpeedValues = dailyData.map((day) => day['wind_speed']).toList();
    final precipitationValues = dailyData.map((day) => day['rain']).toList();
    final windDirectionValues = dailyData.map((day) => day['wind_direction']).toList();
    final rainfallValues = dailyData.map((day) => day['rainfall']).toList();
    final THIValues = dailyData.map((day) => day['THI']).toList();
    final RHValues = dailyData.map((day) => day['RH']).toList();

    setState(() {
      ranges = {
        'Temperature Min': [tempMinValues.reduce((a, b) => a < b ? a : b), tempMinValues.reduce((a, b) => a > b ? a : b)],
        'Temperature Max': [tempMaxValues.reduce((a, b) => a < b ? a : b), tempMaxValues.reduce((a, b) => a > b ? a : b)],
        'Humidity': [humidityValues.reduce((a, b) => a < b ? a : b), humidityValues.reduce((a, b) => a > b ? a : b)],
        'Cloud Cover': [cloudCoverValues.reduce((a, b) => a < b ? a : b), cloudCoverValues.reduce((a, b) => a > b ? a : b)],
        'Wind Speed': [windSpeedValues.reduce((a, b) => a < b ? a : b), windSpeedValues.reduce((a, b) => a > b ? a : b)],
        'Precipitation': [precipitationValues.reduce((a, b) => a < b ? a : b), precipitationValues.reduce((a, b) => a > b ? a : b)],
        'Wind Direction': [windDirectionValues.reduce((a, b) => a < b ? a : b), windDirectionValues.reduce((a, b) => a > b ? a : b)],
        'Rainfall': [rainfallValues.reduce((a, b) => a < b ? a : b), rainfallValues.reduce((a, b) => a > b ? a : b)],
        'THI': [THIValues.reduce((a, b) => a < b ? a : b), THIValues.reduce((a, b) => a > b ? a : b)],
        'RH': [RHValues.reduce((a, b) => a < b ? a : b), RHValues.reduce((a, b) => a > b ? a : b)],
      };
    });
  }

  // void getweather(){
  //   _repo.fetchWeatherData(district: _districtController.text).then((data){
  //     calculateRanges(data);
  //   });
  // }

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
            setState(() {
              _districtController.text = district;
            });
            if (_districtController.text.isNotEmpty) {
              // weatherMetrics =await _repo.fetchWeatherData(district: _districtController.text);
              
            }
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
WidgetsBinding.instance.addPostFrameCallback((v){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard(
    selectdist: _districtController.text,
    selectstate: _stateController.text,)));
});
            });
            // weatherMetrics =await _repo.fetchWeatherData(district: _districtController.text);

          }
            );

//                               Future.delayed(Duration(milliseconds: 800)).then((value) =>              Navigator.pop(context)
// ,);
          },
        );
      }    
  Widget _buildStateSelectionDialog() {
    return AlertDialog(
      alignment: Alignment.topCenter,
      contentPadding: EdgeInsets.only(top: 20, bottom: 0, left: 0, right: 0),
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
                      if (_formkey.currentState!.validate()) {
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
    );
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
            margin: EdgeInsets.symmetric(vertical: 35),
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 50),
                      alignment: Alignment.center,
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topRight,
                              colors: [Colors.white70, Colors.white]),
                          shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icon/logo1.png',
                        scale: 1.25,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'राष्ट्रीय डेरी अनुसंधान संस्थान द्वारा जलवायु सेवाएं',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 45),
                      alignment: Alignment.center,
                      child: Text(
                        'NDRI CLIMATE SERVICES',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                    ),
                    _buildStateSelectionDialog(),
                    Container(
                      margin: EdgeInsets.only(top: 50),
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