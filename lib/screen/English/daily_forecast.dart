import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndri_climate/material/network_image_loader.dart';

class Daily_Forecast extends StatefulWidget {
  final String district;
  final String date;
  const Daily_Forecast({super.key, required this.district, required this.date});

  @override
  State<Daily_Forecast> createState() => _Daily_ForecastState();
}

class _Daily_ForecastState extends State<Daily_Forecast> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = true;
  ForecastDetail? _detail;

  Future<void> _load() async {
    final id = await _findIdForDistrict(widget.district);
    if (id != null) await _getDetailById(id);
    setState(() => loading = false);
  }

  Future<String?> _findIdForDistrict(String district) async {
    String? next = 'https://ndri.ampleteckdev.com/api/forecasts?page=';
    final wanted = district.trim().toLowerCase();
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

  Future<void> _getDetailById(String id) async {
    final url = Uri.parse('https://ndri.ampleteckdev.com/api/forecasts/$id');
    final res = await http.get(url, headers: {'Accept': 'application/json'});
    if (res.statusCode == 200) {
      final dec = jsonDecode(res.body);
      final payload = dec is Map && dec.containsKey('data') ? dec['data'] : dec;
      setState(() => _detail = ForecastDetail.fromJson(payload));
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    key: _scaffoldKey,
    drawer: CustomDrawer(),
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(60.h),
      child: ReuseAppbar(
        scaffoldKey: _scaffoldKey,
        show_back_arrow: false,
        title: 'Daily forecast'.tr,
      ),
    ),
    body: loading
        ? Center(child: CircularProgressIndicator(color: Colors.blue.shade400))
        : _detail == null
        ? Center(child: Text('No data', style: TextStyle(fontSize: 18.sp)))
        : _body(),
  );

  Widget _body() => Container(
    width: 1.sw,
    padding: EdgeInsets.all(18.w),
    child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          _detail!.district.tr,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4.h),
        Text(
          widget.date,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NetworkImageLoader(
              url: 'https://cdn-icons-png.flaticon.com/128/2469/2469994.png',
              width: 70.w,
              height: 65.h,
              fit: BoxFit.contain,
            ),
            Text(
              '${_detail!.maxTempHigh}°C',
              style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        SizedBox(height: 22.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _metric('https://cdn-icons-png.flaticon.com/128/4005/4005767.png',
                _detail!.windSpeedHigh, 'km/h'),
            _metric('https://cdn-icons-png.flaticon.com/128/414/414927.png',
                _detail!.cloudCoverHigh, 'octa'),
            _metric('https://cdn-icons-png.flaticon.com/128/10271/10271656.png',
                _detail!.rainfallHigh, 'mm'),
          ],
        ),
        SizedBox(height: 30.h),

        _detailCard(_detail!),
      ]),
    ),
  );

  Widget _metric(String img, String val, String unit) => Container(
    width: 100.w,
    height: 95.h,
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
        color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12.r)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NetworkImageLoader(url: img, width: 35.w, height: 30.h, fit: BoxFit.contain),
        SizedBox(height: 7.h),
        Text('$val $unit', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))
      ],
    ),
  );

  Widget _row(String label, String val) => Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: Row(
      children: [
        Expanded(
            child: Text(label,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500))),
        Text(val, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400)),
      ],
    ),
  );

  Widget _detailCard(ForecastDetail d) => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
    child: Padding(
      padding: EdgeInsets.all(18.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _row('Max Temp', '${d.maxTempHigh} / ${d.maxTempLow} °C'),
        _row('Min Temp', '${d.minTempHigh} / ${d.minTempLow} °C'),
        _row('Rainfall', '${d.rainfallHigh} – ${d.rainfallLow} mm'),
        _row('Humidity', '${d.relativeHumidityHigh}% – ${d.relativeHumidityLow}%'),
        _row('Wind Speed', '${d.windSpeedHigh} – ${d.windSpeedLow} km/h'),
        _row('Wind Dir', '${d.windDirectionHigh} – ${d.windDirectionLow}°'),
        _row('Cloud Cover', '${d.cloudCoverHigh} – ${d.cloudCoverLow} octa'),
        _row('THI', '${d.tempHumidityIndexHigh} – ${d.tempHumidityIndexLow}'),
        _row('Updated', DateFormat.yMMMd().add_jm().format(d.updatedAt)),
      ]),
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
