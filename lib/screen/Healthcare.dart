import 'package:flutter/material.dart';
import 'package:ndri_climate/material/Appbarwithtabs.dart';
import 'package:ndri_climate/material/Reusabledescrip.dart';


class Healthcare extends StatefulWidget {
  const Healthcare({super.key});

  @override
  State<Healthcare> createState() => _HealthcareState();
}

class _HealthcareState extends State<Healthcare> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(40, 150),
              child: Appbarwithtabs(
                title: 'About Murrah Buffalo',
                Tabs: [
                  Text('Foot and Mouth disease'),
                  Text('Hemorrhagic Septicemia'),
                  Text('Mastitis'),
                  Text('Deworming and vaccination schedule')
                ],
              )),
          body: TabBarView(children: [
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
                        'Foot and Mouth disease in Buffalo',
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
                                    'assets/images/feeding_summer.jpeg'),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Symptoms',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Reusabledescription(
                        desciption:
                            'Dripping saliva from the mouth'),
                    Reusabledescription(
                        desciption:
                            'Fever'),
                    Reusabledescription(
                        desciption:
                            'Blisters on mouth, tongue, gums, between hooves, udder and levee'),
                    Reusabledescription(
                        desciption:
                            'Reduces or stops animal feeding and chewing'),
                    Reusabledescription(
                        desciption:
                            'Animal walks with a limp especially when there are insects in the hooves'),
                    Reusabledescription(
                        desciption: 'There is a sharp drop in milk production'),
                    SizedBox(height: 10,),
                    Text(
                        'Control and Prevention',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       Reusabledescription(
                        desciption:
                            'The area or building where the outbreak of mouth and mouth epidemic has occurred should be disinfected by mild acid, alkali or fumigation.'),
                    Reusabledescription(
                        desciption:
                            'Movement of vehicles and animals should be banned in the affected areas.'),
                    Reusabledescription(
                        desciption:
                            'Affected animals should be kept separate from healthy animals.'),
                    Reusabledescription(
                        desciption:
                            'Control is possible by vaccinating all susceptible animals to this disease and not allowing the virus to spread from infected animals.'),
                    Reusabledescription(
                        desciption:
                            'Twice a year (May-June and October-November) vaccination is the only effective method of prevention.'),
                    Reusabledescription(
                        desciption:
                            'The first vaccine and after 15 to 30 days must be given to the cutlets and cuttings older than four months and vaccination must be done after every 6 months.'),

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
                            'Dripping saliva from the mouth'),
                    Reusabledescription(
                        desciption:
                            'Fever'),
                    Reusabledescription(
                        desciption:
                            'Blisters on mouth, tongue, gums, between hooves, udder and levee'),
                    Reusabledescription(
                        desciption:
                            'Reduces or stops animal feeding and chewing'),
                    Reusabledescription(
                        desciption:
                            'Animal walks with a limp especially when there are insects in the hooves'),
                    Reusabledescription(
                        desciption: 'There is a sharp drop in milk production'),
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
                    Container(
                      width: 366,
                      height: 218,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/feeding_smart.jpg'),
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
        ));
  }
}
