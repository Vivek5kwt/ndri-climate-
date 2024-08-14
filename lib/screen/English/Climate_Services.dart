import 'package:flutter/material.dart';
import 'package:ndri_climate/apiservices/advisory.dart';
import 'package:ndri_climate/apiservices/api_provider.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';

class Climate_services extends StatefulWidget {
   final String Date1;
  final String Date2;
  final String District;
  final String title;
   Climate_services({super.key, required this.Date1, required this.Date2, required this.District, required this.title});

  @override
  State<Climate_services> createState() => _Climate_servicesState();
}

class _Climate_servicesState extends State<Climate_services> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String first_date = '';
  String second_date = '';
  String district = '';


  @override
  void initState() {
    setState(() {
      first_date = widget.Date1;
      second_date = widget.Date2;
      district =widget.District;
      
      
    });
    super.initState();
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
          )),
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
                          '$first_date $second_date',
                          style: TextStyle(
                            fontSize: 14,
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
                            fontSize: 14,
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
            
             Container(
               child: FutureBuilder(
                
                future: ApiProvider().fetchAdvisory(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    Container(height: MediaQuery.of(context).size.height / 2,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    List<Advisory>advisory_data = data?.reversed.toList() ?? [];
                     return  Container(
                      height: MediaQuery.of(context).size.height / 1.22,
                       child: ListView.builder(
                        itemCount: advisory_data.length,
                        itemBuilder: (context, index) {
                          Advisory _advisory = advisory_data[index];
                         return Container(
                                         width: MediaQuery.of(context).size.width,
                                         // height: MediaQuery.of(context).size.height / 2,
                                         margin: EdgeInsets.all(10),
                                         padding: EdgeInsets.all(15),
                                         decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                        Text(
                          _advisory.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _advisory.description, style:
                              TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        )
                                           ],
                                         ));
                       },),
                     );
                  } 
                 return Container();
                },
                ),
              
             ),
              
          ],
        ),
      ),
    );
  }
}
