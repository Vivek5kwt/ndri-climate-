import 'package:flutter/material.dart';

class Appbarwithtabs extends StatelessWidget {
  final String title;
  final List <Widget>Tabs;
  TabBar get _tabBar => TabBar(
      tabs: Tabs,
      indicatorColor: Color(0xFF2C96D2),
      unselectedLabelColor: Colors.black,
      labelColor: Color(0xFF2C96D2),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),


    );
  
   Appbarwithtabs({
    super.key, 
      required this.title, required this.Tabs,

     });

  @override
  Widget build(BuildContext context) {
    final bgcolor = Color(0xFF2C96D2);
    return AppBar(

      bottom: PreferredSize(
        preferredSize: _tabBar.preferredSize,
        child: Material(
          color: Color(0xFFC8EBFF), 
          textStyle: TextStyle(
            color: Color(0xFF2C96D2),
          ),//<-- SEE HERE
          child: _tabBar,
        ),
      ),
      backgroundColor:bgcolor,
      title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          child: Row(
            children: [
              Icon(
              Icons.menu,
              color:Colors.white,
              size: 20,
              ),
              SizedBox(width: 20,),
              Text(
               title,
                style: TextStyle(
                 fontSize: 15,
                 fontWeight: FontWeight.w700,
                 color: Colors.white
          ),
        ),
            ],
          ),
        ),
        
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/icon/translate.png'),
            fit: BoxFit.cover)
          ),
        )
        
      ],)
      );
  }
}