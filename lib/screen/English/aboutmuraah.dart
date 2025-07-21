import 'package:flutter/material.dart';
import 'package:ndri_climate/material/custom_drawer.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/material/reusableappbar.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../material/asset_image_loader.dart';

class About_Murrah extends StatefulWidget {
  const About_Murrah({super.key});

  @override
  State<About_Murrah> createState() => _About_MurrahState();
}

class _About_MurrahState extends State<About_Murrah> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildRowElement(String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AssetImageLoader(
                assetPath: 'assets/icon/tick.webp',
                width: 18,
                height: 18,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10.w),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 28.w),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: ReuseAppbar(
          scaffoldKey: _scaffoldKey,
          show_back_arrow: false,
          title: 'Impact of climate change on dairy animal'.tr,
        ),
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        margin: EdgeInsets.all(10.w),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 1.sw - 30.w,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: AssetImage('assets/images/murrah.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              _buildRowElement(
                'Heat Stress'.tr,
                'Increased temperatures in India can cause severe heat stress in dairy animals. Studies show that heat stress can reduce milk production by 10-25% in cows and buffaloes during peak summer months.'
                    .tr,
              ),
              _buildRowElement(
                'Reproductive Health'.tr,
                'Heat stress impacts reproductive efficiency. Research indicates that conception rates in dairy cows can drop by up to 30% during heat waves. In buffaloes, silent heat and low conception rates during summer are serious problems in northern India. In males, the semen quality and libido also get affected by heat stress.'
                    .tr,
              ),
              _buildRowElement(
                'Milk Composition'.tr,
                'Heat stress can reduce the fat and protein content in milk. Studies have shown that in heat-stressed cows, the fat content of milk can drop by 0.2-0.5 percentage points.'
                    .tr,
              ),
              _buildRowElement(
                'Feed Quality and Quantity'.tr,
                'Climate change can lead to altered rainfall patterns and more frequent droughts, affecting the availability and quality of fodder. Poor fodder quality can lead to lower milk production and increased costs for dairy farmers.'
                    .tr,
              ),
              _buildRowElement(
                'Disease and Parasites'.tr,
                'Higher temperatures and humidity levels can lead to an increase in vector-borne diseases such as tick-borne diseases. The incidence of diseases like mastitis, Foot and Mouth Disease (FMD) can rise, affecting productivity.'
                    .tr,
              ),
              _buildRowElement(
                'Animal Welfare'.tr,
                'Increased temperatures and humidity negatively affect animal welfare, causing stress and discomfort. This can lead to increased mortality rates during extreme heat events.'
                    .tr,
              ),
              _buildRowElement(
                'Adaptation Costs'.tr,
                'Farmers may need to invest in cooling systems, improved housing, and changes in management practices. The cost of installing fans, sprinklers, and cooling pads can be substantial, often ranging from INR 20,000 to 50,000 per animal shed.'
                    .tr,
              ),
              _buildRowElement(
                'Biodiversity Loss'.tr,
                'Climate change impacts the biodiversity of pasturelands. Loss of plant species reduces the variety of feed available, impacting the nutritional intake of dairy animals.'
                    .tr,
              ),
              _buildRowElement(
                'Economic Impact on Farmers'.tr,
                'The cumulative effect of reduced milk production, increased costs for feed, water, and veterinary care, and potential loss of livestock due to extreme weather events can significantly affect the livelihood of dairy farmers.'
                    .tr,
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }
}
