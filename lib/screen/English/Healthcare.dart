import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  // Common text styles
  final TextStyle _tabTextStyle = TextStyle(
    fontSize: ResponsiveUtils.wp(4),
    fontWeight: FontWeight.bold,
  );
  final TextStyle _sectionTitleStyle = TextStyle(
    fontSize: ResponsiveUtils.wp(5),
    fontWeight: FontWeight.bold,
    color: const Color(0xFF1976D2),
  );
  final TextStyle _subtitleTextStyle = TextStyle(
    fontSize: ResponsiveUtils.wp(3.5),
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ResponsiveUtils.hp(7)),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            title: 'Health Care Management'.tr,
            show_back_arrow: false,
          ),
        ),
        body: Column(
          children: [
            Container(
              width: width,
              color: const Color(0xFFC8EBFF),
              padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(1)),
              child: TabBar(
                isScrollable: true,
                physics: const RangeMaintainingScrollPhysics(),
                labelStyle: _tabTextStyle.copyWith(color: const Color(0xFF1976D2)),
                unselectedLabelStyle:
                _tabTextStyle.copyWith(color: Colors.grey.shade600),
                indicatorColor: const Color(0xFF1976D2),
                indicatorWeight: 3,
                dragStartBehavior: DragStartBehavior.start,
                tabs: [
                  Tab(
                    child: Text(
                      'Foot and Mouth disease'.tr,
                      style: _tabTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Hemorrhagic Septicemia'.tr,
                      style: _tabTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Mastitis'.tr,
                      style: _tabTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Deworming and vaccination schedule'.tr,
                      style: _tabTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                _healthTab(
                  title: 'Foot and Mouth disease in Buffalo'.tr,
                  imagePath: 'assets/images/feeding_summer.webp',
                  symptoms: [
                    'Dripping saliva from the mouth'.tr,
                    'Fever'.tr,
                    'Blisters on mouth, tongue, gums, between hooves, udder and levee'.tr,
                    'Reduces or stops animal feeding and chewing'.tr,
                    'Animal walks with a limp especially when there are insects in the hooves'.tr,
                    'There is a sharp drop in milk production'.tr,
                  ],
                  controls: [
                    'The area or building where the outbreak of mouth and mouth epidemic has occurred should be disinfected by mild acid, alkali or fumigation'.tr,
                    'Movement of vehicles and animals should be banned in the affected areas'.tr,
                    'Affected animals should be kept separate from healthy animals'.tr,
                    'Control is possible by vaccinating all susceptible animals to this disease and not allowing the virus to spread from infected animals'.tr,
                    'Twice a year (May-June and October-November) vaccination is the only effective method of prevention'.tr,
                    'The first vaccine and after 15 to 30 days must be given to the cutlets and cuttings older than four months and vaccination must be done after every 6 months'.tr,
                  ],
                ),
                _healthTab(
                  title: 'Hemorrhagic Septicemia in Buffalo'.tr,
                  imagePath: 'assets/images/feeding_summer.webp',
                  symptoms: [
                    'Having a very high fever (up to 107⁰ F) and the animal dying within an hour to 24 hours or the animal being found dead without showing any symptoms to the farmer'.tr,
                    'Profuse salivation'.tr,
                    'Runny nose and difficulty in breathing'.tr,
                    'Reddened eyes'.tr,
                    'Stop grazing and become depressed'.tr,
                    'It has been seen in a very acute condition that the animals mouth becomes stagnant with food or water'.tr,
                    'Cognition with pain in the throat, neck and chest'.tr,
                  ],
                  controls: [
                    'Immediately separate sick buffalo from healthy animals and sterilize the place and do not take it to public places such as pastures and other places where animals congregate as this disease spreads through inhalation, drinking water and feeding'.tr,
                    'Dig a pit at least 5 feet deep to the dead animal and press it well by sprinkling salt'.tr,
                    'Twice a year must be vaccinated against galghotu disease, first before the start of the rainy season (in the month of May-June) and the second before the onset of winter (in the month of October - November). By doing this, there can be a significant reductionin the animal mortality rate due to gallstone disease'.tr,
                  ],
                ),
                _healthTab(
                  title: 'Mastitis in Buffalo'.tr,
                  imagePath: 'assets/images/Mastitis-Blk-Cow.webp',
                  symptoms: [
                    'Swollen and reddening of teats'.tr,
                    'Milk mixed with blood'.tr,
                    'Milk mixed with yellow or brown fluid with flakes or clots with foul smelling'.tr,
                    'Swollen udder with hot and pain while touching it'.tr,
                    'Swelling of udder as a hard mass'.tr,
                    'Animal will not allow touching the udder and will kick while touching it'.tr,
                  ],
                  controls: [
                    'Animal sheds should be clean and floor should be washed with running water'.tr,
                    'Milker should washed their hand with soap before milking of each animal'.tr,
                    'Teats/udder of the buffalo should be washed and dried up soft cloth before milking'.tr,
                    'Buffalo should not be allowed to sit just after the milking and may be engaged with either fodder/concentrate mixture'.tr,
                    'Milking should be done completely every time. Ensure that there is no left over milk in the udder'.tr,
                    'Infected buffalo should be kept isolated from the herd'.tr,
                    'Always maintain the proper hygienic condition in the herd and shed'.tr,
                    'Immediately after detecting clinical signs, it should be consulted with qualified veterinarian for further treatment'.tr,
                  ],
                ),
                _scheduleTab(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _healthTab({
    required String title,
    required String imagePath,
    required List<String> symptoms,
    required List<String> controls,
  }) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(2)),
      child: Container(
        margin: EdgeInsets.only(top: ResponsiveUtils.hp(2)),
        padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _sectionTitleStyle),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Container(
                width: width,
                height: ResponsiveUtils.hp(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              Text(
                'Symptoms'.tr,
                style: TextStyle(
                  fontSize: ResponsiveUtils.wp(4),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1976D2),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              ...symptoms.map(
                    (e) => Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(0.8)),
                  child: Reusabledescription(
                    desciption: "• $e",
                    textStyle: _subtitleTextStyle,
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              Text(
                'Control and Prevention'.tr,
                style: TextStyle(
                  fontSize: ResponsiveUtils.wp(4),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1976D2),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              ...controls.map(
                    (e) => Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(0.8)),
                  child: Reusabledescription(
                    desciption: "• $e",
                    textStyle: _subtitleTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scheduleTab() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(2)),
      child: Container(
        margin: EdgeInsets.only(top: ResponsiveUtils.hp(2)),
        padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deworming Schedule for Buffalo'.tr,
                style: _sectionTitleStyle,
              ),
              SizedBox(height: ResponsiveUtils.hp(1.5)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(ResponsiveUtils.wp(36)),
                  border: TableBorder.all(color: Colors.black, width: 1.5),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.blue.shade50),
                      children: [
                        _tableHeader('Age of Buffalo'.tr),
                        _tableHeader('Anthelmintic'.tr),
                        _tableHeader('Dose'.tr),
                        _tableHeader('Schedule'.tr),
                      ],
                    ),
                    _tableRow([
                      '3-7 days'.tr,
                      'Piparazine'.tr,
                      '5-10 ml per 10 kg of body weight'.tr,
                      'Repeat in every 21 days upto 2 months'.tr,
                    ]),
                    _tableRow([
                      '3-6 months'.tr,
                      'Albendazole'.tr,
                      '5 ml per kg of body weight'.tr,
                      'Every month'.tr,
                    ]),
                    _tableRow([
                      '6-18 months'.tr,
                      'Albendazole or Ivermetic injection'.tr,
                      '5 ml per kg of body weight'.tr,
                      'Every 3 months'.tr,
                    ]),
                    _tableRow([
                      'Adult buffalo'.tr,
                      'Albendazole , Fendendazole or Ivermetic injection'.tr,
                      '5 ml per kg of body weight'.tr,
                      'Twice in year preferably before rainy and winter season'.tr,
                    ]),
                  ],
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              Text(
                'Vaccination Schedule'.tr,
                style: _sectionTitleStyle,
              ),
              SizedBox(height: ResponsiveUtils.hp(1.5)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(ResponsiveUtils.wp(48)),
                  border: TableBorder.all(color: Colors.black, width: 1.5),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.blue.shade50),
                      children: [
                        _tableHeader('Disease'.tr),
                        _tableHeader('Age and time of vaccination'.tr),
                      ],
                    ),
                    _tableRow(['FMD', 'First dose at 4 months of age and booster dose at 6 months of age.Repeat every six months interval preferably during March-April and September-October']),
                    _tableRow(['Hemorrhagic Septicemia', 'First dose at 4-6 months of age and booster dose should be repeated every year preferably before rainy season in the months of May-June']),
                    _tableRow(['Black quarter', 'First dose at 6 months of age and booster dose should be repeated every year preferably before rainy season in the months of May-June']),
                    _tableRow(['Brucellosis', 'Single dose for female calf at the age of 4-8 months']),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeader(String text) => Padding(
    padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(0.8)),
    child: Text(
      text.tr,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: ResponsiveUtils.wp(4),
      ),
    ),
  );

  TableRow _tableRow(List<String> cells) {
    return TableRow(
      children: cells
          .map(
            (text) => Padding(
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveUtils.hp(0.8),
            horizontal: ResponsiveUtils.wp(1),
          ),
          child: Text(
            text.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveUtils.wp(3.5),
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}
