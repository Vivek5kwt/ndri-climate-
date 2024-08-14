import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';

class Fodder extends StatefulWidget {
  const Fodder({super.key});

  @override
  State<Fodder> createState() => _FodderState();
}

class _FodderState extends State<Fodder> {
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
              title: 'Fodder Management'.tr,
              show_back_arrow: false,
            ),
          ),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0xFFC8EBFF), 
                child: TabBar(
                  isScrollable: true,
                  physics: RangeMaintainingScrollPhysics(),
                  labelStyle: TextStyle(color: Colors.blue),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.blue,
                  dragStartBehavior: DragStartBehavior.start,
                  tabs: [
                    Tab(
                      child: Text(
                        'Sorghum'.tr,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Maize'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Oats'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Berseem'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
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
                              'SORGHUM'.tr,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/sorghum.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 20,
                            ),    
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Seed Rate and Sowing Method'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('The crop is sown in rows of 30cm (single cut) to 45 cm (multi cut) apart with a plant to plant spacing of 15 cm. For sorghum 50-60 kg/ha seed is sufficient,sown at a depth of 2-5 cm.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                softWrap: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sowing Time'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Summer:20 March to 10 April'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    softWrap: true,
                                    ),
                                    Text('Kharif:25 June to 10 July'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    softWrap: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Varieties Recommended for Haryana'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Single cut: HC 136, HC171, HC260, HC308'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),
                                    Text('Multicut: Sweet sudan grass 59-3; Dual purpose: HJ 513'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Fertilizer Requirement'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('FYM application @ 10 (rainfed) to 25 t/ha (irrigated) before sowing.Crop is fertilized with 80-40-0 (single cut), 120-60-0 (double cut) and 210-60-60 (multi cut)kg/ha of NPK, respectively.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                softWrap: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Weed management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('One hand weeding 15-20 DAS is necessary. For chemical weed control apply atrazine @ 500g/ha between 7-15 days after sowing using 625 L of water.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                softWrap: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Disease management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Downy mildew: seed treatment with Agrosan GN or Ceresan @ 4 g/ kg seed and spray of Dithane Z 78 (0.2%) to reduce secondary infection;'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),
                                    Text('Anthracnose: Seed treatment with Agrosan GN @ 3 g/kg seed followed by spray of Zineb (0.2%) at 10 days interval starting from 35 DAS.'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Insect Management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Sorghum shoot fly - Application of Carbaryl 10 G or Phorate 10 G @ 5.0 kg/ha is effective in borer management. Early sowing (1st week of June) may avoid shoot fly attack.'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),
                                    Text('Stem borer- Foliar spray of Carbaryl 50 WP in 500 litre water per hectare after 20 days of sowing and repeat spray 10 days after spray is effective in borer management.'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Harvesting'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('Single cut varieties are harvested at 50-100% flowering stage. In multi cut varieties,the first cut is taken 55 DAS and the subsequent at 40 days interval. In multi cut varieties, first cut should be taken 8-10 cm above ground level so as to facilitate profuse tillering.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hydrocyanic acid (HCN) or Dhurin'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('The crop at early stages contains HCN. Harvesting should not be done prior to 45 days from sowing. Silage or hay making removes the toxin. In summer, an irrigation before harvest may be effective. For hay making, pre-flowering is ideal stage for harvest. Do not turn hungry livestock out on lush regrowth of sorghum; do not graze until the regrowth is 18 to 24 inches tall.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            
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
                              'MAIZE'.tr,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/sorghum.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 20,
                            ),    
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Seed Rate and Sowing Method'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('40-50 kg seed/ha at 5 cm depth with 60 cm row to row spacing and 10 cm spacing between crops'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Varieties'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('African Tall, APFM-8, Pratap Makka, Chari 6,Ganga-4, J-1006.'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),     
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Manures and Fertilizers'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('15-30 kg Nitrogen (N), 40-60 kg Phosphorus (P), 40 kg Potassium (K) and 20 kg Zinc sulphate before planting and 60-90 kg N when the crop is 50-60 cm tall. 15 tons of FYM/hac applied a month before planting.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                softWrap: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Irrigation'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('1 or 2 irrigations at critical stages. Flowering and grain-filling stages are most critical; Irrigation every 15-20 days in the rainy season and every 10-12 days in the summer'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                softWrap: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Harvesting'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('For fodder purpose, the milk to early dough stage is preferred for higher yield and protein content. For silage, late dough stage is preferred.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),  
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
                              'OATS'.tr,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/sorghum.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 20,
                            ),    
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Seed Rate and Sowing Method'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('75 kg/ha seed for small seeded varieties, while for bold seeded varieties 100 kg/ha. It can be planted with kera or pora method depending upon the moisture availability. It is always better to sow the crop with seed cum fertilizer drill by maintaining row to row distance of 25 cm. The optimum sowing time is mid-October to mid-November.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Varieties Recommended for Haryana'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('Haryana Javi (HFO-114), OS-6, OS-7,Haryana Javi 8'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                ),
                                    
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Fertilizer Requirement'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('40 kg N/ha at sowing and 40 kg N/ha at first irrigation. For multicut varieties 40 kg N/ha should also be applied after each cut.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Irrigation management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('Irrigation should be applied at one month interval. Irrigation is essential after each cutting in order to promote the regeneration of the plants.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Weed Management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('application of a broadleaf herbicide, such as 2,4-D sodium salt @ 1 kg/ha spray in 500 liter water at 35 DAS.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Disease management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Covered smut: Seed treatment with Emissan @ 2.5g/kg seed'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),
                                    Text('Loose smut: Seed treatment with Vitavex or bavistin @ 2g/kg seed.'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),
                                    Text('Aphid: Spray of plain water @ 400 l/ha, Application of malathion or endosulfan @ 0.05% in the patches of aphid colony.'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),

                                  ],
                                ),
                              ],
                            ), 
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
                              'BARSEEM'.tr,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 366,
                              height: 218,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/barseem.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 20,
                            ),    
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Seed Rate and Sowing Method'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('End of September to end of October by broadcasting. Seed rate of 20 - 25 kg/ha is recommended. Mix 1 kg of Japani sarson/Chinese cabbage or 25 kg of oat seed for harvesting higher quantity of fodder at first cut.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Varieties Recommended for Haryana'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('Mescavi, Hisar Berseem 1 and Hisar Berseem 2'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),
                                 
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Fertilizer Management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('20 kg N + 70 kg P2O5 /ha before sowing of crop.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                softWrap: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Irrigation management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('The first irrigation applied after 3-5 DAS in light soils (heavy soils, 8-10 days). Later on irrigate at 15-20 days interval.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Disease management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('Stem rot: Avoid excessive irrigation. Spray 0.1% solution of Bavistine twice during January and February at 15-20 days interval. Select disease resistant variety HB 1.Root rot: Seed treatment with Thiram, Bavistine and Carbofuran @ 2.5g/kg.'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),   
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Insect Management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('Black ants: Apply Methyl Parathian 2% dust; White grass hopper: Spray malathion @1 lt/ha in 750 lts of water.'.tr, style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    ),     
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cutting Management'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                Text('Harvested in 55-60 DAS and subsequent cuts after every 30 – 40 days.'.tr, style: TextStyle(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('Toxicity'.tr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            Text('A substance known as ‘astrogenons‘ is present in berseem, the excess of which makes the animal sick and causes bloat disease. Fodder should be sprayed with linseed or mustard oil. Mixing of dry fodder which contains more fiber like wheat straw also reduces the problem of bloating.'.tr, style:TextStyle(
                                  fontSize: 14,
                                ),
                                ), 
                              ]
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
