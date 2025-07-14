import 'package:flutter/material.dart';
import 'package:ndri_climate/apiservices/advisory.dart';
import 'package:ndri_climate/apiservices/api_provider.dart';
import 'package:ndri_climate/auth/register_screen.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClimateServices extends StatefulWidget {
  final String date1;
  final String date2;
  final String initialState;
  final String initialDistrict;
  final String initialLanguage;
  final String title;

  const ClimateServices({
    Key? key,
    required this.date1,
    required this.date2,
    required this.initialState,
    required this.initialDistrict,
    required this.title,
    required this.initialLanguage,
  }) : super(key: key);

  @override
  _ClimateServicesState createState() => _ClimateServicesState();
}

class _ClimateServicesState extends State<ClimateServices> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String firstDate;
  late String secondDate;
  late String state;
  late String district;
  late String language;
  List<Advisory> advisoryData = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    firstDate = widget.date1.trim();
    secondDate = widget.date2.trim();
    state = widget.initialState.trim();
    district = widget.initialDistrict.trim();
    language = widget.initialLanguage;

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        language = prefs.getString('selected_lang') ?? widget.initialLanguage;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchAdvisoryData());
  }

  Future<void> _fetchAdvisoryData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    try {
      final data = await ApiProvider().fetchAdvisory(
        state: state,
        district: district,
      );
      setState(() {
        advisoryData = data.reversed.toList();
        isLoading = false;
      });
    } catch (_) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  Future<void> _showLocationDialog() async {
    final result = await showDialog<_LocationResult>(
      context: context,
      builder: (_) => _LocationDialog(
        initialState: state,
        initialDistrict: district,
      ),
    );
    if (result != null) {
      setState(() {
        state = result.state;
        district = result.district;
      });
      await _fetchAdvisoryData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: ReuseAppbar(
        scaffoldKey: _scaffoldKey,
        show_back_arrow: false,
        title: widget.title.tr,
        onselected: (lang) => setState(() => language = lang),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Color(0xFF9BDBFF),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20.sp, color: Color(0xFF1B3A69)),
                    SizedBox(width: 8.w),
                    Text(
                      '$firstDate - $secondDate',
                      style: TextStyle(
                        color: Color(0xFF1B3A69),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Chip(
                        label: Text(state.tr, style: TextStyle(color: Colors.white)),
                        avatar: Icon(Icons.map, color: Colors.white, size: 18.sp),
                        backgroundColor: Color(0xFF2C96D2),
                      ),
                      SizedBox(width: 8.w),
                      Chip(
                        label: Text(district.tr, style: TextStyle(color: Colors.white)),
                        avatar: Icon(Icons.location_on, color: Colors.white, size: 18.sp),
                        backgroundColor: Color(0xFF1976D2),
                      ),
                      SizedBox(width: 8.w),
                      IconButton(
                        icon: Icon(Icons.edit, color: Color(0xFF1B3A69), size: 20.sp),
                        onPressed: _showLocationDialog,
                        tooltip: 'Change'.tr,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchAdvisoryData,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : hasError
                  ? Center(child: Text('Error loading advisories'.tr, style: TextStyle(color: Colors.red, fontSize: 16.sp)))
                  : advisoryData.isEmpty
                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline, size: 48.sp, color: Colors.grey),
                    SizedBox(height: 12.h),
                    Text('No advisories available'.tr, style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
                  ],
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.all(8.w),
                itemCount: advisoryData.length,
                itemBuilder: (_, i) {
                  final adv = advisoryData[i];
                  final desc = (language.toLowerCase() == 'hindi')
                      ? adv.descriptionHi
                      : (language.toLowerCase() == 'bengali')
                      ? adv.descriptionBn
                      : (language.toLowerCase() == 'punjabi')
                      ? adv.descriptionPa
                      : adv.descriptionEn;
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(adv.title.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8.h),
                          Text(desc, style: TextStyle(fontSize: 14.sp)),
                          if (i == advisoryData.length - 1)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => RegisterScreen(district: district)),
                                ),
                                child: Text('Feedback'.tr),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationDialog extends StatefulWidget {
  final String initialState;
  final String initialDistrict;
  const _LocationDialog({required this.initialState, required this.initialDistrict});
  @override
  __LocationDialogState createState() => __LocationDialogState();
}

class __LocationDialogState extends State<_LocationDialog> {
  List<String> _states = [];
  Map<String, String> _stateIds = {};
  List<String> _districts = [];
  late String selectedState;
  late String selectedDistrict;
  bool loadingStates = true;
  bool loadingDistricts = false;

  @override
  void initState() {
    super.initState();
    selectedState = widget.initialState;
    selectedDistrict = widget.initialDistrict;
    _loadStates();
  }

  void _loadStates() async {
    setState(() => loadingStates = true);
    final raw = await ApiProvider().getStates();
    setState(() {
      _states = raw.map((e) => e['state_name'] as String).toList()..sort();
      for (var e in raw) _stateIds[e['state_name']] = e['state_id'].toString();
      selectedState = _states.contains(selectedState) ? selectedState : _states.first;
      loadingStates = false;
    });
    _loadDistricts();
  }

  void _loadDistricts() async {
    setState(() => loadingDistricts = true);
    final stateId = _stateIds[selectedState]!;
    final districts = await ApiProvider().getDistrictsByStateId(stateId);
    setState(() {
      _districts = districts..sort();
      if (_districts.isNotEmpty) {
        selectedDistrict = _districts.contains(selectedDistrict) ? selectedDistrict : _districts.first;
      } else {
        selectedDistrict = '';
      }
      loadingDistricts = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select State & District'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: selectedState.isNotEmpty ? selectedState : null,
            items: _states.map((s) => DropdownMenuItem(value: s, child: Text(s.tr))).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => selectedState = val);
                _loadDistricts();
              }
            },
            decoration: InputDecoration(labelText: 'State'.tr),
          ),
          SizedBox(height: 12.h),
          loadingDistricts
              ? CircularProgressIndicator()
              : DropdownButtonFormField<String>(
            isExpanded: true,
            value: selectedDistrict.isNotEmpty ? selectedDistrict : null,
            items: _districts.map((d) => DropdownMenuItem(value: d, child: Text(d.tr))).toList(),
            onChanged: (val) {
              if (val != null) setState(() => selectedDistrict = val);
            },
            decoration: InputDecoration(labelText: 'District'.tr),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel'.tr)),
        TextButton(onPressed: () => Navigator.pop(context, _LocationResult(state: selectedState, district: selectedDistrict)), child: Text('OK'.tr)),
      ],
    );
  }
}

class _LocationResult {
  final String state;
  final String district;
  _LocationResult({required this.state, required this.district});
}
