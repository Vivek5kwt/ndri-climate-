import 'dart:convert';
import 'package:adaptive_pop_scope/adaptive_pop_scope.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:ndri_climate/material/bottom_sheet.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:ndri_climate/screen/English/Climate_Services.dart';
import 'package:ndri_climate/screen/English/PastAdvisories.dart';
import 'package:ndri_climate/screen/English/murrahbuffalo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dairy_animal.dart';

class Dashboard extends StatefulWidget {
  final String selectDist;
  final String selectState;
  final String selectLang;

  const Dashboard({
    super.key,
    required this.selectDist,
    required this.selectState,
    required this.selectLang,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));
  bool _loading = true;
  ForecastDetail? _forecast;
  String _currentDist = '';
  String _currentState = '';
  String _currentLang = '';
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now().add(const Duration(days: 7));
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _loadSavedSelection().then((_) {
      _loadForecast();
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Dashboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectDist.trim() != widget.selectDist.trim()) {
      _loadSavedSelection().then((_) {
        _loadForecast();
      });
    }
  }

  Future<void> _loadSavedSelection() async {
    final prefs = await SharedPreferences.getInstance();
    _currentState = widget.selectState.isNotEmpty
        ? widget.selectState
        : (prefs.getString('selected_state') ?? widget.selectState);
    _currentDist = widget.selectDist.isNotEmpty
        ? widget.selectDist
        : (prefs.getString('selected_dist') ?? widget.selectDist);
    _currentLang = widget.selectLang.isNotEmpty
        ? widget.selectLang
        : (prefs.getString('selected_lang') ?? widget.selectLang);

    prefs.setString('selected_state', _currentState);
    prefs.setString('selected_dist', _currentDist);
    prefs.setString('selected_lang', _currentLang);
  }

  Future<void> _loadForecast() async {
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    final key = 'forecast_$_currentDist';
    if (_currentDist.isEmpty) {
      // No district selected yet
      setState(() {
        _forecast = null;
        _loading = false;
      });
      return;
    }
    if (prefs.containsKey(key)) {
      final jsonString = prefs.getString(key)!;
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      _forecast = ForecastDetail.fromJson(jsonMap);
      setState(() => _loading = false);
    } else {
      await _fetchAndCacheForecast();
    }
  }

  Future<void> _fetchAndCacheForecast() async {
    try {
      final detail = await _getForecastByDistrict(_currentDist.trim());
      if (detail != null) {
        _forecast = detail;
        final prefs = await SharedPreferences.getInstance();
        final key = 'forecast_$_currentDist';
        prefs.setString(key, jsonEncode(detail.toJson()));
      } else {
        _forecast = null;
      }
    } catch (_) {
      _forecast = null;
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<ForecastDetail?> _getForecastByDistrict(String district) async {
    final uri =
    Uri.parse('https://ndrics.in/api/forecasts/$district');
    final res = await http.get(uri, headers: {'Accept': 'application/json'});
    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);
      final payload =
      (decoded is Map && decoded.containsKey('data')) ? decoded['data'] : decoded;
      return ForecastDetail.fromJson(payload as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<bool> _confirmExit() async {
    return await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C96D2),
        title: const Text(
          'Exit Confirmation',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Are you sure you want to exit?',
          style: TextStyle(
            fontSize: ResponsiveUtils.wp(3),
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            child: const Text('Yes', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ) ??
        false;
  }

  Future<void> _openSelectionDialog() async {
    final result = await showDialog<SelectionResult>(
      context: context,
      builder: (ctx) => const Dialogue_page(),
    );
    if (result != null) {
      setState(() {
        _currentState = result.state;
        _currentDist = result.dist;
        _currentLang = result.lang;
        _loading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('selected_state', _currentState);
      prefs.setString('selected_dist', _currentDist);
      prefs.setString('selected_lang', _currentLang);
      await _fetchAndCacheForecast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            show_back_arrow: false,
            title: 'Dashboard'.tr,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Climate services by ICAR-National Dairy Research Institute (NDRI), Karnal'
                      .tr,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.wp(2.8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: ResponsiveUtils.hp(16),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  children: [
                    topContainer(
                      'Dairy Animal and Climate Change',
                      'assets/images/buffalo.webp',
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Murrah_buffalo()),
                      ),
                    ),
                    topContainer(
                      'Climate Advisory',
                      'assets/images/forecast.webp',
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ClimateServices(
                            date1:
                            '${DateFormat('dd-MM-yyyy').format(_startDate)} - ',
                            date2: DateFormat('dd-MM-yyyy').format(_endDate),
                            initialDistrict: _currentDist,
                            title: 'Climate Advisory'.tr,
                            initialLanguage: _currentLang, initialState: _currentState,
                          ),
                        ),
                      ),
                    ),
                    topContainer(
                      'Past Advisories',
                      'assets/images/forecast.webp',
                          () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Past_Advisories(
                            Date1: DateFormat('dd-MM-yyyy').format(_startDate),
                            Date2: DateFormat('dd-MM-yyyy').format(_endDate),
                            initialDistrict: _currentDist,
                            initialState: _currentState,
                            title: 'Past Advisories'.tr,
                            Language: _currentLang,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? const Color(0xFF1976D2)
                        : Colors.grey.shade400,
                  ),
                )),
              ),
              const SizedBox(height: 10),
              _buildForecastSection(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DairyAnimal(
                        date1:
                        '${DateFormat('dd-MM-yyyy').format(_startDate)} - ',
                        date2:
                        DateFormat('dd-MM-yyyy').format(_endDate),

                      ),
                    ),
                  ),
                  child: Container(
                    height: ResponsiveUtils.hp(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image:  DecorationImage(
                        image: AssetImage('assets/images/murrah.webp'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7),
                          BlendMode.dstATop,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Dark gradien t overlay for text contrast
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: AutoSizeText(
                            'Dairy Animal'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ResponsiveUtils.wp(4.5),
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForecastSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF9BDBFF), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Always show header row with title, refresh, and change-city icons
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Weekly Weather Forecast'.tr,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(3),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF005fa3),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  color: const Color(0xFF005fa3),
                  onPressed: () {
                    setState(() => _loading = true);
                    _fetchAndCacheForecast();
                  },
                  tooltip: 'Refresh'.tr,
                ),
                IconButton(
                  icon: const Icon(Icons.location_city),
                  color: const Color(0xFF005fa3),
                  onPressed: _openSelectionDialog,
                  tooltip: 'Change City'.tr,
                ),
              ],
            ),
            const SizedBox(height: 8),
            // District display
            Center(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1976d2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade100,
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  _currentDist.isEmpty ? 'No city selected'.tr : _currentDist.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: ResponsiveUtils.wp(2.5),
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            // If loading, show spinner; else if no data, show message; else show table
            if (_loading)
              SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator.adaptive()),
              )
            else if (_forecast == null)
              SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'No data available'.tr,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(3),
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              )
            else ...[
                Center(
                  child: Text(
                    '${'Last updated:'.tr} ${DateFormat('dd-MM-yyyy HH:mm').format(_forecast!.updatedAt)}',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(2),
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(2),
                  },
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      width: 0.5,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  children: [
                    _buildTableRow(
                      icon: Icons.thermostat,
                      label: 'Max Temp'.tr,
                      value:
                      '${_forecast!.maxTempLow} – ${_forecast!.maxTempHigh} °C',
                      shaded: true,
                    ),
                    _buildTableRow(
                      icon: Icons.ac_unit,
                      label: 'Min Temp'.tr,
                      value:
                      '${_forecast!.minTempLow} – ${_forecast!.minTempHigh} °C',
                    ),
                    _buildTableRow(
                      icon: Icons.grain,
                      label: 'Rainfall'.tr,
                      value:
                      '${_forecast!.rainfallLow} – ${_forecast!.rainfallHigh} mm',
                      shaded: true,
                    ),
                    _buildTableRow(
                      icon: Icons.water_drop,
                      label: 'Humidity'.tr,
                      value:
                      '${_forecast!.relativeHumidityLow}% – ${_forecast!.relativeHumidityHigh}%',
                    ),
                    _buildTableRow(
                      icon: Icons.wind_power,
                      label: 'Wind Speed'.tr,
                      value:
                      '${_forecast!.windSpeedLow} – ${_forecast!.windSpeedHigh} km/h',
                      shaded: true,
                    ),
                    _buildTableRow(
                      icon: Icons.rotate_right,
                      label: 'Wind Dir'.tr,
                      value:
                      '${_forecast!.windDirectionLow} – ${_forecast!.windDirectionHigh}°',
                    ),
                    _buildTableRow(
                      icon: Icons.filter_drama,
                      label: 'Cloud Cover'.tr,
                      value:
                      '${_forecast!.cloudCoverLow} – ${_forecast!.cloudCoverHigh} octa',
                      shaded: true,
                    ),
                    _buildTableRow(
                      icon: Icons.device_thermostat,
                      label: 'THI'.tr,
                      value:
                      '${_forecast!.tempHumidityIndexLow} – ${_forecast!.tempHumidityIndexHigh}',
                    ),
                  ],
                ),
              ],
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow({
    required IconData icon,
    required String label,
    required String value,
    bool shaded = false,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        color: shaded ? Colors.blue.shade50 : Colors.transparent,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: ResponsiveUtils.wp(5),
                color: const Color(0xFF1976d2),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: ResponsiveUtils.wp(3),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: ResponsiveUtils.wp(3),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget topContainer(String title, String asset, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: ResponsiveUtils.wp(40),
      height: ResponsiveUtils.hp(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xFFABABAB)),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(asset),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.dstATop,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Center(
                child: AutoSizeText(
                  title.tr,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.wp(3),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
    id: j['id'] as int,
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
    createdAt: DateTime.parse(j['created_at'] as String),
    updatedAt: DateTime.parse(j['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'district': district,
    'max_temp_high': maxTempHigh,
    'max_temp_low': maxTempLow,
    'min_temp_high': minTempHigh,
    'min_temp_low': minTempLow,
    'rainfall_high': rainfallHigh,
    'rainfall_low': rainfallLow,
    'relative_humidity_high': relativeHumidityHigh,
    'relative_humidity_low': relativeHumidityLow,
    'wind_speed_high': windSpeedHigh,
    'wind_speed_low': windSpeedLow,
    'wind_direction_high': windDirectionHigh,
    'wind_direction_low': windDirectionLow,
    'cloud_cover_high': cloudCoverHigh,
    'cloud_cover_low': cloudCoverLow,
    'temp_humidity_index_high': tempHumidityIndexHigh,
    'temp_humidity_index_low': tempHumidityIndexLow,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

class SelectionResult {
  final String state;
  final String dist;
  final String lang;

  SelectionResult({
    required this.state,
    required this.dist,
    required this.lang,
  });
}

class Dialogue_page extends StatefulWidget {
  const Dialogue_page({super.key});

  @override
  State<Dialogue_page> createState() => _Dialogue_pageState();
}

class _Dialogue_pageState extends State<Dialogue_page> {
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  List<String> _districtList = [];

  @override
  void initState() {
    super.initState();
    _loadPreviousSelection();
  }

  Future<void> _loadPreviousSelection() async {
    final prefs = await SharedPreferences.getInstance();
    _stateController.text = prefs.getString('selected_state') ?? '';
    _districtController.text = prefs.getString('selected_dist') ?? '';
    _languageController.text = prefs.getString('selected_lang') ?? '';
  }

  void _showStateBottomSheet() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return StateBottomSheet(
          selected_state: (state) async {
            setState(() {
              _stateController.text = state;
              _districtController.text = '';
              _districtList = [];
            });
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('selected_state', state);
          },
          onStateSelected: (state, districts) {
            setState(() {
              _districtList = districts;
            });
          },
        );
      },
    );
  }

  void _showDistrictBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return DistrictBottomSheet(
          districts: _districtList,
          selected_district: (district) async {
            setState(() {
              _districtController.text = district;
            });
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('selected_dist', district);
          },
        );
      },
    );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return LanguageBottomSheet(
          selected_language: (language) async {
            setState(() {
              _languageController.text = language;
            });
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('selected_lang', language);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Location & Language'.tr,
        style: TextStyle(
          fontSize: ResponsiveUtils.wp(4),
          fontWeight: FontWeight.w700,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextFormField(
              controller: _stateController,
              hintText: 'Select State'.tr,
              onTap: _showStateBottomSheet,
            ),
            const SizedBox(height: 12),
            _buildTextFormField(
              controller: _districtController,
              hintText: 'Select District'.tr,
              onTap: () {
                if (_stateController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select state first!'.tr)),
                  );
                } else {
                  _showDistrictBottomSheet();
                }
              },
            ),
            const SizedBox(height: 12),
            _buildTextFormField(
              controller: _languageController,
              hintText: 'Select Language'.tr,
              onTap: () {
                if (_stateController.text.trim().isEmpty ||
                    _districtController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select state & district first!'.tr),
                    ),
                  );
                } else {
                  _showLanguageBottomSheet();
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'.tr),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(SelectionResult(
              state: _stateController.text,
              dist: _districtController.text,
              lang: _languageController.text,
            ));
          },
          child: Text('OK'.tr),
        ),
      ],
    );
  }



  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400, width: 0.75),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: ResponsiveUtils.wp(3.5),
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}