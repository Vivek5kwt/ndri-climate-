import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Plugin{
static dialogpopup(
      {required BuildContext context,
      required String dialog,
      String? text,
      Function()? onPressed,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Notification'.tr),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 5,),
              CircleAvatar(radius: 25,backgroundColor: Colors.greenAccent,
              child: Icon(Icons.check,size: 18,color: Colors.white,),),
              SizedBox(height: 15,),
              Text(dialog.tr),
            ],
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: onPressed,
              child: Text(
                'OK'.tr,
                style: TextStyle(color: Color(0xFF2C96D2)),
              ),
            ),
          ],
        );
      },
    );
  }
}