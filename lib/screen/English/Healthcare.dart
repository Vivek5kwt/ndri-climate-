import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:ndri_climate/material/Reusabledescrip.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';

class Healthcare extends StatefulWidget {
  const Healthcare({super.key});

  @override
  State<Healthcare> createState() => _HealthcareState();
}

class _HealthcareState extends State<Healthcare> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: CustomDrawer(),
          appBar: PreferredSize(
            preferredSize: Size(60, 60),
            child: ReuseAppbar(
              scaffoldKey: _scaffoldKey,
              title: 'Health Care Management'.tr,
              show_back_arrow: false,
            ),
          ),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0xFFC8EBFF),
                child: TabBar(
                  // isScrollable: true,
                  physics: RangeMaintainingScrollPhysics(),
                  labelStyle: TextStyle(color: Colors.blue),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.blue,
                  dragStartBehavior: DragStartBehavior.start,
                  tabs: [
                    Tab(
                      child: Text(
                        'Foot and Mouth disease'.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(1.8),
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Hemorrhagic Septicemia'.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(1.8),
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Mastitis'.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(1.8),
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Deworming and vaccination schedule'.tr.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(1.8),
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Foot and Mouth disease in Buffalo'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.8),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/feeding_summer.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Symptoms'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Reusabledescription(
                                desciption:
                                    'Dripping saliva from the mouth'.tr),
                            Reusabledescription(desciption: 'Fever'.tr),
                            Reusabledescription(
                                desciption:
                                    'Blisters on mouth, tongue, gums, between hooves, udder and levee'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Reduces or stops animal feeding and chewing'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Animal walks with a limp especially when there are insects in the hooves'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'There is a sharp drop in milk production'
                                        .tr),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Control and Prevention'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Reusabledescription(
                                desciption:
                                    'The area or building where the outbreak of mouth and mouth epidemic has occurred should be disinfected by mild acid, alkali or fumigation'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Movement of vehicles and animals should be banned in the affected areas'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Affected animals should be kept separate from healthy animals'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Control is possible by vaccinating all susceptible animals to this disease and not allowing the virus to spread from infected animals'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Twice a year (May-June and October-November) vaccination is the only effective method of prevention'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'The first vaccine and after 15 to 30 days must be given to the cutlets and cuttings older than four months and vaccination must be done after every 6 months'
                                        .tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hemorrhagic Septicemia in Buffalo'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.8),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/feeding_summer.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Symptoms'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Reusabledescription(
                                desciption:
                                    'Having a very high fever (up to 107⁰ F) and the animal dying within an hour to 24 hours or the animal being found dead without showing any symptoms to the farmer'
                                        .tr),
                            Reusabledescription(
                                desciption: 'Profuse salivation'.tr),
                            Reusabledescription(
                                desciption:
                                    'Runny nose and difficulty in breathing'
                                        .tr),
                            Reusabledescription(desciption: 'Reddened eyes'.tr),
                            Reusabledescription(
                                desciption:
                                    'Stop grazing and become depressed'.tr),
                            Reusabledescription(
                                desciption:
                                    'It has been seen in a very acute condition that the animals mouth becomes stagnant with food or water'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Cognition with pain in the throat, neck and chest'
                                        .tr),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Control'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Reusabledescription(
                                desciption:
                                    'Immediately separate sick buffalo from healthy animals and sterilize the place and do not take it to public places such as pastures and other places where animals congregate as this disease spreads through inhalation, drinking water and feeding'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Dig a pit at least 5 feet deep to the dead animal and press it well by sprinkling salt'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Twice a year must be vaccinated against galghotu disease, first before the start of the rainy season (in the month of May-June) and the second before the onset of winter (in the month of October - November). By doing this, there can be a significant reductionin the animal mortality rate due to gallstone disease'
                                        .tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mastitis in Buffalo'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.8),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Mastitis-Blk-Cow.png'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Symptoms'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Reusabledescription(
                                desciption:
                                    'Swollen and reddening of teats'.tr),
                            Reusabledescription(
                                desciption: 'Milk mixed with blood'.tr),
                            Reusabledescription(
                                desciption:
                                    'Milk mixed with yellow or brown fluid with flakes or clots with foul smelling'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Swollen udder with hot and pain while touching it'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Swelling of udder as a hard mass'.tr),
                            Reusabledescription(
                                desciption:
                                    'Animal will not allow touching the udder and will kick while touching it'
                                        .tr),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Control'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Reusabledescription(
                                desciption:
                                    'Animal sheds should be clean and floor should be washed with running water'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Milker should washed their hand with soap before milking of each animal'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Teats/udder of the buffalo should be washed and dried up soft cloth before milking'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Buffalo should not be allowed to sit just after the milking and may be engaged with either fodder/concentrate mixture'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Milking should be done completely every time. Ensure that there is no left over milk in the udder'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Infected buffalo should be kept isolated from the herd'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Always maintain the proper hygienic condition in the herd and shed'
                                        .tr),
                            Reusabledescription(
                                desciption:
                                    'Immediately after detecting clinical signs, it should be consulted with qualified veterinarian for further treatment'
                                        .tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deworming Schedule for Buffalo'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.8),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                // margin: EdgeInsets.all(10),
                                child: Table(
                                  defaultColumnWidth: FixedColumnWidth(120.0),
                                  border: TableBorder.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 2),
                                  children: [
                                    TableRow(children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Age of Buffalo'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2.5),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Anthelmintic'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2.5),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Dose'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2.5),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Schedule'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2.5),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Column(
                                        children: [
                                          Text(
                                            '3-7 days'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Piparazine'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '5-10 ml per 10 kg of body weight'
                                                .tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Repeat in every 21 days upto 2 months'
                                                .tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Column(
                                        children: [
                                          Text(
                                            '3-6 months'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Albendazole'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '5 ml per kg of body weight'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Every month'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Column(
                                        children: [
                                          Text(
                                            '6-18 months'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Albendazole or Ivermetic injection'
                                                .tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '5 ml per kg of body weight'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Every 3 months'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Adult buffalo'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Albendazole , Fendendazole or Ivermetic injection'
                                                .tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '5 ml per kg of body weight'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Twice in year preferably before rainy and winter season'
                                                .tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Vaccination Schedule'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(2.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  // margin: EdgeInsets.all(10),
                                  child: Table(
                                    defaultColumnWidth: FixedColumnWidth(180.0),
                                    border: TableBorder.all(color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 2),
                                    children: [
                                      TableRow(
                                        children: [
                                          Column(
                                        children: [
                                          Text(
                                            'Disease'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2.5),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                          Column(
                                        children: [
                                          Text(
                                            'Age and time of vaccination'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2.5),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                        ]
                                      ),
                                      TableRow(
                                        children: [
                                          Column(
                                        children: [
                                          Text(
                                            'FMD'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                          Column(
                                        children: [
                                          Text(
                                            'First dose at 4 months of age and booster dose at 6 months of age.Repeat every six months interval preferably during March-April and September-October'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                        ]
                                      ),
                                      TableRow(
                                        children: [
                                          Column(
                                        children: [
                                          Text(
                                            'Hemorrhagic Septicemia'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                          Column(
                                        children: [
                                          Text(
                                            'First dose at 4-6 months of age and booster dose should be repeated every year preferably before rainy season in the months of May-June'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                        ]
                                      ),
                                      TableRow(
                                        children: [
                                          Column(
                                        children: [
                                          Text(
                                            'Black quarter'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                          Column(
                                        children: [
                                          Text(
                                            'First dose at 6 months of age and booster dose should be repeated every year preferably before rainy season in the months of May-June'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                        ]
                                      ),
                                      TableRow(
                                        children: [
                                          Column(
                                        children: [
                                          Text(
                                            'Brucellosis'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                          Column(
                                        children: [
                                          Text(
                                            'Single dose for female calf at the age of 4-8 months'.tr,
                                            style: TextStyle(
                                                fontSize: ResponsiveUtils.wp(2),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                        ]
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
