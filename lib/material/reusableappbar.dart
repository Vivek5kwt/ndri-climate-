import 'package:flutter/material.dart';

class ReuseAppbar extends StatelessWidget {
  final String title;
  
   ReuseAppbar({
    super.key, 
      required this.title,

     });

  @override
  Widget build(BuildContext context) {
    final bgcolor = Color(0xFF2C96D2);
    return AppBar(
      backgroundColor:bgcolor,
      title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          child: Row(
            children: [
              InkWell(
                child: Icon(
                Icons.menu,
                color:Colors.white,
                size: 20,
                ),
                onTap: () {
                },
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

 