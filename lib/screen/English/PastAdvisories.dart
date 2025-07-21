// lib/feature/climate/Past_Advisories.dart

import 'package:flutter/material.dart';
import 'package:ndri_climate/apiservices/advisory.dart';
import 'package:ndri_climate/apiservices/api_provider.dart';
import 'package:ndri_climate/auth/register_screen.dart';
import 'package:ndri_climate/material/bottom_sheet.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/model/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Past_Advisories extends StatefulWidget {
  final String Date1;
  final String Date2;
  final String initialState;
  final String initialDistrict;
  final String Language;
  final String title;

  const Past_Advisories({
    super.key,
    required this.Date1,
    required this.Date2,
    required this.initialState,
    required this.initialDistrict,
    required this.title,
    required this.Language,
  });

  @override
  State<Past_Advisories> createState() => _Past_AdvisoriesState();
}

class _Past_AdvisoriesState extends State<Past_Advisories> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String firstDate;
  late String secondDate;
  late String selectedState;
  late String selectedDistrict;
  late String language;
  List<Advisory> advisoryData = [];
  List<Advisory> filterData = [];
  List<Advisory> allData = [];
  bool isLoading = true;
  bool showFilterTag = false;
  bool hasError = false;
  bool _filterApplied = false;
  int _dateIndex = 0;

  // Controllers to display selected state/district in real time
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstDate = widget.Date1;
    secondDate = widget.Date2;
    selectedState = widget.initialState;
    selectedDistrict = widget.initialDistrict;
    language = widget.Language;
    _stateController.text = selectedState;
    _districtController.text = selectedDistrict;
    _languageController.text = language;
    _fetchAdvisoryData();
  }

  @override
  void dispose() {
    _stateController.dispose();
    _districtController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  Future<void> _fetchAdvisoryData() async {
    setState(() {
      isLoading = true;
      hasError = false;
      advisoryData.clear();
      filterData.clear();
      _filterApplied = false;
      showFilterTag = false;
    });

    try {
      // Now passing both state and district to the API:
      final response = await ApiProvider().fetchAdvisory(
        state: selectedState,
        district: selectedDistrict,
      );
      allData = response;

      // Filter advisories that exactly match firstDate and secondDate
      List<Advisory> currentWeekAdvisories = allData.where((advisory) {
        final from = formatDate(inputDate: advisory.fromDate.toString());
        final to = formatDate(inputDate: advisory.toDate.toString());
        return from == firstDate && to == secondDate;
      }).toList();

      setState(() {
        advisoryData = currentWeekAdvisories;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  void _showStateDistrictBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bsContext) {
        return StatefulBuilder(
          builder: (context, __) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  // Header
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: const Color(0xFF2C96D2),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select State & District'.tr,
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 20),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),

                  // State selection
                  ListTile(
                    title: TextField(
                      controller: _stateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'State'.tr,
                        hintText: 'Choose State'.tr,
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        border: const OutlineInputBorder(),
                      ),
                      onTap: () async {
                        // Open StateBottomSheet
                        final chosenState = await showModalBottomSheet<String>(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => StateBottomSheet(
                            selected_state: (state) {
                              _stateController.text = state;
                            },
                            onStateSelected: (state, districtList) {
                              _stateController.text = state;
                              _districtController.clear();
                              Navigator.pop(bsContext, state);
                            },
                          ),
                        );
                        if (chosenState != null) {
                          // After choosing state, automatically open district sheet
                          final districtsList =
                              StateBottomSheet.stateDistricts[chosenState] ?? [];
                          if (districtsList.isNotEmpty) {
                            final chosenDistrict = await showModalBottomSheet<String>(
                              context: context,
                              isScrollControlled: true,
                              builder: (_) => DistrictBottomSheet(
                                selected_district: (district) {
                                  _districtController.text = district;
                                },
                                districts: districtsList,
                              ),
                            );
                            if (chosenDistrict != null) {
                              _districtController.text = chosenDistrict;
                            }
                          }
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // District selection (in case user wants to re-open only district)
                  ListTile(
                    title: TextField(
                      controller: _districtController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'District'.tr,
                        hintText: 'Choose District'.tr,
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        border: const OutlineInputBorder(),
                      ),
                      onTap: () async {
                        final stateVal = _stateController.text.trim();
                        if (stateVal.isEmpty) {
                          Get.snackbar(
                            'Please select state first'.tr,
                            '',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          return;
                        }
                        final districtsList =
                            StateBottomSheet.stateDistricts[stateVal] ?? [];
                        if (districtsList.isNotEmpty) {
                          final chosenDistrict = await showModalBottomSheet<String>(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => DistrictBottomSheet(
                              selected_district: (district) {
                                _districtController.text = district;
                              },
                              districts: districtsList,
                            ),
                          );
                          if (chosenDistrict != null) {
                            _districtController.text = chosenDistrict;
                          }
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Confirm button
                  ElevatedButton(
                    onPressed: () {
                      final newState = _stateController.text.trim();
                      final newDistrict = _districtController.text.trim();
                      if (newState.isEmpty || newDistrict.isEmpty) {
                        Get.snackbar(
                          'Select both state and district'.tr,
                          '',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      setState(() {
                        selectedState = newState;
                        selectedDistrict = newDistrict;
                      });
                      Navigator.of(context).pop();
                      _fetchAdvisoryData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C96D2),
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(20),
                        vertical: ResponsiveUtils.hp(1.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Confirm'.tr,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.wp(3),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
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
              this.language = language;
            });
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('selected_lang', language);
          },
        );
      },
    );
  }

  void _showDateFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return filterDate(
          index: _dateIndex,
          onTapcallback: (from_date, to_date, index) {
            filterData = allData.where((data) {
              return from_date == data.fromDate && to_date == data.toDate;
            }).toList();

            if (filterData.isNotEmpty) {
              setState(() {
                _filterApplied = true;
                showFilterTag = true;
                _dateIndex = index;
              });
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double sidePad = ResponsiveUtils.wp(3);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          show_back_arrow: false,
          title: widget.title.tr,
          onselected: (lang) {
            setState(() {
              _languageController.text = lang;
              language = lang;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Top container: dates, state, district, language
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: sidePad, vertical: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9BDBFF), Color(0xFFE8F6FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: ResponsiveUtils.wp(3),
                runSpacing: ResponsiveUtils.hp(1),
                children: [
                  // Dates
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_month, color: Color(0xFF1B3A69), size: 20),
                      SizedBox(width: ResponsiveUtils.wp(1)),
                      Text(
                        '$firstDate  -  $secondDate',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(3),
                          color: const Color(0xFF1B3A69),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // State (tappable)
                  GestureDetector(
                    onTap: _showStateDistrictBottomSheet,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.map, color: Color(0xFF1B3A69), size: 20),
                        SizedBox(width: ResponsiveUtils.wp(1)),
                        Text(
                          _stateController.text.tr,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.wp(3),
                            color: const Color(0xFF1B3A69),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // District (tappable)
                  GestureDetector(
                    onTap: _showStateDistrictBottomSheet,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_pin, color: Color(0xFF1B3A69), size: 20),
                        SizedBox(width: ResponsiveUtils.wp(1)),
                        Text(
                          _districtController.text.tr,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.wp(3),
                            color: const Color(0xFF1B3A69),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Language (tappable)
                  GestureDetector(
                    onTap: _showLanguageBottomSheet,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.language, color: Color(0xFF1B3A69), size: 20),
                        SizedBox(width: ResponsiveUtils.wp(1)),
                        Text(
                          _languageController.text.tr,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.wp(3),
                            color: const Color(0xFF1B3A69),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (isLoading)
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(child: CircularProgressIndicator.adaptive()),
              )
            else if (hasError)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(3)),
                  child: Text(
                    'Error fetching data'.tr,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(3),
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            else ...[
                // Filter bar (Remove filter & Filter by date)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sidePad, vertical: ResponsiveUtils.hp(1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (showFilterTag)
                        Chip(
                          deleteIcon: const Icon(Icons.close, size: 14, color: Colors.black),
                          onDeleted: () {
                            setState(() {
                              showFilterTag = false;
                              _filterApplied = false;
                            });
                          },
                          backgroundColor: const Color(0xFF9BDBFF),
                          label: Text(
                            'Remove Filter'.tr,
                            style: TextStyle(
                              fontSize: ResponsiveUtils.wp(2.9),
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),

                      InkWell(
                        onTap: _showDateFilterBottomSheet,
                        borderRadius: BorderRadius.circular(5),
                        child: Row(
                          children: [
                            Text(
                              'Filter'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(3),
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: ResponsiveUtils.wp(1)),
                            const Icon(Icons.sort, size: 22, color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Advisories list
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sidePad),
                  child: _buildAdvisoriesList(),
                ),
              ],

            SizedBox(height: ResponsiveUtils.hp(2)),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvisoriesList() {
    final listToShow = _filterApplied ? filterData : advisoryData;

    if (listToShow.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(6)),
        child: Center(
          child: Text(
            'No advisories available for this period.'.tr,
            style: TextStyle(
              fontSize: ResponsiveUtils.wp(2.9),
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listToShow.length,
      itemBuilder: (context, index) {
        Advisory advisory = listToShow[index];
        String description;

        switch (language.toLowerCase()) {
          case 'hindi':
          case 'हिंदी':
          case 'ਹਿੰਦੀ':
          case 'হিন্দি':
            description = advisory.descriptionHi;
            break;
          case 'english':
          case 'अंग्रेज़ी':
          case 'ਅੰਗਰੇਜ਼ੀ':
          case 'ইংরেজি':
            description = advisory.descriptionEn;
            break;
          case 'bengali':
          case 'बंगाली':
          case 'ਬੰਗਾਲੀ':
          case 'বাংলা':
            description = advisory.descriptionBn;
            break;
          case 'punjabi':
          case 'पंजाबी':
          case 'ਪੰਜਾਬੀ':
          case 'পাঞ্জাবি':
            description = advisory.descriptionPa;
            break;
          default:
            description = advisory.descriptionEn;
            break;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    advisory.title,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(3.2),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(2.7),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            if (index == listToShow.length - 1)
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(
                          district: selectedDistrict,
                        ),
                      ),
                    );
                  },
                  child: Chip(
                    backgroundColor: const Color(0xFF2C96D2),
                    label: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(3),
                        vertical: ResponsiveUtils.hp(0.8),
                      ),
                      child: Text(
                        'Feedback'.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(3),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}