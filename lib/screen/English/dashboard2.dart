import 'dart:convert';
import 'package:adaptive_pop_scope/adaptive_pop_scope.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:ndri_climate/material/bottom_sheet.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:ndri_climate/material/reusablecontainer.dart';
import 'package:ndri_climate/screen/English/Climate_Services.dart';
import 'package:ndri_climate/screen/English/PastAdvisories.dart';
import 'package:ndri_climate/screen/English/murrahbuffalo.dart';
import 'package:ndri_climate/screen/English/parmukh_faslein.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final String selectdist;
  final String selectstate;
  final String selectlang;

  const Dashboard({
    super.key,
    required this.selectdist,
    required this.selectstate,
    required this.selectlang,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now().add(Duration(days: 7));

  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();

  bool loading = true;
  ForecastDetail? _forecast;

  List<String> init_distict_list = [];

  @override
  void initState() {
    super.initState();
    print('sdsdkskjd ${widget.selectdist}');
    _districtController.text = widget.selectdist;
    _stateController.text = widget.selectstate;
    _languageController.text = widget.selectlang;
    fetchAndSetForecast();
  }

  @override
  void dispose() {
    _stateController.dispose();
    _districtController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
        selectedDate2 = selectedDate1.add(Duration(days: 7));
      });
    }
  }

  Future<void> fetchAndSetForecast() async {
    setState(() => loading = true);
    final id = await _findIdForDistrict(_districtController.text);
    if (id != null) {
      final detail = await _getDetailById(id);
      setState(() {
        _forecast = detail;
        loading = false;
      });
    } else {
      setState(() {
        _forecast = null;
        loading = false;
      });
    }
  }

  Future<String?> _findIdForDistrict(String district) async {
    String? next = 'https://ndri.ampleteckdev.com/api/forecasts?page=';
    print('sdnsdjsjdfj ${next}');
    final wanted = district.trim().toLowerCase();
    print('sdnsdjsjdfj ${wanted}');
    while (next != null) {
      final r = await http.get(Uri.parse(next), headers: {'Accept': 'application/json'});
      if (r.statusCode != 200) break;
      final j = jsonDecode(r.body);
      for (final item in (j['data'] as List)) {
        if ((item['district'] ?? '').toString().toLowerCase() == wanted) {
          return item['id'].toString();
        }
      }
      next = j['next_page_url'];
    }
    return null;
  }

  Future<ForecastDetail?> _getDetailById(String id) async {
    final url = Uri.parse('https://ndri.ampleteckdev.com/api/forecasts/$id');

    final res = await http.get(url, headers: {'Accept': 'application/json'});
    if (res.statusCode == 200) {
      final dec = jsonDecode(res.body);
      final payload = dec is Map && dec.containsKey('data') ? dec['data'] : dec;
      return ForecastDetail.fromJson(payload);
    }
    return null;
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
          contentPadding: EdgeInsets.only(top: 20, bottom: 0, left: 0, right: 0),
          backgroundColor: Color(0xFF2C96D2),
          title: Text(
            'Exit Confirmation',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Are you sure you want to Exit?',
            style: TextStyle(fontSize: ResponsiveUtils.wp(3), color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: Text('Yes', style: TextStyle(fontSize: ResponsiveUtils.wp(2.8), color: Colors.white)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No', style: TextStyle(fontSize: ResponsiveUtils.wp(2.8), color: Colors.white)),
            ),
          ],
        ),
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePopScope(
      onWillPop: _showExitConfirmationDialog,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size(40, 60),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            show_back_arrow: false,
            title: 'Dashboard'.tr,
          ),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator.adaptive())
            : _forecast == null
            ? Center(child: Text('No data available'))
            : _dashboardBody(),
      ),
    );
  }

  Widget _dashboardBody() => Container(
    width: double.infinity,
    color: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8, left: 30, right: 30, bottom: 5),
            alignment: Alignment.topCenter,
            child: Text(
              'Climate services by ICAR-National Dairy Research Institute (NDRI), Karnal'.tr,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(2.8),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                topcontainer('Dairy Animal and Climate Change', 'assets/images/buffalo.webp', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Murrah_buffalo()));
                }),
                topcontainer('Climate Advisory', 'assets/images/forecast.webp', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Climate_services(
                        Date1: '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ',
                        Date2: '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                        District: '${_districtController.text}',
                        title: 'Climate Advisory'.tr,
                        Language: _languageController.text,
                      ),
                    ),
                  );
                }),
                topcontainer('Past advisories', 'assets/images/forecast.webp', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Past_Advisories(
                        Date1: '${DateFormat('dd-MM-yyyy').format(selectedDate1)}',
                        Date2: '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                        District: '${_districtController.text}',
                        title: 'Past advisories'.tr,
                        Language: _languageController.text,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Color(0xFF9BDBFF),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Weekly Weather Forecast'.tr,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.wp(2.8),
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF005fa3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976d2),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade100,
                            blurRadius: 12,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        (_forecast?.district ?? widget.selectdist).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: ResponsiveUtils.wp(2.5),
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _row('Max Temp', '${_forecast?.maxTempHigh} / ${_forecast?.maxTempLow} °C', Icons.thermostat),
                        _row('Min Temp', '${_forecast?.minTempHigh} / ${_forecast?.minTempLow} °C', Icons.ac_unit),
                        _row('Rainfall', '${_forecast?.rainfallHigh} – ${_forecast?.rainfallLow} mm', Icons.grain),
                        _row('Humidity', '${_forecast?.relativeHumidityHigh}% – ${_forecast?.relativeHumidityLow}%', Icons.water_drop),
                        _row('Wind Speed', '${_forecast?.windSpeedHigh} – ${_forecast?.windSpeedLow} km/h', Icons.wind_power),
                        _row('Wind Dir', '${_forecast?.windDirectionHigh} – ${_forecast?.windDirectionLow}°', Icons.rotate_right),
                        _row('Cloud Cover', '${_forecast?.cloudCoverHigh} – ${_forecast?.cloudCoverLow} octa', Icons.filter_drama),
                        _row('THI', '${_forecast?.tempHumidityIndexHigh} – ${_forecast?.tempHumidityIndexLow}', Icons.device_thermostat),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.823,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(),
              image: DecorationImage(
                image: AssetImage('assets/images/agri.webp'),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Climate services for the period of '.tr +
                        ' ${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ' +
                        '${DateFormat('dd-MM-yyyy').format(selectedDate2)} ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ResponsiveUtils.wp(2.8),
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ReusableContainer(
                        title: 'Dairy Animal',
                        image: 'assets/images/murrah.webp',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Climate_services(
                                    Date1: '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ',
                                    Date2: '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                                    District: '${_districtController.text}',
                                    title: 'Dairy Animal'.tr,
                                    Language: _languageController.text,
                                  )));
                        },
                      ),
                      ReusableContainer(
                        title: 'Major crops',
                        image: 'assets/images/sorghum.webp',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Major_crops(
                                    Date1: '${DateFormat('dd-MM-yyyy').format(selectedDate1)} - ',
                                    Date2: '${DateFormat('dd-MM-yyyy').format(selectedDate2)}',
                                    District: '${_districtController.text}',
                                  )));
                        },
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
  );

  Widget topcontainer(String Title, String Image, Function() onTap) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
      padding: EdgeInsets.only(top: 0),
      width: ResponsiveUtils.wp(38),
      height: ResponsiveUtils.hp(14),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xFFABABAB)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: ResponsiveUtils.wp(30),
              height: ResponsiveUtils.hp(10),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Image), fit: BoxFit.cover),
              ),
            ),
          ),
          AutoSizeText(
            overflow: TextOverflow.ellipsis,
            maxFontSize: 12,
            maxLines: 2,
            minFontSize: 10,
            textAlign: TextAlign.center,
            Title.tr,
            style: TextStyle(fontSize: ResponsiveUtils.wp(2.2), fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String val, IconData icon) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.5),
    child: Row(
      children: [
        Icon(icon, size: 20, color: Color(0xFF1976d2)),
        SizedBox(width: 10),
        Expanded(
            child: Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
        Text(val, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
      ],
    ),
  );
}

class ForecastDetail {
  final int id;
  final String district;
  final String maxTempHigh;
  final String maxTempLow;
  final String minTempHigh;
  final String minTempLow;
  final String rainfallHigh;
  final String rainfallLow;
  final String relativeHumidityHigh;
  final String relativeHumidityLow;
  final String windSpeedHigh;
  final String windSpeedLow;
  final String windDirectionHigh;
  final String windDirectionLow;
  final String cloudCoverHigh;
  final String cloudCoverLow;
  final String tempHumidityIndexHigh;
  final String tempHumidityIndexLow;
  final DateTime createdAt;
  final DateTime updatedAt;

  ForecastDetail({
    required this.id,
    required this.district,
    required this.maxTempHigh,
    required this.maxTempLow,
    required this.minTempHigh,
    required this.minTempLow,
    required this.rainfallHigh,
    required this.rainfallLow,
    required this.relativeHumidityHigh,
    required this.relativeHumidityLow,
    required this.windSpeedHigh,
    required this.windSpeedLow,
    required this.windDirectionHigh,
    required this.windDirectionLow,
    required this.cloudCoverHigh,
    required this.cloudCoverLow,
    required this.tempHumidityIndexHigh,
    required this.tempHumidityIndexLow,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ForecastDetail.fromJson(Map<String, dynamic> j) => ForecastDetail(
    id: j['id'],
    district: j['district'].toString(),
    maxTempHigh: j['max_temp_high'].toString(),
    maxTempLow: j['max_temp_low'].toString(),
    minTempHigh: j['min_temp_high'].toString(),
    minTempLow: j['min_temp_low'].toString(),
    rainfallHigh: j['rainfall_high'].toString(),
    rainfallLow: j['rainfall_low'].toString(),
    relativeHumidityHigh: j['relative_humidity_high'].toString(),
    relativeHumidityLow: j['relative_humidity_low'].toString(),
    windSpeedHigh: j['wind_speed_high'].toString(),
    windSpeedLow: j['wind_speed_low'].toString(),
    windDirectionHigh: j['wind_direction_high'].toString(),
    windDirectionLow: j['wind_direction_low'].toString(),
    cloudCoverHigh: j['cloud_cover_high'].toString(),
    cloudCoverLow: j['cloud_cover_low'].toString(),
    tempHumidityIndexHigh: j['temp_humidity_index_high'].toString(),
    tempHumidityIndexLow: j['temp_humidity_index_low'].toString(),
    createdAt: DateTime.parse(j['created_at']),
    updatedAt: DateTime.parse(j['updated_at']),
  );
}
