

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/colors/colors.dart';
class ShowPopup  {

  Future<bool> shouldShowPopup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasShownPopup = prefs.getBool('hasShownPopup') ?? false;

    if (!hasShownPopup) {
      // Set the flag to true so the popup won't be shown again
      await prefs.setBool('hasShownPopup', true);
      return true;
    }

    return false;
  }
  Widget alertDialog (double height,double width, Widget content,function,Alignment alignment,EdgeInsets margin){
    print("alert box called");
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle)

    return Container(
      margin:margin ,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 1,
        dashPattern: [10, 7],
        color: Col.primary,
        radius: Radius.circular(5 ),
        padding: EdgeInsets.all(6),
        child:

        AlertDialog(

          alignment: alignment,
          shape: RoundedRectangleBorder(),
          contentPadding: EdgeInsets.zero,
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          content: Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 10,left: 5,right: 0),
            height: height,
            width: width,
            child: Column(
              children: [
                content,
                // widgetRow( Icon(Icons.search,size: 20,weight: 2), 'Tap to go to the search page.'),
                // SizedBox(height: 8,),
                // widgetRow( Icon(Icons.heart_broken_outlined,size: 20,), 'Access your personal book collection'),
                // SizedBox(height: 8,),
                // widgetRow( Icon(Icons.person_outline_outlined,size: 20,), ''
                //     'Manage your profile settings.'),
                Center(
                  child: TextButton(
                    style:TextButton.styleFrom(
                      padding: EdgeInsets.zero,

                    ),

                    onPressed: () {
                      // controller.firstPopUp.value++;
                    },
                    child: Text('Got It'),
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
    return SizedBox();
  }
  Row widgetRow(Widget icon, String text) {
    return Row(
      children: [
        icon,
        SizedBox(width: 10,),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Open Sans",
              fontSize: 14,

              fontWeight:FontWeight.w400,


            ),
          ),
        )
      ],
    );
  }
}
