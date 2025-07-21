import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/material/bottom_sheet.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/model/Repo.dart';
import 'package:ndri_climate/model/Weather_Forecast.dart';
import 'package:ndri_climate/screen/English/dashboard2.dart';
import '../../material/asset_image_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dialogue_page extends StatefulWidget {
  const Dialogue_page({super.key});

  @override
  State<Dialogue_page> createState() => _Dialogue_pageState();
}

class _Dialogue_pageState extends State<Dialogue_page> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  List<String> init_distict_list = [];
  Map<String, dynamic> ranges = {};
  final Repo _repo = Repo();
  final WeatherMetrics weatherMetrics = WeatherMetrics();

  void calculateRanges(List<Map<String, dynamic>> dailyData) {
    if (dailyData.isEmpty || dailyData[0].isEmpty) return;

    final tempMinValues = dailyData.map((day) => day['temp_min'] as num).toList();
    final tempMaxValues = dailyData.map((day) => day['temp_max'] as num).toList();
    final humidityValues = dailyData.map((day) => day['humidity'] as num).toList();
    final cloudCoverValues = dailyData.map((day) => day['clouds'] as num).toList();
    final windSpeedValues = dailyData.map((day) => day['wind_speed'] as num).toList();
    final precipitationValues = dailyData.map((day) => day['rain'] as num).toList();
    final windDirectionValues = dailyData.map((day) => day['wind_direction'] as num).toList();
    final rainfallValues = dailyData.map((day) => day['rainfall'] as num).toList();
    final THIValues = dailyData.map((day) => day['THI'] as num).toList();
    final RHValues = dailyData.map((day) => day['RH'] as num).toList();

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

  void getweather(String dis) {
    _repo.fetchWeatherData(district: dis).then((data) {
      calculateRanges(data ?? [{}]);
    });
    return;
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
            SharedPreferences _prefs = await SharedPreferences.getInstance();
            setState(() {
              _districtController.text = district;
            });
            _prefs.setString('district', _districtController.text);
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
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          setState(() {
            _languageController.text = language.tr;
            _prefs.setString('language', _languageController.text);
          });
          Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(
                  selectDist: _districtController.text,
                  selectState: _stateController.text,
                  selectLang: _languageController.text,
                ),
              ),
            );
          });
        });
      },
    );
  }


  Widget _buildStateSelectionDialog() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(2)),
      child: AlertDialog(
        alignment: Alignment.topCenter,
        contentPadding: EdgeInsets.only(top: 10.h, bottom: 0, left: 0, right: 0),
        backgroundColor: Color(0xFF2C96D2),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Please Select One'.tr,
              style: TextStyle(color: Colors.white, fontSize: ResponsiveUtils.wp(3.5)),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: Container(
          padding: EdgeInsets.all(20.w),
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
                  _responsiveTextFormField(
                    context,
                    controller: _stateController,
                    hintText: 'Select State'.tr,
                    validatorMsg: "This field is Required",
                    onTap: () => _showStateBottomSheet(context),
                  ),
                  SizedBox(height: ResponsiveUtils.hp(1.5)),
                  _responsiveTextFormField(
                    context,
                    controller: _districtController,
                    hintText: 'Select District'.tr,
                    validatorMsg: "Above field is Required",
                    onTap: () => _showDistrictBottomSheet(context),
                  ),
                  SizedBox(height: ResponsiveUtils.hp(1.5)),
                  _responsiveTextFormField(
                    context,
                    controller: _languageController,
                    hintText: 'Select Language'.tr,
                    validatorMsg: "Select fields first",
                    onTap: () {
                      if (_stateController.text.trim().isEmpty || _districtController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select the state and district first!'),
                          ),
                        );
                      } else {
                        _showLanguageBottomSheet(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _responsiveTextFormField(BuildContext context,
      {required TextEditingController controller,
        required String hintText,
        required String validatorMsg,
        required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 0.75),
      ),
      width: MediaQuery.of(context).size.width / 1.5,
      alignment: Alignment.center,
      child: TextFormField(
        keyboardType: TextInputType.none,
        controller: controller,
        readOnly: true,
        validator: (value) {
          if (controller.text.isEmpty) {
            return validatorMsg;
          }
          return null;
        },
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        ),
        style: TextStyle(
          fontSize: ResponsiveUtils.wp(3.7),
          fontWeight: FontWeight.w400,
          color: Color(0xFF878787),
        ),
      ),
    );
  }

  Widget _buildResponsiveImage(String assetPath, double heightPercentage) {
    return AssetImageLoader(
      assetPath: assetPath,
      height: ResponsiveUtils.hp(heightPercentage),
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(),
                image: DecorationImage(
                  filterQuality: FilterQuality.high,
                  opacity: 0.4,
                  image: AssetImage('assets/images/background.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(2)),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: ResponsiveUtils.hp(1), bottom: ResponsiveUtils.hp(2)),
                          alignment: Alignment.center,
                          height: ResponsiveUtils.hp(14),
                          width: ResponsiveUtils.wp(30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topRight,
                              colors: [Colors.white70, Colors.white],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: AssetImageLoader(
                            assetPath: 'assets/icon/logo1.webp',
                            fit: BoxFit.contain,
                            width: ResponsiveUtils.wp(20),
                            height: ResponsiveUtils.hp(10),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            'राष्ट्रीय डेरी अनुसंधान संस्थान द्वारा जलवायु सेवाएं',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.wp(5),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.hp(1)),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            'NDRI CLIMATE SERVICES',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.wp(5.5),
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.hp(2)),
                        _buildStateSelectionDialog(),
                        _buildResponsiveImage('assets/icon/logo2.webp', 16),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'भाकृअनुप-राष्ट्रीय डेरी अनुसंधान संस्थान,\nकरनाल - 132001, हरियाणा',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.wp(3.5),
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'ICAR - National Dairy Research Institute\nKarnal - 132001, Haryana',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.wp(3.5),
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: ResponsiveUtils.hp(2.5)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
