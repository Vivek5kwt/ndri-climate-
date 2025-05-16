import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ndri_climate/material/Reusabledescrip.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/material/tables.dart';

class Feeding_management extends StatefulWidget {
  const Feeding_management({super.key});

  @override
  State<Feeding_management> createState() => _Feeding_managementState();
}

class _Feeding_managementState extends State<Feeding_management> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ResponsiveUtils.hp(7)),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            title: 'Feeding Management'.tr,
            show_back_arrow: false,
          ),
        ),
        body: Column(
          children: [
            Container(
              width: screenW,
              color: const Color(0xFFC8EBFF),
              child: TabBar(
                isScrollable: false,
                labelStyle: TextStyle(
                  fontSize: ResponsiveUtils.wp(3.3),
                  fontWeight: FontWeight.bold,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.blue,
                dragStartBehavior: DragStartBehavior.start,
                tabs: [
                  Tab(
                    child: Text(
                      'Necessity'.tr,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.wp(3.3),
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'In Summers'.tr,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.wp(3.3),
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'In Winters'.tr,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.wp(3.3),
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Climate Smart Practices'.tr,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.wp(3.3),
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    width: screenW,
                    child: Container(
                      margin: EdgeInsets.all(ResponsiveUtils.wp(3)),
                      padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Necess of feeding Management in Summer and Winter'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(4),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(1)),
                            Reusabledescription(
                              desciption: 'Temperature and humidity during April to middle of September are the cause of heat stress of the livestock. This heat stress results from the animal’s inability to dissipate sufficient heat to maintain its body temperature.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'High ambient temperature, relative humidity and radiant energy compromise the ability of animals to dissipate heat.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Therefore, it increases in body temperature and reduces in productive performance particularly in milk production. This decrease can be either transitory or long term depending on the length and severity of heat stress.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'The decrease in milk production may ranges from 10 to 25%. Therefore, it is utmost necessary to manage feeding practices during summer to alleviate heat stress of the dairy animals.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'During winter season many animals often refuse to eat, become feverish and pneumonitic which in turn affects the milk production, health and reproduction of the animal. Severe cold surroundings result in increased energy loss, which has to be compensated by giving extra calorie-rich feed and special care.'.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenW,
                    child: Container(
                      margin: EdgeInsets.all(ResponsiveUtils.wp(3)),
                      padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Feeding Management During Summer'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(4),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(1)),
                            Container(
                              width: double.infinity,
                              height: ResponsiveUtils.hp(28),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/feeding_summer.webp'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Reusabledescription(
                              desciption: 'Provision of or fresh tap water or at least normal drinking water to the livestock as per requirement throughout day and night'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Prefer to feed the animal during night time or early morning'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Prefer grazing during early morning and late evening'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Ration especially energy density of the ration must be increased by decreasing straw and increasing concentrate mixture'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Provide diet with low fiber and high soluble carbohydrate'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Provide potassium rich mineral mixture'.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenW,
                    child: Container(
                      margin: EdgeInsets.all(ResponsiveUtils.wp(3)),
                      padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Feeding Management During Winter'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(4),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(1)),
                            Container(
                              width: double.infinity,
                              height: ResponsiveUtils.hp(28),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/feeding_winter.webp'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Reusabledescription(
                              desciption: 'Nutrition, especially balanced rations, fortified and supplemented with protein ingredients like whole cotton seed or cakes, becomes important'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Rations containing about 17 per cent fibre in the animal feed are also helpful to increase fat percentage in milk. Concentrate mixture should comprise grains (40 percent), oil cakes (32 per cent), brans (25 per cent), mineral mixture (2 per cent) and common salt (1 per cent)'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Milch animals should be fed with a mixture of oil cakes and jiggery to maintain the body temperature'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Essential salts / mineral mixture in appropriate quantities must be mixed with feed and given to the animals'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Apart from this the extra energy-rich grains at approximately 0.8 per cent of body weight should be fed to counter the stress of cold for maintaining normal milk production and other activities'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'To prevent bloat in animals, mix berseem with dry fodder like wheat straw. Never feed rice straw alone.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Water, possibly lukewarm, should be clean and available four times a day at their drinking time'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'The quantity of green fodder must be kept in limited quantities in the animal feed, as it increases the chances of occurrence of diarrhea.Most of the time green fodder are to be mixed with straw to prevent diarrhea. Addition of straw will be useful in chewing activity which is essential for increasing body temperature.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'If there is an adequate quantity of green fodder still available after feeding the animals, this must be dried in the sun and stored for periods of shortage'.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenW,
                    child: Container(
                      margin: EdgeInsets.all(ResponsiveUtils.wp(3)),
                      padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Climate Smart Feeding Practices'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(4),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(1)),
                            Container(
                              width: double.infinity,
                              height: ResponsiveUtils.hp(28),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/feeding_smart.webp'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Reusabledescription(
                              desciption: 'Providing balanced ration with concentrate mixture having buffer (Sodium bi-carbonate or cation based mineral supplement) for high producing buffalo during heat stress period.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Mineral mixture supplementation with feed @ 50-100 gm per milch buffalo perday depending upon body weight and production performance.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Prefer grazing during early morning and late evening'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Supplementation of dietary soluble carbohydrate may compensate the heat stress related reduction in milch buffalo without affecting chewing activity.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Supplementation of ‘Prill Fat’ (saturated fat) of 50-75 gm per lactating Murrah buffalo per day during heat stress may compensate reduced milk production.'.tr,
                            ),
                            Reusabledescription(
                              desciption: 'Vitamin A, C, E and Zinc supplementation showed positive effects towards ameliorating environmental heat stress'.tr,
                            ),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Text(
                              'Ration Formulation for a lactating buffalo with body weight 450-500 Kg) during heat stress season'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(3.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(1)),
                            MilkYieldTable(),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Text(
                              '*Concentrate mixture formulation'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(3.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(1)),
                            FormulationTable(),
                            SizedBox(height: ResponsiveUtils.hp(2)),
                            Text(
                              'Note'.tr,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.wp(3.5),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(1)),
                            Reusabledescription(desciption: 'Provide additional 1.5 – 2 kg concentrate mixture during heat stress season'.tr),
                            Reusabledescription(desciption: 'Provide additional 1 kg of concentrate mixture per 2.5 litre of milk production beyond 10/15 kg of milk production'.tr),
                            Reusabledescription(desciption: 'Provide 500 gm of grain or 2.5 Kg cereal fodder for every 50 Kg increase in body weight beyond 500 Kg'.tr),
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
