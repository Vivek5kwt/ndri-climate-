import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/material/app_styles.dart';

class Fodder extends StatefulWidget {
  const Fodder({super.key});

  @override
  State<Fodder> createState() => _FodderState();
}

class _FodderState extends State<Fodder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Common text styles
  final TextStyle _tabTextStyle = AppStyles.tabTextStyle;
  final TextStyle _sectionTitleStyle = AppStyles.sectionTitleStyle;
  final TextStyle _subtitleTextStyle = AppStyles.subtitleTextStyle;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ResponsiveUtils.hp(7)),
          child: ReuseAppbar(
            scaffoldKey: _scaffoldKey,
            title: 'Fodder Management'.tr,
            show_back_arrow: false,
          ),
        ),
        body: Column(
          children: [
            Container(
              width: screenW,
              color: const Color(0xFFC8EBFF),
              child: TabBar(
                isScrollable: true,
                labelStyle:
                    _tabTextStyle.copyWith(color: const Color(0xFF1976D2)),
                unselectedLabelStyle:
                    _tabTextStyle.copyWith(color: Colors.grey.shade600),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.blue,
                dragStartBehavior: DragStartBehavior.start,
                tabs: [
                  Tab(
                    child: Text(
                      'Sorghum'.tr,
                      style: _tabTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Maize'.tr,
                      style: _tabTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Oats'.tr,
                      style: _tabTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Berseem'.tr,
                      style: _tabTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildFodderTab(
                    context,
                    title: 'SORGHUM'.tr,
                    image: 'assets/images/sorghum.webp',
                    infoWidgets: [
                      _infoBlock('Seed Rate and Sowing Method'.tr,
                          'The crop is sown in rows of 30cm (single cut) to 45 cm (multi cut) apart with a plant to plant spacing of 15 cm. For sorghum 50-60 kg/ha seed is sufficient,sown at a depth of 2-5 cm.'),
                      _infoBlock('Sowing Time'.tr,
                          'Summer: 20 March to 10 April\nKharif: 25 June to 10 July'),
                      _infoBlock('Varieties Recommended for Haryana'.tr,
                          'Single cut: HC 136, HC171, HC260, HC308\nMulticut: Sweet sudan grass 59-3; Dual purpose: HJ 513'),
                      _infoBlock('Fertilizer Requirement'.tr,
                          'FYM application @ 10 (rainfed) to 25 t/ha (irrigated) before sowing.Crop is fertilized with 80-40-0 (single cut), 120-60-0 (double cut) and 210-60-60 (multi cut)kg/ha of NPK, respectively.'),
                      _infoBlock('Weed management'.tr,
                          'One hand weeding 15-20 DAS is necessary. For chemical weed control apply atrazine @ 500g/ha between 7-15 days after sowing using 625 L of water.'),
                      _infoBlock('Disease management'.tr,
                          'Downy mildew: seed treatment with Agrosan GN or Ceresan @ 4 g/ kg seed and spray of Dithane Z 78 (0.2%) to reduce secondary infection.\nAnthracnose: Seed treatment with Agrosan GN @ 3 g/kg seed followed by spray of Zineb (0.2%) at 10 days interval starting from 35 DAS.'),
                      _infoBlock('Insect Management'.tr,
                          'Sorghum shoot fly - Application of Carbaryl 10 G or Phorate 10 G @ 5.0 kg/ha is effective in borer management. Early sowing (1st week of June) may avoid shoot fly attack.\nStem borer- Foliar spray of Carbaryl 50 WP in 500 litre water per hectare after 20 days of sowing and repeat spray 10 days after spray is effective in borer management.'),
                      _infoBlock('Harvesting'.tr,
                          'Single cut varieties are harvested at 50-100% flowering stage. In multi cut varieties,the first cut is taken 55 DAS and the subsequent at 40 days interval. In multi cut varieties, first cut should be taken 8-10 cm above ground level so as to facilitate profuse tillering.'),
                      _infoBlock('Hydrocyanic acid (HCN) or Dhurin'.tr,
                          'The crop at early stages contains HCN. Harvesting should not be done prior to 45 days from sowing. Silage or hay making removes the toxin. In summer, an irrigation before harvest may be effective. For hay making, pre-flowering is ideal stage for harvest. Do not turn hungry livestock out on lush regrowth of sorghum; do not graze until the regrowth is 18 to 24 inches tall.'),
                    ],
                  ),
                  _buildFodderTab(
                    context,
                    title: 'MAIZE'.tr,
                    image: 'assets/images/sorghum.webp',
                    infoWidgets: [
                      _infoBlock('Seed Rate and Sowing Method'.tr,
                          '40-50 kg seed/ha at 5 cm depth with 60 cm row to row spacing and 10 cm spacing between crops'),
                      _infoBlock('Varieties'.tr,
                          'African Tall, APFM-8, Pratap Makka, Chari 6,Ganga-4, J-1006.'),
                      _infoBlock('Manures and Fertilizers'.tr,
                          '15-30 kg Nitrogen (N), 40-60 kg Phosphorus (P), 40 kg Potassium (K) and 20 kg Zinc sulphate before planting and 60-90 kg N when the crop is 50-60 cm tall. 15 tons of FYM/hac applied a month before planting.'),
                      _infoBlock('Irrigation'.tr,
                          '1 or 2 irrigations at critical stages. Flowering and grain-filling stages are most critical; Irrigation every 15-20 days in the rainy season and every 10-12 days in the summer'),
                      _infoBlock('Harvesting'.tr,
                          'For fodder purpose, the milk to early dough stage is preferred for higher yield and protein content. For silage, late dough stage is preferred.'),
                    ],
                  ),
                  _buildFodderTab(
                    context,
                    title: 'OATS'.tr,
                    image: 'assets/images/sorghum.webp',
                    infoWidgets: [
                      _infoBlock('Seed Rate and Sowing Method'.tr,
                          '75 kg/ha seed for small seeded varieties, while for bold seeded varieties 100 kg/ha. It can be planted with kera or pora method depending upon the moisture availability. It is always better to sow the crop with seed cum fertilizer drill by maintaining row to row distance of 25 cm. The optimum sowing time is mid-October to mid-November.'),
                      _infoBlock('Varieties Recommended for Haryana'.tr,
                          'Haryana Javi (HFO-114), OS-6, OS-7,Haryana Javi 8'),
                      _infoBlock('Fertilizer Requirement'.tr,
                          '40 kg N/ha at sowing and 40 kg N/ha at first irrigation. For multicut varieties 40 kg N/ha should also be applied after each cut.'),
                      _infoBlock('Irrigation management'.tr,
                          'Irrigation should be applied at one month interval. Irrigation is essential after each cutting in order to promote the regeneration of the plants.'),
                      _infoBlock('Weed Management'.tr,
                          'Application of a broadleaf herbicide, such as 2,4-D sodium salt @ 1 kg/ha spray in 500 liter water at 35 DAS.'),
                      _infoBlock('Disease management'.tr,
                          'Covered smut: Seed treatment with Emissan @ 2.5g/kg seed\nLoose smut: Seed treatment with Vitavex or bavistin @ 2g/kg seed.\nAphid: Spray of plain water @ 400 l/ha, Application of malathion or endosulfan @ 0.05% in the patches of aphid colony.'),
                    ],
                  ),
                  _buildFodderTab(
                    context,
                    title: 'BARSEEM'.tr,
                    image: 'assets/images/barseem.webp',
                    infoWidgets: [
                      _infoBlock('Seed Rate and Sowing Method'.tr,
                          'End of September to end of October by broadcasting. Seed rate of 20 - 25 kg/ha is recommended. Mix 1 kg of Japani sarson/Chinese cabbage or 25 kg of oat seed for harvesting higher quantity of fodder at first cut.'),
                      _infoBlock('Varieties Recommended for Haryana'.tr,
                          'Mescavi, Hisar Berseem 1 and Hisar Berseem 2'),
                      _infoBlock('Fertilizer Management'.tr,
                          '20 kg N + 70 kg P2O5 /ha before sowing of crop.'),
                      _infoBlock('Irrigation management'.tr,
                          'The first irrigation applied after 3-5 DAS in light soils (heavy soils, 8-10 days). Later on irrigate at 15-20 days interval.'),
                      _infoBlock('Disease management'.tr,
                          'Stem rot: Avoid excessive irrigation. Spray 0.1% solution of Bavistine twice during January and February at 15-20 days interval. Select disease resistant variety HB 1.Root rot: Seed treatment with Thiram, Bavistine and Carbofuran @ 2.5g/kg.'),
                      _infoBlock('Insect Management'.tr,
                          'Black ants: Apply Methyl Parathian 2% dust; White grass hopper: Spray malathion @1 lt/ha in 750 lts of water.'),
                      _infoBlock('Cutting Management'.tr,
                          'Harvested in 55-60 DAS and subsequent cuts after every 30 – 40 days.'),
                      _infoBlock('Toxicity'.tr,
                          'A substance known as ‘astrogenons‘ is present in berseem, the excess of which makes the animal sick and causes bloat disease. Fodder should be sprayed with linseed or mustard oil. Mixing of dry fodder which contains more fiber like wheat straw also reduces the problem of bloating.'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFodderTab(BuildContext context, {required String title, required String image, required List<Widget> infoWidgets}) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(ResponsiveUtils.wp(3)),
        padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: _sectionTitleStyle,
            ),
            SizedBox(height: ResponsiveUtils.hp(2)),
            Container(
              width: double.infinity,
              height: ResponsiveUtils.hp(28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(2)),
            ...infoWidgets,
          ],
        ),
      ),
    );
  }

  Widget _infoBlock(String heading, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style:
                _subtitleTextStyle.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            content.tr,
            style: _subtitleTextStyle,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
