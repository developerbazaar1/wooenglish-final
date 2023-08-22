import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/text_style/text_style.dart';

class AppThemeData {
  static ThemeData themeDataLight({
    String? fontFamily,
  }) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Col.scaffoldBackgroundColor,
        elevation: 1,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: MaterialStateProperty.all(true),
        radius: Radius.circular(30.px),
        thumbColor: MaterialStateProperty.all(Col.primary),
        thickness: MaterialStateProperty.all(8.px),
        trackColor: MaterialStateProperty.all(Col.primaryColor),
        trackVisibility:MaterialStateProperty.all(true) ,
        minThumbLength: 100.px,

      ),
      sliderTheme: SliderThemeData(
        trackHeight: 8.px,
        activeTrackColor: Col.primary,
        inactiveTickMarkColor: Col.primaryColor,
        inactiveTrackColor: Col.primaryColor,
      ),
      textTheme: MyTextThemeLight().lightModeTextTheme(fontFamily: fontFamily),
      primaryColor: Col.primaryColor,
      scaffoldBackgroundColor: Col.scaffoldBackgroundColor,
      colorScheme: ColorScheme(
        primary: Col.primary,
        onPrimary: Col.primary,
        secondary: Col.secondary,
        onSecondary: Col.onSecondary,
        error: Col.error,
        brightness: Brightness.light,
        onError: Col.error,
        background: Col.scaffoldBackgroundColor,
        onBackground: Col.backgroundFillColor,
        surface: Col.surface,
        onSurface: Col.onSurface,
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: Col.primary),

      /*inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(top: 1),
        constraints: BoxConstraints(maxHeight: 70.px),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColorsLight().onPrimary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColorsLight().primary),
        ),
        */ /*errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyColors().error),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: MyColors().error),
          ),*/ /*
        //hintStyle: MyTextThemeStyle.bodyText2(MyColors().caption),
      ),

      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.px),
              ),
              padding: EdgeInsets.zero,
              foregroundColor: Col.primary)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.px),
            ),
            foregroundColor: Col.text,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.all(3.5.px),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),*/
    );
  }
}
