import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:ndri_climate/material/Reusabledescrip.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';

class Thermal_Stress extends StatefulWidget {
  const Thermal_Stress({super.key});

  @override
  State<Thermal_Stress> createState() => _Thermal_StressState();
}

class _Thermal_StressState extends State<Thermal_Stress> {
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
              title: 'About Murrah Buffalo'.tr,
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
                        'Symptoms of Heat Stress'.tr,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Use of water'.tr,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Other Heat Stress Management Strategies'.tr,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Managing Cold Stress'.tr,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
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
                              'Symptoms of Heat Stress'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text('Thermal stress occurs when the ambient temperature lies above or below thermoneutral zone.Dairy animals have been found to be negatively impacted with increased temperature and humidity'.tr),
                            SizedBox(
                              height: 30,
                            ),
                            Reusabledescription(
                                desciption: 'Rapid and weak pulse and Rapid but shallow breathing'.tr),
                            Reusabledescription(
                              desciption: 'Abnormal vital parameters: Elevated heart rate, respiration rate, rectal temperature etc'.tr),
                            Reusabledescription(
                                desciption:
                                    'Unusual salivation and Dizziness / unconsciousness'.tr),
                            Reusabledescription(
                                desciption:
                                    'Skin becomes dull and may be cold'.tr),
                            Reusabledescription(
                                desciption:
                                    'In case of heat stroke, body temperature is very high sometimes as high as 106 - 108°F'.tr),
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
                              'Use of Water to Mitigate Heat Stress'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/management.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Reusabledescription(
                                desciption: 'The most effective way of combating heat stress in buffalo is wallowing in the water pond'.tr),
                            Reusabledescription(
                              desciption: 'Various cooling systems have been developed for evaporative cooling such as holding-pen cooling,exit-lane cooling, and free-stall cooling. These systems are applicable for the animals maintained in covered pucca sheds. An evaporative system which uses water mist with fan is more effective and economises water use in comparison to repeatedly bathing the animals'.tr),
                            Reusabledescription(
                                desciption:
                                    'The buffalo needs at least twice a day bath in the summer. Misting/Fogging of water in the microenvironment of the animal at least thrice in an hour along with provision of fan is useful in hot dry weather. Auto Mister/ Fugger with mini pumps and cyclic timers are preferable'.tr),
                            Reusabledescription(
                                desciption:
                                    'Heat stress can also be managed by spraying/ sprinkling water directly on the body of animals for a period of 1 to 5 minutes at an interval of 10- 30 minutes. Fans/blowers should be used to induce evaporation from the skin of animals'.tr),
                            Reusabledescription(
                                desciption:
                                    'Ensure adequate round the clock drinking water to animals, which should be provided under shade'.tr),
                            
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
                              'Other Heat Stress Management Strategies'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/other strategies.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Reusabledescription(
                                desciption: 'During heat stress conditions buffaloes should not be allowed to move freely during day hours because they need protection against warm air storms, direct sun exposure and they should be provided with shelter in cool and shady places'.tr),
                            Reusabledescription(
                              desciption: 'The most effective source of shade is trees. They provide not only protection from sunlight, but also create a cooling effect through the evaporation of moisture from their leaves'.tr),
                            Reusabledescription(
                                desciption:
                                    'If shade trees are not available, thatched roof of a minimum height of 9 feet should be provided. Agri-nets with 20% perforation are also useful. If facilities are not available with the individual farmers, facilities available at the village shall be used by the community. Materials like paddy straw etc,painting the roof with white paint or,providing a false ceiling insulation will help provide a cooler environment. Create barriers against hot wind using thatched wall or wet gunny cloth/ gunny bags'.tr),
                            Reusabledescription(
                                desciption:
                                    'The buffalo shed should be well ventilated that the polluted air can directly diffused outside and clean and fresh air can enter into it. Ensure one ventilator of 3 x 1 feet per cow in covered shed. In these sheds heavy duty fan is best option to facilitate ventilation'.tr),
                            Reusabledescription(
                                desciption:
                                    'The proper plantation should be managed in surroundings so that the environment may be cool and fresh and warm air storm could not enter directly in the shed'.tr),
                            Reusabledescription(
                                desciption:
                                    'Air movement: Air movement is more important during hot-humid climate for providing cooling and comfort to the animal. Air movement increases the rate of heat loss from animals body surface, only as long as the air temperature is lower than the animals skin temperature'.tr),
                                    Reusabledescription(
                                      desciption: 'Feeding should be practiced during early morning, evening and at night'.tr),
                                    Reusabledescription(
                                      desciption: 'Prefer grazing during early morning and late evening hours to avoid the heat stress'.tr),
                                    Reusabledescription(desciption: 'Ration density may be increased so as to provide same nutrients at reduced dry matter intake. Diets with low-fibre and high fermentable carbohydrate have lower dietary heat increment compared to high fibre diets'.tr),
                                    Reusabledescription(desciption: 'Ensure increased mineral supplementation during hot weather to meet the increased demand of minerals. Potassium rich mineral mixture should be preferred'.tr)
                            
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
                              'Managing Cold Stress'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/other strategies.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Reusabledescription(
                                desciption:
                                    'Monitor weather conditions and act accordingly. Monitor temperature changes and provide more feed to animals in colder weather conditions'.tr),
                            Reusabledescription(
                                desciption:
                                    'Ensure there is enough shelter from the wind. Effects of cold stress increase when wind speed increases. Any kind of available protection, whether it is natural (bush, valley bottoms or hillsides) or man-made (such as simple windbreak fences or shelters) can be highly valuable in helping animals cope with extreme temperatures and wind-chill effects'.tr),
                            Reusabledescription(
                                desciption:
                                    'Provide bedding to help keep animal clean and dry. Bedding, such as barley straw, helps to withstand cold stress'.tr),
                            Reusabledescription(
                                desciption:
                                    'Provide additional feed. Increase grain and hay for when temperatures drop below the lower critical threshold level'.tr),
                            Reusabledescription(
                                desciption:
                                    'Provide water. Make sure animals have ample water available at all times. A limit in water available will limit feed intake and make it more difficult for animal to meet their energy requirements. Excessively cold water can severely limit water intake'.tr),
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
