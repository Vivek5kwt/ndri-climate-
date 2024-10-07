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

  Past_Advisories({
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
  String firstDate = '';
  String secondDate = '';
  String district = '';
  String language = '';
  List<Advisory> advisoryData = [];
  List<Advisory> filterData = []; 
  List<Advisory> allData = []; 
  bool isLoading = true;
  bool show = false;
  bool hasError = false;
  bool _filterApplied = false; 
  int _index=0;

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
      return formatDate(inputDate: advisory.fromDate.toString()) == firstDate && formatDate(inputDate: advisory.toDate.toString()) == secondDate;
    }).toList();
      setState(() {
        advisoryData=currentWeekAdvisories;
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
          onTapcallback: (from_date, to_date,index) {
            filterData.clear();
            filterData=allData.where((data){
              return from_date==data.fromDate&&to_date==data.toDate;
            }).toList();
            
            if (filterData.isNotEmpty) {
              setState(() {
                _filterApplied = true;
                show=true;
                _index=index;
              });
              Navigator.pop(context);
            }
            if (mounted) {
  setState(() {
  });
}
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size(40, 60),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          show_back_arrow: false,
          title: widget.title.tr,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 61,
              padding: EdgeInsets.all(20),
              color: Color(0xFF9BDBFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Color(0xFF1B3A69),
                          size: 21,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '$firstDate -$secondDate',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.wp(2.5),
                            color: Color(0xFF1B3A69),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Color(0xFF1B3A69),
                          size: 21,
                        ),
                        Text(
                          district.tr,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.wp(2.5),
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
            isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height / 2,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator.adaptive(),
                  )
                : hasError
                    ? Center(
                        child: Text(
                          'Error fetching data',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.wp(2.8),
                            color: Colors.red,
                          ),
                        ),
                      )
                    : Container(
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              show?
                              Chip(deleteIcon: Icon(Icons.close,size: 14,color: Colors.black,),
                              onDeleted: () {
                                filterData.clear();
                                
                                setState(() {
                                  show=false;
                                _filterApplied=false;
                                });
                              },
                                backgroundColor:Color(0xFF9BDBFF) ,
                                label: Text('Remove Filter', style: TextStyle(fontSize: ResponsiveUtils.wp(2.5),fontWeight: FontWeight.w400,color: Colors.black),)):Container(),
                              InkWell(
                                onTap: () {
                                      showDateBottomsheet();
                                    },
                                child: Row(
                                  children: [
                                    Text('Filter',style: TextStyle(fontSize: ResponsiveUtils.wp(2.8),fontWeight: FontWeight.w500,color: Colors.black),),
                                    SizedBox(width: 10,),
                                    Icon(Icons.sort,size: 25,color: Colors.black,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height / 1.26,
                              child: ListView.builder(
                                itemCount:_filterApplied?filterData.length: advisoryData.length,
                                itemBuilder: (context, index) {
                                  Advisory advisory = _filterApplied? filterData[index]: 
                                  advisoryData[index];
                                  String description;
                          
                                  // Determine the description based on the language
                                  switch (language.toLowerCase()) {
                                    case ('hindi'||'हिंदी'||'ਹਿੰਦੀ'||'হিন্দি'):
                                      description = advisory.descriptionHi;
                                      break;
                                      case ('english'||'अंग्रेज़ी'||'ਅੰਗਰੇਜ਼ੀ'||'ইংরেজি'):
                                      description = advisory.descriptionEn;
                                      break;
                                      case ('bengali'||'बंगाली'||'ਬੰਗਾਲੀ'||'বাংলা'):
                                      description = advisory.descriptionBn;
                                      break;
                                      case ('punjabi'||'ਪੰਜਾਬੀ'||'पंजाबी'||'পাঞ্জাবি'):
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
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(bottom: 10),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              advisory.title,
                                              style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2.8),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              description,
                                              style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2.5),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (index == advisoryData.length - 1)
                                        InkWell(
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
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Chip(
                                              backgroundColor: Colors.transparent,
                                              label: Text(
                                                'Feedback'.tr,
                                                style: TextStyle(
                                                  fontSize: ResponsiveUtils.wp(3),
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF2C96D2),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
