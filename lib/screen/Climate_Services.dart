import 'package:flutter/material.dart';
import 'package:ndri_climate/material/reusableappbar.dart';

class Climate_services extends StatefulWidget {
  const Climate_services({super.key});

  @override
  State<Climate_services> createState() => _Climate_servicesState();
}

class _Climate_servicesState extends State<Climate_services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(40, 60),child: ReuseAppbar(title: 'Climate Services For Murrah Buffalo',)),
      body: Container(
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              width:MediaQuery.of(context).size.width ,
              height: 61,
              padding: EdgeInsets.all(20),
              color: Color(0xFF9BDBFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month,
                        color: Color(0xFF1B3A69),
                        size: 21,
                        ),
                        SizedBox(width: 5,),
                        Text('22 Jun, 2022 - 28 Jun, 2022',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1B3A69),
                          fontWeight: FontWeight.w700,
                        ),)
                      ],),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.location_pin,
                        color: Color(0xFF1B3A69),
                        size: 21,
                        ),
                        Text('Jind',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1B3A69),
                          fontWeight: FontWeight.w700,
                        ),)
                      ],),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('WEATHER SUMMARY',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Text('In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.',
                        style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.w500),)
                      ],
                    )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ADVISORY SERVICES',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Text('In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.',
                        style: TextStyle(fontSize: 13,
                        fontWeight: FontWeight.w500),)
                      ],
                    )
              ),
          ],
        ),
      ),
    );
  }
}