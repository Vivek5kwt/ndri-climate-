import 'package:flutter/material.dart';
import 'package:ndri_climate/main.dart';
import 'package:ndri_climate/material/Reusabledescrip.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';

class About_Murrah extends StatefulWidget {
  const About_Murrah({super.key});

  @override
  State<About_Murrah> createState() => _About_MurrahState();
}

class _About_MurrahState extends State<About_Murrah> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final style = TextStyle(fontSize: 14);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
          preferredSize: Size(40, 60),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            show_back_arrow: true,
            title: 'About Murrah Buffalo'.tr,
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height / 0.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Murrah Buffalo'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/murrah femle.jpg'),
                        fit: BoxFit.fitWidth)),
              ),
              SizedBox(height: 20,),
              Reusabledescription(
                desciption:
                    'The best milch breed of Buffalo and known as Black Gold in Haryana'.tr,
              ),
              Reusabledescription(
                desciption:
                    'Murrah buffalo constitute 44.39 percent of the total buffalo population of the country'.tr,
              ),
              Reusabledescription(
                  desciption:
                      'World’s best buffalo breed i.e. Murrah predominantly found in Haryana and adjoining states of Punjab and Delhi'.tr),
              SizedBox(
                height: 10,
              ),
              Text(
                'Physical Characteristics'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Reusabledescription(
                  desciption: 'Jet black and massive with long and deep body'.tr),
              Reusabledescription(
                  desciption: 'Head of female is short, fine and clear-cut'.tr),
              Reusabledescription(
                  desciption:
                      'Bulls are heavy and broad with prominent cushion and dense hair'.tr),
              Reusabledescription(
                  desciption:
                      'Horns are short and tightly curled in a spiral form'.tr),
              Reusabledescription(
                  desciption:
                      'Eyes are bright, active and prominent in females but slightly shrunken in males'),
              Reusabledescription(desciption: 'Ears are short, thin and alert'.tr),
              Reusabledescription(
                  desciption:
                      'Neck is long and thin in females and thick massive in males'.tr),
              Reusabledescription(
                  desciption:
                      'Hips are broad, fore and hind quarters are drooping'.tr),
              Reusabledescription(
                  desciption:
                      'Tail is long reaching below the hock up to fetlock and ending in a while switch'.tr),
              Reusabledescription(
                  desciption:
                      'Udder is capacious extending from hind legs to just behind navel flap with prominent milk veins.'.tr),
              Reusabledescription(
                  desciption: 'Teats are long and placed uniformly wide apart'.tr),
              Reusabledescription(
                  desciption:
                      'Hind treats are generally longer than the fore treats'.tr),
              SizedBox(
                height: 30,
              ),
              Text(
                'Performance Traits of Murrah Buffalo'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
              width: MediaQuery.of(context).size.width,
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(1.4),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Parameters'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Quantity'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Average Birth weight'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Male calves: 32 kg'.tr),
                          Text('Female calves: 30 kg'.tr),
                        ],
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Average Body weight of adult animal'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Male: 567 kg'.tr),
                          Text('Female: 516 kg'.tr),
                        ],
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Average age of first service'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('943.4 days'.tr),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Average age of first calving'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('1319 days'.tr),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total Lactation milk yield (average)'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('1752 kg (1003 kg – 2057 kg)'.tr,style: style,),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Lactation length (average)'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('307 days'.tr),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Dry period (average)'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('187.6 days'.tr),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('On an average milk contains fat'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('7.3%'),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Overall Calving interval (average)'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('452.9 days'.tr),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Number of service per conception (average)'.tr),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('1.93'),
                    ),
                  ]),
                ],
              ),
            ),
            ]),
          ),
        ),
      ),
    );
  }
}

