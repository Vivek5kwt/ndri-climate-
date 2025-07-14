import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndri_climate/material/Reusabledescrip.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';

class Managemental extends StatefulWidget {
  const Managemental({super.key});

  @override
  State<Managemental> createState() => _ManagementalState();
}

class _ManagementalState extends State<Managemental> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Common text styles
  final TextStyle _tabTextStyle = TextStyle(
    fontSize: ResponsiveUtils.wp(3),
    fontWeight: FontWeight.bold,
  );
  final TextStyle _sectionTitleStyle = TextStyle(
    fontSize: ResponsiveUtils.wp(4),
    fontWeight: FontWeight.bold,
    color: const Color(0xFF1976D2),
  );
  final TextStyle _subtitleTextStyle = TextStyle(
    fontSize: ResponsiveUtils.wp(3),
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
            title: 'Management Practices'.tr,
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
                labelStyle:
                    _tabTextStyle.copyWith(color: const Color(0xFF1976D2)),
                unselectedLabelStyle:
                    _tabTextStyle.copyWith(color: Colors.grey.shade600),
                indicatorColor: const Color(0xFF1976D2),
                indicatorWeight: 3,
                dragStartBehavior: DragStartBehavior.start,
                tabs: [
                  Tab(
                    child: Text(
                      'Calf Management'.tr,
                      style: _tabTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Housing'.tr,
                      style: _tabTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Reproductive Management'.tr,
                      style: _tabTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Useful Tips'.tr,
                      style: _tabTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _calfTab(),
                  _housingTab(),
                  _reproductiveTab(),
                  _usefulTipsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calfTab() {
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
                'Calf Management'.tr,
                style: _sectionTitleStyle,
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Container(
                width: width,
                height: ResponsiveUtils.hp(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/calf.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              ...[
                'Shed should be provided to the claves with clean, dry and bedded area for rest. In calf shed maximum ventilation for hot weather should provide for at least one air change/minute. Provide fan and cooling facility during hotter part of the day.',
                'Provide good quality calf starter (must contain 75% TDN and 14-16 per cent digestible crude protein). Increase the frequency of feeding to fulfill the dietary requirement of the calf for proper growth of the calf under heat stress condition. Offer feed during cool hours of the day.',
                'Calves should be kept re-hydrated. Plenty fresh and cool water should be made available for calves. Calves should be taught for water drinking from first week of life.',
                'Vaccination, tagging and disbudding activities should be carried out in cool hours of the day.',
                'Colostrum quality should be checked during summer months so that calf should get optimum immunity through colostrum.',
                'The feeding equipments use for calf feeding should properly disinfected during summer months to avoid chance of infection.',
              ].map((desc) {
                return Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                  child: Reusabledescription(
                    desciption: desc,
                    textStyle: _subtitleTextStyle,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _housingTab() {
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
                'Housing'.tr,
                style: _sectionTitleStyle,
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Container(
                width: width,
                height: ResponsiveUtils.hp(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/management.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              ...[
                'Adequate space should be provided during the heat stress period to the dairy animals for effective heat dissipation, especially in tie stalls, which are commonly observed at farmers doorsteps and present-day small commercial dairy farms.',
                'Sheds must be provided, especially during the summer months, to reduce the heat load from radiation. The roof should be reflective. Roof painted with white paint and insulated with puff or straw and covered with seasonal vegetable plants like bottle gourd, pumpkin and ridge gourd grown from earth is quite effective in reducing the inside temperature of the shed.',
                'The fresh and cool drinking water facility under shaded areas should be ensured for effective heat stress management.',
                'Holding and milking areas must have adequate ventilation, air circulation, and cooling facilities as less attention has been given under Indian conditions.',
                'In hot-dry weather, misting is quite effective in cooling the environment, which further helps to cool the animals. Fogging is very effective but under closed conditions and when the temperature is high and humidity is low. In fogging, desalinated water is generally recommended; otherwise, nozzle blocking is a common problem.',
                'In hot-humid conditions, sprinkling for a limited period along with fanning is quite effective. In closed housing for such a cooling system, proper ventilation must be ensured to reduce the humidity buildup.',
                'Straw bedding (2 inch) or mattress or sand bedding are effective to improve the resting time of dairy animals.',
                'Animal Shed should be constructed east-west direction. Height of the shed at centre should be 14-15 ft and height at eve 12-13 feet commonly used. Researchers even used 16-18 ft height at centre and 14-15 ft at eve to maintain better micro environment inside the shed. Natural tree shed in the open paddock area and farm premises is quite effective to reduce the heat load.',
              ].map((desc) {
                return Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                  child: Reusabledescription(
                    desciption: desc,
                    textStyle: _subtitleTextStyle,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reproductiveTab() {
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
                'Reproductive Management'.tr,
                style: _sectionTitleStyle,
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Container(
                width: width,
                height: ResponsiveUtils.hp(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/reproductive.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              ...[
                'The incidence of anoestrus in buffalo ranges from 20 to 80% depending on season.Most buffalo cease ovarian cyclicity during hot summers probably due to the combined effects of nutrition, environment and management. In the heat stress period, four to five days of adequate cooling, especially around breeding, can enhance the fertility of dairy animals.',
                'Keeping buffalo cool by wallowing, water sprinklers or shade improves fertility.',
                'Buffalo supplemented with UMMBs for 60 days before calving will have betterpostpartum reproductive performance.',
                'Regular supplementation of UMMBs early after calving also enhances production (8% more milk) and oestrus expression within 50 days. UMMBs also induce fertile oestrus in non-pregnant anoestrous buffalo.',
                'Ameliorative strategies in the form of environmental enrichment and cooling mechanism depending on the weather condition, nutritional manipulation, stress-relieving supplements i.e., antioxidants, yeast, buffer, vitamins (Niacin, Vitamin C and Vitamin E) and minerals, electrolytes and hormonal treatment for reproductive management is quite effective.',
                'Nutrient-enriched feed in the form of good quality green fodder, concentrate, bypass fat, and protein should be supplemented to improve dairy animals reproduction performance during hot weather conditions.',
              ].map((desc) {
                return Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                  child: Reusabledescription(
                    desciption: desc,
                    textStyle: _subtitleTextStyle,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usefulTipsTab() {
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
                'Useful Tips'.tr,
                style: _sectionTitleStyle,
              ),
              SizedBox(height: ResponsiveUtils.hp(1.5)),
              ...[
                'Farmers can quickly identify the animal is in heat stress or not by simply monitoring respiration rate. If the respiration rate is more than 80 breaths per minute, heat stress is a clear indication.',
                'The more straightforward way to understand when heat stress started is that if humanbeing starts feeling the stress as for animals, it already started.',
                'Wallowing is very effective for buffaloes due to their black skin colour and fewer sweat glands. Natural ponds are very common in the village area and quite effective amelioration of heat through wallowing. Artificially build 50 ft. wide X 100 ft. long and 4 to 6 ft. depth wallowing pond is suitable for 100 animals.',
                'Optimum body condition score maintenance in different stages of physiological state and especially the animals are going to calve in heat stress period can be an effective strategy.',
                'Identification of genotype adapted to climatic stress and formulation of region-specific climate-resilient breeding strategies of livestock to select heat-tolerant livestock.',
                'Fly control measures should be taken effectively as during summer months the problems of fly increases.',
              ].map((desc) {
                return Padding(
                  padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                  child: Reusabledescription(
                    desciption: desc,
                    textStyle: _subtitleTextStyle,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
