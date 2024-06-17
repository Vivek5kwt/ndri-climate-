import 'package:flutter/material.dart';
import 'package:ndri_climate/material/Reusabledescrip.dart';
import 'package:ndri_climate/material/reusableappbar.dart';

class About_Murrah extends StatefulWidget {
  const About_Murrah({super.key});

  @override
  State<About_Murrah> createState() => _About_MurrahState();
}

class _About_MurrahState extends State<About_Murrah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(40, 60),child: ReuseAppbar(
        title: 'About Murrah Buffalo',)),
        body: Container(
            height: MediaQuery.of(context).size.height,
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
              border: Border.all(
                color: Colors.grey),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Murrah Buffalo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                ),
                Reusabledescription(desciption: 'The best milch breed of Buffalo and known as Black Gold in Haryana',),
                Reusabledescription(desciption: 'Murrah buffalo constitute 44.39 percent of the total buffalo population of the country',),
                Reusabledescription(desciption: 'World’s best buffalo breed i.e. Murrah predominantly found in Haryana and adjoining states of Punjab and Delhi'),
                SizedBox(
                  height: 10,
                ),
                Text('Physical Characteristics',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                ),
                SizedBox(
                  height: 5,
                ),
                Reusabledescription(desciption: 'Jet black and massive with long and deep body'),
                Reusabledescription(desciption: 'Head of female is short, fine and clear-cut'),
                Reusabledescription(desciption: 'Bulls are heavy and broad with prominent cushion and dense hair'),
                Reusabledescription(desciption: 'Horns are short and tightly curled in a spiral form'),
                Reusabledescription(desciption: 'Eyes are bright, active and prominent in females but slightly shrunken in males'),
                Reusabledescription(desciption: 'Ears are short, thin and alert'),
                Reusabledescription(desciption: 'Neck is long and thin in females and thick massive in males'),
                Reusabledescription(desciption: 'Hips are broad, fore and hind quarters are drooping'),
                Reusabledescription(desciption: 'Tail is long reaching below the hock up to fetlock and ending in a while switch'),
                Reusabledescription(desciption: 'Udder is capacious extending from hind legs to just behind navel flap with prominent milk veins.'),
                Reusabledescription(desciption: 'Teats are long and placed uniformly wide apart'),
                Reusabledescription(desciption: 'Hind treats are generally longer than the fore treats'),
                

                
            
              ],
            
            ),
          ),
        ),

    );
  }
}