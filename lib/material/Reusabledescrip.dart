import 'package:flutter/material.dart';

class Reusabledescription extends StatelessWidget {
  final String desciption;
  const Reusabledescription({super.key, required this.desciption});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(top:40),
            width: 14,
            height: 20,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('assets/icon/tick.png'))),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.25,
            child: Text(
              desciption,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
