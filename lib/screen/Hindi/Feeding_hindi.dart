import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ndri_climate/main.dart';
// import 'package:ndri_climate/material/Appbarwithtabs.dart';
import 'package:ndri_climate/material/Reusabledescrip.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
// import 'package:ndri_climate/material/reusableappbar.dart';

class FeedingHindi extends StatefulWidget {
  const FeedingHindi({super.key});

  @override
  State<FeedingHindi> createState() => _FeedingHindiState();
}

class _FeedingHindiState extends State<FeedingHindi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final style = TextStyle(fontSize: 13);
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
              title: 'About Murrah Buffalo',
              show_back_arrow: false,
            ),
          ),

          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0xFFC8EBFF),
                child: TabBar(
                  isScrollable: false,
                  // physics: RangeMaintainingScrollPhysics(),
                  labelStyle: TextStyle(color: Colors.blue),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.blue,
                  dragStartBehavior: DragStartBehavior.start,
                  tabs: [
                    Tab(
                      child: Text(
                        'आवश्यकता',
                        style: TextStyle(fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'गर्र्मरयों के र्दौरान',
                        style: TextStyle(fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'सर्र्दयों के र्दौरान आहार प्रबंधन',
                        style: TextStyle(fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'क्लाइर्मेि थर्मािर आहार प्रबंधन',
                        style: TextStyle(fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'गर्मी और सर्दी र्में आहार प्रबंधन की आवश्यकता',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Reusabledescription(
                              desciption:
                                  'अप्रैल से र्मध्य ससतंबर के र्दौरान तापर्मान और आर्द्रता पशुधन र्में ग्रीष् र्म तनाव का'),
                          Reusabledescription(
                              desciption:
                                  'उच्च वातावरणीय तापर्मान, सापेसिक आर्द्रता और र्दीसिर्मान ऊर्ार पशुओं के शरीर की गर्मी'),
                          Reusabledescription(
                              desciption:
                                  'Therefore, it increases in body temperature and reduces in productive performance particularly in milk production. This decrease can be either transitory or long termdepending on the length and severity of heat stress.'),
                          Reusabledescription(
                              desciption:
                                  'The decrease in milk production may ranges from 10 to 25%. Therefore, it is utmost necessary to manage feeding practices during summer to alleviate heat stress of the dairy animals.'),
                          Reusabledescription(
                              desciption:
                                  'During winter season many animals often refuse to eat, become feverish andpneumonitic which in turn affects the milk production, health and reproduction of theanimal. Severe cold surroundings result in increased energy loss, which has to becompensated by giving extra calorie-rich feed and special care.'),
                        ],
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Feeding Management During Summer',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                            height: 20,
                          ),
                          Reusabledescription(
                              desciption:
                                  'Provision of or fresh tap water or at least normal drinking water to the livestock as per requirement throughout day and night'),
                          Reusabledescription(
                              desciption:
                                  'Prefer to feed the animal during night time or early morning'),
                          Reusabledescription(
                              desciption:
                                  'Prefer grazing during early morning and late evening'),
                          Reusabledescription(
                              desciption:
                                  'Ration especially energy density of the ration must be increased by decreasing straw and increasing concentrate mixture'),
                          Reusabledescription(
                              desciption:
                                  'Provide diet with low fiber and high soluble carbohydrate'),
                          Reusabledescription(
                              desciption:
                                  'Provide potassium rich mineral mixture'),
                        ],
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
                              'Feeding Management During Winter',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/feeding_winter.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Reusabledescription(
                                desciption:
                                    'Nutrition, especially balanced rations, fortified and supplemented with protein ingredients like whole cotton seed or cakes, becomes important'),
                            Reusabledescription(
                                desciption:
                                    'Rations containing about 17 per cent fibre in the animal feed are also helpful to increase fat percentage in milk. Concentrate mixture should comprise grains (40 percent), oil cakes (32 per cent), brans (25per cent), mineral mixture (2per cent) and common salt (1 per cent)'),
                            Reusabledescription(
                                desciption:
                                    'Milch animals should be fed with a mixture of oil cakes and jiggery to maintain thebody temperature'),
                            Reusabledescription(
                                desciption:
                                    'Essential salts / mineral mixture in appropriate quantities must be mixed with feedand given to the animals'),
                            Reusabledescription(
                                desciption:
                                    'Apart from this the extra energy-rich grains at approximately 0.8 per cent of bodyweight should be fed to counter the stress of cold for maintaining normal milk production and other activities'),
                            Reusabledescription(
                                desciption:
                                    'To prevent bloat in animals, mix berseem with dry fodder like wheat straw. Neverfeed rice straw alone.'),
                            Reusabledescription(
                                desciption:
                                    'Water, possibly lukewarm, should be clean and available four times a day at theirdrinking time'),
                            Reusabledescription(
                                desciption:
                                    'The quantity of green fodder must be kept in limited quantities in the animal feed, asit increases the chances of occurrence of diarrhea.Most of the time green fodder are to be mixed straw with to prevent diarrhea. Addition of straw will be useful in chewing activity which is essential for increasing body temperature.'),
                            Reusabledescription(
                                desciption:
                                    'If there is an adequate quantity of green fodder still available after feeding theanimals, this must be dried in the sun and stored for periods of shortage'),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Climate Smart Practices',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 366,
                            height: 218,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/feeding_smart.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Reusabledescription(
                              desciption:
                                  'Providing balanced ration with concentrate mixture having buffer (Sodium bi-carbonate or cation based mineral supplement) for high producing buffalo during heat stress period.'),
                          Reusabledescription(
                              desciption:
                                  'Mineral mixture supplementation with feed @ 50-100 gm per milch buffalo perday depending upon body weight and production performance.'),
                          Reusabledescription(
                              desciption:
                                  'Prefer grazing during early morning and late evening'),
                          Reusabledescription(
                              desciption:
                                  'Supplementation of dietary soluble carbohydrate may compensate the heat stress related reduction in milch buffalo without affecting chewing activity.'),
                          Reusabledescription(
                              desciption:
                                  'Supplementation of ‘Prill Fat’ (saturated fat) of 50-75 gm per lactating Murrah buffalo per day during heat stress may compensate reduced milk production.'),
                          Reusabledescription(
                              desciption:
                                  'Vitamin A, C, E and Zinc supplementation showed positive effects towards ameliorating environmental heat stress'),
                        ],
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
