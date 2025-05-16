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

class Past_Advisories extends StatefulWidget {
  final String Date1;
  final String Date2;
  final String District;
  final String Language;
  final String title;

  const Past_Advisories({
    super.key,
    required this.Date1,
    required this.Date2,
    required this.District,
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
  late String district;
  late String language;
  List<Advisory> advisoryData = [];
  List<Advisory> filterData = [];
  List<Advisory> allData = [];
  bool isLoading = true;
  bool show = false;
  bool hasError = false;
  bool _filterApplied = false;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    firstDate = widget.Date1;
    secondDate = widget.Date2;
    district = widget.District;
    language = widget.Language;
    _fetchAdvisoryData();
  }

  void _fetchAdvisoryData() async {
    try {
      final response = await ApiProvider().fetchAdvisory();
      allData = response;
      List<Advisory> currentWeekAdvisories = allData.where((advisory) {
        return formatDate(inputDate: advisory.fromDate.toString()) == firstDate &&
            formatDate(inputDate: advisory.toDate.toString()) == secondDate;
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

  void showDateBottomsheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return filterDate(
          index: _index,
          onTapcallback: (from_date, to_date, index) {
            filterData.clear();
            filterData = allData.where((data) {
              return from_date == data.fromDate && to_date == data.toDate;
            }).toList();

            if (filterData.isNotEmpty) {
              setState(() {
                _filterApplied = true;
                show = true;
                _index = index;
              });
              Navigator.pop(context);
            }
            if (mounted) {
              setState(() {});
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double sidePad = ResponsiveUtils.wp(3);
    double containerPad = ResponsiveUtils.wp(3);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size(40, 60),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          show_back_arrow: false,
          title: widget.title.tr,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: sidePad, vertical: 16),
              color: const Color(0xFF9BDBFF),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 8,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_month, color: Color(0xFF1B3A69), size: 21),
                      const SizedBox(width: 5),
                      Text(
                        '$firstDate - $secondDate',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(2.3),
                          color: const Color(0xFF1B3A69),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_pin, color: Color(0xFF1B3A69), size: 21),
                      const SizedBox(width: 4),
                      Text(
                        district.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(2.3),
                          color: const Color(0xFF1B3A69),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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
                    'Error fetching data',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(2.8),
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            else ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sidePad, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      show
                          ? Chip(
                        deleteIcon: const Icon(Icons.close, size: 14, color: Colors.black),
                        onDeleted: () {
                          filterData.clear();
                          setState(() {
                            show = false;
                            _filterApplied = false;
                          });
                        },
                        backgroundColor: const Color(0xFF9BDBFF),
                        label: Text(
                          'Remove Filter',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.wp(2.3),
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                      InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: showDateBottomsheet,
                        child: Row(
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                  fontSize: ResponsiveUtils.wp(2.5),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.sort, size: 22, color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sidePad),
                  child: advisoryListWidget(context),
                ),
              ],
            SizedBox(height: ResponsiveUtils.hp(2)),
          ],
        ),
      ),
    );
  }

  Widget advisoryListWidget(BuildContext context) {
    final listToShow = _filterApplied ? filterData : advisoryData;

    if (listToShow.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(6)),
        child: Center(
          child: Text(
            'No advisories available for this period.',
            style: TextStyle(
              fontSize: ResponsiveUtils.wp(2.4),
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
          case 'বঙ্গালি':
          case 'बंगाली':
          case 'ਬੰਗਾਲੀ':
          case 'বাংলা':
            description = advisory.descriptionBn;
            break;
          case 'punjabi':
          case 'ਪੰਜਾਬੀ':
          case 'पंजाबी':
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
                      fontSize: ResponsiveUtils.wp(2.7),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.wp(2.2),
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
                          district: district,
                        ),
                      ),
                    );
                  },
                  child: Chip(
                    color: WidgetStateProperty.all(const Color(0xFF2C96D2)),
                    label: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(3),
                        vertical: ResponsiveUtils.hp(0.8),
                      ),
                      child: Text(
                        'Feedback',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(2.4),
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
