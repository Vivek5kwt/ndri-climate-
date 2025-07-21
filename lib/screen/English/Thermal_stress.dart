import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ndri_climate/material/Reusabledescrip.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';

class Thermal_Stress extends StatefulWidget {
  const Thermal_Stress({super.key});

  @override
  State<Thermal_Stress> createState() => _Thermal_StressState();
}

class _Thermal_StressState extends State<Thermal_Stress> {
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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ResponsiveUtils.hp(7)),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            title: 'Thermal Stress Management'.tr,
            show_back_arrow: false,
          ),
        ),
        body: Column(
          children: [
            Container(
              color: const Color(0xFFC8EBFF),
              padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(1)),
              child: TabBar(
                isScrollable: true,
                labelStyle: _tabTextStyle.copyWith(color: const Color(0xFF1976D2)),
                unselectedLabelStyle:
                    _tabTextStyle.copyWith(color: Colors.grey.shade600),
                indicatorColor: const Color(0xFF1976D2),
                indicatorWeight: 3,
                dragStartBehavior: DragStartBehavior.start,
                tabs: [
                    Tab(
                      child: Text(
                        'Symptoms of Heat Stress'.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(4),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Use of Water'.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(4),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Other Heat Stress Management Strategies'.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(4),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Managing Cold Stress'.tr,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.wp(4),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Symptoms Tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Symptoms of Heat Stress'.tr,
                              style: _sectionTitleStyle,
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Text(
                              'Thermal stress occurs when the ambient temperature lies above or below thermoneutral zone. Dairy animals have been found to be negatively impacted with increased temperature and humidity.'
                                  .tr,
                              style: _subtitleTextStyle,
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Reusabledescription(
                              desciption: 'Rapid and weak pulse and rapid but shallow breathing'.tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption: 'Abnormal vital parameters: Elevated heart rate, respiration rate, rectal temperature etc.'.tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption: 'Unusual salivation and dizziness/unconsciousness'.tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption: 'Skin becomes dull and may be cold'.tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption: 'In case of heat stroke, body temperature is very high sometimes as high as 106 - 108°F.'.tr,
                              textStyle: _subtitleTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Use of Water to Mitigate Heat Stress'.tr,
                              style: _sectionTitleStyle,
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Container(
                              width: double.infinity,
                              height: ResponsiveUtils.hp(25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/management.webp'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Reusabledescription(
                              desciption: 'The most effective way of combating heat stress in buffalo is wallowing in the water pond.'.tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Evaporative cooling systems like holding-pen cooling, exit-lane cooling, and free-stall cooling are applicable in covered sheds. An evaporative system using water mist with fans is more efficient and economizes water compared to bathing.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Buffalo need at least two baths per day in summer. Misting/fogging the microenvironment thrice per hour with fans helps in hot-dry weather. Automatic misters with mini pumps and timers are preferable.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Spraying or sprinkling water directly on animals for 1–5 minutes every 10–30 minutes, combined with fans/blowers, increases evaporative heat loss.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption: 'Ensure round-the-clock access to drinking water under shade.'.tr,
                              textStyle: _subtitleTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Other Heat Stress Management Strategies Tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Other Heat Stress Management Strategies'.tr,
                              style: _sectionTitleStyle,
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Container(
                              width: double.infinity,
                              height: ResponsiveUtils.hp(25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/other strategies.webp'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Reusabledescription(
                              desciption:
                              'During heat stress conditions buffaloes should not be allowed to move freely during day hours because they need protection against warm air storms, direct sun exposure and they should be provided with shelter in cool and shady places.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Shade trees provide protection and cooling via moisture evaporation from leaves.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'If trees are unavailable, a thatched roof of at least 9 feet is useful. Agri-nets (20% perforation), white-painted roofs, false ceiling insulation, or barriers (thatched walls or wet gunny cloth) help create cooler environments.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Sheds should be well-ventilated so polluted air exits and fresh air enters. Provide one 3×1 ft ventilator per cow in covered sheds; heavy-duty fans aid ventilation.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Plant trees around sheds to cool the environment and block warm winds.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Air movement is crucial in hot-humid climates for cooling; it increases heat loss if air temperature is below skin temperature.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Feed during early morning, evening, and night to avoid heat peaks.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Prefer grazing in early morning and late evening when temperatures are lower.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Increase ration density to deliver nutrients with reduced dry matter intake. Low-fibre, high-fermentable carbohydrate diets produce lower dietary heat increment.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Provide increased mineral supplementation during heat; potassium-rich mineral mixtures are preferred.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Managing Cold Stress Tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Managing Cold Stress'.tr,
                              style: _sectionTitleStyle,
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Container(
                              width: double.infinity,
                              height: ResponsiveUtils.hp(25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/other strategies.webp'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Reusabledescription(
                              desciption:
                              'Monitor weather conditions and provide extra feed during colder temperatures.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Ensure windbreaks or shelters to protect animals from cold winds; natural bushes or simple fences can be effective.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Provide bedding, such as straw, to keep animals clean and dry and help them withstand cold stress.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Increase grain and hay when temperatures drop below the lower critical threshold.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                            Reusabledescription(
                              desciption:
                              'Ensure ample water is available; warm water may be necessary to encourage intake, as cold water can limit consumption.'
                                  .tr,
                              textStyle: _subtitleTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}