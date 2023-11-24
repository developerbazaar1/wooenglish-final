import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/read_more/read_more.dart';

class CW {
  ///For Full Size Use In Column Not In ROW
  static Widget commonElevatedButton(
      {double? height,
      double? width,
      EdgeInsetsGeometry? buttonMargin,
      EdgeInsetsGeometry? contentPadding,
      double? borderRadius,
      Color? splashColor,
      bool wantContentSizeButton = true,
      Color? buttonColor,
      double? elevation,
      required VoidCallback onPressed,
      required Widget child}) {
    return Container(
      height: wantContentSizeButton ? height : 54.px,
      width: wantContentSizeButton ? width : double.infinity,
      margin: buttonMargin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? C.buttonRadius),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0.px,
          padding: contentPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? C.buttonRadius),
          ),
          backgroundColor: buttonColor ?? Col.primary,
          foregroundColor: splashColor ?? Colors.white12,
          shadowColor: Colors.transparent,
        ),
        child: child,
      ),
    );
  }

  static Widget commonRefreshIndicator(
      {required Widget child, required RefreshCallback onRefresh}) {
    return RefreshIndicator(onRefresh: onRefresh, child: child);
  }

  static Widget commonNoInternetImage({required RefreshCallback onRefresh}) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ScrollConfiguration(
          behavior: ListScrollBehaviour(),
          child: CustomScrollView(
            slivers: <Widget>[
              /*SliverToBoxAdapter(
                child: Container(color: Colors.red,),
              ),
              */
              SliverFillRemaining(
                hasScrollBody: true,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(C.imageNoInternetConnection),
                    commonTitleForError(title: C.textNoInternetTitle),
                    commonDisForError(dis: C.textNoInternetDis)
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget commonNoDataFoundImage({required RefreshCallback onRefresh}) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ScrollConfiguration(
          behavior: ListScrollBehaviour(),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: true,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(C.imageNoDataFound),
                    commonTitleForError(title: C.textNoDataTitle),
                    commonDisForError(dis: C.textNoDataDis)
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget commonSomethingWentWrongImage(
      {required RefreshCallback onRefresh}) {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ScrollConfiguration(
        behavior: ListScrollBehaviour(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: true,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(C.imageSomethingWentWrong),
                    commonTitleForError(title: C.textSomethingWentWrongTitle),
                    commonDisForError(dis: C.textSomethingWentWrongDis)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  static Widget commonTitleForError({required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.px),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(Get.context!)
            .textTheme
            .displayLarge
            ?.copyWith(color: Col.text, fontFamily: C.fontOpenSans),
      ),
    );
  }

  static Widget commonDisForError({required String dis}) {
    return Text(
      dis,
      textAlign: TextAlign.center,
      style: Theme.of(Get.context!)
          .textTheme
          .titleMedium
          ?.copyWith(color: Col.textGrayColor, fontFamily: C.fontOpenSans),
    );
  }

  static Widget commonElevatedButtonForLoginSignUp(
      {double? height,
      double? width,
      bool isClicked = false,
      EdgeInsetsGeometry? buttonMargin,
      EdgeInsetsGeometry? contentPadding,
      double? borderRadius,
      Color? splashColor,
      bool wantContentSizeButton = true,
      Color? buttonColor,
      double? elevation,
      required VoidCallback onPressed,
      required Widget child}) {
    return AnimatedContainer(
      height: isClicked ? 52.px : height,
      width: isClicked ? 52.px : width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            isClicked ? 30.px : borderRadius ?? C.buttonRadius),
        color: buttonColor,
      ),
      duration: const Duration(
        seconds: 2,
      ),
      child: isClicked
          ? SizedBox(
              height: height ?? 52.px,
              width: height ?? 52.px,
              child: Padding(
                padding: EdgeInsets.all(10.px),
                child: CircularProgressIndicator(
                  backgroundColor: const Color(0xff7C7C7C).withOpacity(.5),
                  strokeWidth: 3,
                ),
              ),
            )
          : Container(
              height: wantContentSizeButton ? height : 54.px,
              width: wantContentSizeButton ? width : double.infinity,
              margin: buttonMargin,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(borderRadius ?? C.buttonRadius),
              ),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  elevation: elevation ?? 0.px,
                  padding: contentPadding,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(borderRadius ?? C.buttonRadius),
                  ),
                  backgroundColor: buttonColor ?? Col.primary,
                  foregroundColor: splashColor ?? Colors.white12,
                  shadowColor: Colors.transparent,
                ),
                child: child,
              ),
            ),
    );
  }

  static Widget commonTextButton(
      {double? height,
      double? width,
      EdgeInsetsGeometry? buttonMargin,
      EdgeInsetsGeometry? contentPadding,
      double? borderRadius,
      bool wantContentSizeButton = true,
      double? elevation,
      required VoidCallback onPressed,
      required Widget child}) {
    return Container(
      height: height,
      width: wantContentSizeButton ? width : double.infinity,
      margin: buttonMargin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? C.textButtonRadius),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: elevation ?? 0.px,
          padding: contentPadding,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? C.textButtonRadius),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Col.primary,
          shadowColor: Colors.transparent,
        ),
        child: child,
      ),
    );
  }

  static Widget commonTextFieldForLoginSignUP({
    double? elevation,
    String? hintText,
    EdgeInsetsGeometry? contentPadding,
    TextEditingController? controller,
    int? maxLines,
    double? cursorHeight,
    Widget? prefixIcon,
    bool wantBorder = true,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    Color? fillColor,
    Color? initialBorderColor,
    double? initialBorderWidth,
    TextInputType? keyboardType,
    double? borderRadius,
    double? maxHeight,
    TextStyle? hintStyle,
    TextStyle? style,
    GestureTapCallback? onTap,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    bool readOnly = false,
  }) {
    return TextFormField(
      cursorHeight: cursorHeight,
      onTap: onTap,
      controller: controller,
      onChanged: onChanged ??
          (value) {
            value = value.trim();
            if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
              controller?.text = "";
            }
          },
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.streetAddress,
      readOnly: readOnly,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      style: style ??
          Theme.of(Get.context!)
              .textTheme
              .bodyMedium
              ?.copyWith(fontFamily: C.fontOpenSans, color: Col.onSecondary),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: fillColor ?? Col.inverseSecondary,
        filled: true,
        prefix: prefixIcon,
        contentPadding:
            contentPadding ?? EdgeInsets.symmetric(horizontal: 20.px),
        hintStyle: hintStyle ??
            Theme.of(Get.context!)
                .textTheme
                .bodyMedium
                ?.copyWith(fontFamily: C.fontOpenSans, color: Col.onSecondary),
        disabledBorder: OutlineInputBorder(
            borderSide: wantBorder
                ? BorderSide(color: Col.inverseSecondary, width: 2.px)
                : BorderSide.none,
            borderRadius:
                BorderRadius.circular(borderRadius ?? C.loginTextFieldRadius)),
        border: OutlineInputBorder(
            borderSide: wantBorder
                ? BorderSide(color: Col.primary, width: 2.px)
                : BorderSide.none,
            borderRadius:
                BorderRadius.circular(borderRadius ?? C.loginTextFieldRadius)),
        enabledBorder: OutlineInputBorder(
            borderSide: wantBorder
                ? BorderSide(
                    color: initialBorderColor ?? Col.inverseSecondary,
                    width: initialBorderWidth ?? 2.px)
                : BorderSide.none,
            borderRadius:
                BorderRadius.circular(borderRadius ?? C.loginTextFieldRadius)),
        errorBorder: OutlineInputBorder(
            borderSide: wantBorder
                ? BorderSide(color: Col.error, width: 2.px)
                : BorderSide.none,
            borderRadius:
                BorderRadius.circular(borderRadius ?? C.loginTextFieldRadius)),
      ),
    );
  }

  static Widget textFieldCountryCode(
          {double? borderRadius, required VoidCallback onTap,required String logo,required String code}) =>
      InkWell(
        borderRadius:
            BorderRadius.circular(borderRadius ?? C.loginTextFieldRadius),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.px),
          height: 49.px,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(borderRadius ?? C.loginTextFieldRadius),
            color: Col.inverseSecondary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30.px,
                child: Image.network(
                  logo,
                  height: 25.px,
                  width: 20.px,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 4.px,
              ),
              Text(
               code,
                style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                    fontFamily: C.fontOpenSans, color: Col.onSecondary),
              ),
            ],
          ),
        ),
      );

  static Widget commonTextFieldForWriteSomething({
    double? elevation,
    String? hintText,
    EdgeInsetsGeometry? contentPadding,
    TextEditingController? controller,
    int? maxLines,
    double? cursorHeight,
    bool wantBorder = true,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    Color? fillColor,
    TextInputType? keyboardType,
    double? borderRadius,
    double? maxHeight,
    TextStyle? hintStyle,
    TextStyle? style,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    bool readOnly = false,
  }) {
    return SizedBox(
      height: maxHeight,
      child: Card(
        elevation: elevation ?? 2.px,
        shape: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? C.loginTextFieldRadius),
            borderSide: BorderSide.none),
        child: TextFormField(
          cursorHeight: cursorHeight,
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          keyboardType: keyboardType ?? TextInputType.streetAddress,
          readOnly: readOnly,
          autofocus: autofocus,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          style: style ??
              Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                  fontFamily: C.fontOpenSans, color: Col.onSecondary),
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: fillColor ?? Col.inverseSecondary,
            hintStyle: hintStyle ??
                Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                    fontFamily: C.fontOpenSans, color: Col.onSecondary),
            disabledBorder: OutlineInputBorder(
                borderSide: wantBorder
                    ? BorderSide(color: Col.inverseSecondary, width: 2.px)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(
                    borderRadius ?? C.loginTextFieldRadius)),
            contentPadding:
                contentPadding ?? EdgeInsets.symmetric(horizontal: 20.px),
            enabledBorder: OutlineInputBorder(
                borderSide: wantBorder
                    ? BorderSide(color: Col.inverseSecondary, width: 2.px)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(
                    borderRadius ?? C.loginTextFieldRadius)),
            border: OutlineInputBorder(
                borderSide: wantBorder
                    ? BorderSide(color: Col.primary, width: 2.px)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(
                    borderRadius ?? C.loginTextFieldRadius)),
            errorBorder: OutlineInputBorder(
                borderSide: wantBorder
                    ? BorderSide(color: Col.error, width: 2.px)
                    : BorderSide.none,
                borderRadius: BorderRadius.circular(
                    borderRadius ?? C.loginTextFieldRadius)),
          ),
        ),
      ),
    );
  }

  static Widget commonDivider(
      {double? height, double? width, double? borderRadius, Color? color}) {
    return Container(
      height: height ?? 1.px,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 2.px),
          color: color ?? Col.secondary),
    );
  }

  static Widget commonAppBarWithoutActon(
      {VoidCallback? onPressed,
      required String title,
      VoidCallback? clickOnClearButton,
      bool wantClearButton = false,
      bool wantBackButton = true}) {
    return Column(
      children: [
        Container(
          height: CM.getAppBarSize(),
          margin: EdgeInsets.only(top: CM.getToolBarSize()),
          padding: EdgeInsets.symmetric(horizontal: C.margin / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              wantBackButton
                  ? IconButton(
                      onPressed: onPressed,
                      icon: Image.asset(
                        C.imageBackButton,
                        color: Col.secondary,
                        height: 20.px,
                        width: 24.px,
                      ),
                      splashRadius: C.iconButtonRadius,
                      padding: EdgeInsets.zero,
                    )
                  : const SizedBox(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.px),
                  child: Text(
                    title,
                    style: CT.alegreyaDisplaySmall(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              wantClearButton
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: C.margin / 2),
                      child: commonTextButton(
                        onPressed: clickOnClearButton!,
                        child: Text(
                          C.textClearAll,
                          style: CT.openSansTitleLarge(),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
        Divider(
          color: Col.borderColor,
          thickness: 2.px,
          height: 0.px,
        ),
      ],
    );
  }

  static Widget commonAppBarWithActon({
    VoidCallback? clickOnBackButton,
    VoidCallback? clickOnLikeButton,
    VoidCallback? clickOnBookMarkButton,
    VoidCallback? clickOnShareButton,
    VoidCallback? clickOnInfoButton,
    VoidCallback? clickOnZoomButton,
    VoidCallback? clickOnMenuButton,
    Widget? menuButton,
    bool wantLikeButton = true,
    bool wantTitle = false,
    String? title,
    bool wantSwitch=false,
    bool modeValue=false,
     ValueChanged<bool>? onChanged,
    bool wantBookMarkButton = false,
    bool wantShareButton = true,
    bool wantInfoButton = true,
    bool wantZoomButton = false,
    bool wantMenuButton = false,
    bool wantBackButton = true,
    bool wantSelectedLikeButton = false,
    bool wantSelectedBookMarkButton = false,
    bool wantDarkMode = false,
    Color? color,
  }) {
    return Column(
      children: [
        Container(
          height: CM.getAppBarSize(),
          margin: EdgeInsets.only(top: CM.getToolBarSize()),
          padding: EdgeInsets.symmetric(horizontal: C.margin / 2),
          color: wantDarkMode ? Col.darkAppBar : color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              wantBackButton
                  ? IconButton(
                      onPressed: clickOnBackButton,
                      icon: Image.asset(
                        C.imageBackButton,
                        color:
                            wantDarkMode ? Col.inverseSecondary : Col.secondary,
                        height: 20.px,
                        width: 24.px,
                      ),
                      splashRadius: C.iconButtonRadius,
                      padding: EdgeInsets.zero,
                    )
                  : const SizedBox(),
              wantTitle
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.px),
                        child: Text(
                          title!,
                          style: CT.alegreyaDisplaySmall(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if(wantSwitch)
                        commonSwitchView(
                          changeValue: modeValue,
                          onChanged: onChanged,
                        ),
                      if (wantZoomButton)
                        IconButton(
                          onPressed: clickOnZoomButton,
                          icon: Image.asset(
                            C.imageZoomLogo,
                            height: 25.px,
                            width: 25.px,
                            color: wantDarkMode
                                ? Col.inverseSecondary
                                : Col.secondary,
                          ),
                          splashRadius: C.iconButtonRadius,
                          padding: EdgeInsets.zero,
                        ),
                      if (wantLikeButton)
                        IconButton(
                          onPressed: clickOnLikeButton,
                          icon: wantSelectedLikeButton
                              ? Icon(
                                  Icons.favorite,
                                  color: Col.error,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: wantDarkMode
                                      ? Col.inverseSecondary
                                      : Col.secondary,
                                ),
                          splashRadius: C.iconButtonRadius,
                          padding: EdgeInsets.zero,
                        ),
                      if (wantBookMarkButton)
                        IconButton(
                          onPressed: clickOnBookMarkButton,
                          icon: wantSelectedBookMarkButton
                              ? Icon(
                                  Icons.bookmark_outlined,
                                  color: wantDarkMode
                                      ? Col.inverseSecondary
                                      : Col.secondary,
                                )
                              : Icon(
                                  Icons.bookmark_outline_rounded,
                                  color: wantDarkMode
                                      ? Col.inverseSecondary
                                      : Col.secondary,
                                ),
                          splashRadius: C.iconButtonRadius,
                          padding: EdgeInsets.zero,
                        ),
                      if (wantShareButton)
                        IconButton(
                          onPressed: clickOnShareButton,
                          icon: Icon(
                            Icons.share,
                            color: wantDarkMode
                                ? Col.inverseSecondary
                                : Col.secondary,
                          ),
                          splashRadius: C.iconButtonRadius,
                          padding: EdgeInsets.zero,
                        ),
                      if (wantMenuButton) menuButton!,
                      if (wantInfoButton)
                        IconButton(
                          onPressed: clickOnInfoButton,
                          icon: Image.asset(
                            C.imageInfoLogo,
                            height: 30.px,
                            width: 30.px,
                            color: wantDarkMode
                                ? Col.inverseSecondary
                                : Col.secondary,
                          ),
                          splashRadius: C.iconButtonRadius,
                          padding: EdgeInsets.zero,
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!wantDarkMode)
          Divider(
            color: Col.borderColor,
            thickness: 2.px,
            height: 0.px,
          ),
      ],
    );
  }


 static Widget commonSwitchView(
      {required bool changeValue,
        required ValueChanged<bool>? onChanged}) =>
      cupertino.CupertinoSwitch(
        value: changeValue,
        onChanged: onChanged,
        activeColor: Col.borderColor,
        thumbColor: changeValue ? Col.secondary : Col.inverseSecondary,
        trackColor: Col.textGrayColor,
      );

  static Widget commonTextFieldForSearch(
      {double? elevation,
      String? hintText,
      EdgeInsetsGeometry? contentPadding,
      TextEditingController? controller,
      int? maxLines = 1,
      ValueChanged<String>? onChanged,
      FormFieldValidator<String>? validator,
      Color? fillColor,
      TextInputType? keyboardType,
      double? borderRadius,
      List<TextInputFormatter>? inputFormatters,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool autofocus = false,
      ValueChanged<String>? onFieldSubmitted,
      bool readOnly = false,
        bool wantFilterIcon=true,
      TextInputAction? textInputAction,
       VoidCallback? clickOnSearchIcon,
       VoidCallback? clickOnFilterIcon}) {
    return Card(
      elevation: elevation ?? 2.px,
      color: fillColor,
      shape: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(borderRadius ?? C.loginTextFieldRadius),
          borderSide: BorderSide.none),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
        readOnly: readOnly,
        autofocus: autofocus,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        style: CT.alegreyaBodySmall(),
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: fillColor ?? Col.inverseSecondary,
          prefixIcon: IconButton(
            onPressed: clickOnSearchIcon,
            icon: Image.asset(
              C.imageSearchPageLogo,
              height: 30.px,
              width: 30.px,
            ),
          ),
          suffixIcon: wantFilterIcon?IconButton(
            onPressed: clickOnFilterIcon,
            icon: Image.asset(
              C.imageFilterLogo,
              height: 12.px,
              width: 20.px,
            ),
            splashRadius: C.iconButtonRadius,
          ):null,
          hintStyle: CT.alegreyaBodySmall(),
          contentPadding:
              contentPadding ?? EdgeInsets.symmetric(horizontal: 20.px),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                  borderRadius ?? C.loginTextFieldRadius)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  borderRadius ?? C.loginTextFieldRadius)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  borderRadius ?? C.loginTextFieldRadius)),
        ),
      ),
    );
  }

  static Widget commonReadMoreText({
    required String value,
    int? maxLine,
  }) {
    final v = value.obs;
    return Obx(() {
      return ReadMoreText(
        v.value,
        style: CT.openSansTitleSmall(),
        moreStyle: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(color: Col.darkBlue, fontFamily: C.fontOpenSans),
        lessStyle: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(color: Col.darkBlue, fontFamily: C.fontOpenSans),
        trimLines: maxLine ?? 3,
        trimLength: 7,
        trimCollapsedText: C.textReadMore,
        callback: (val) {
          if (val) {
          } else {
            v.value = v.value.replaceAll("Read More", "");
          }
        },
        trimExpandedText: "  ${C.textReadLess}",
        trimMode: TrimMode.Line,
      );
    });
  }

  static Widget commonRattingView(
          {required double rating,
          double? size,
          EdgeInsets itemPadding = EdgeInsets.zero}) =>
      RatingBarIndicator(
        rating: rating,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Col.primary,
        ),
        itemPadding: itemPadding,
        itemCount: 5,
        itemSize: size ?? 16.px,
        direction: Axis.horizontal,
      );

  static Widget commonLinearProgressBar({required double value}) => ClipRRect(
        borderRadius: BorderRadius.circular(20.px),
        child: LinearProgressIndicator(
          color: Col.primary,
          backgroundColor: Col.primaryColor,
          value: value,
          minHeight: 10.px,
        ),
      );

  static commonProgressBarView() => CircularProgressIndicator(
        backgroundColor: const Color(0xff7C7C7C).withOpacity(.5),
        strokeWidth: 3,
      );

  static Widget commonShimmerViewForImage(
      {double? width, double? height, double? radius}) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1200),
      baseColor: Col.secondary,
      highlightColor: Col.textGrayColor,
      enabled: true,
      child: Container(
        width: width ?? 150.px,
        height: height ?? 150.px,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(radius ?? 6.px),
        ),
      ),
    );
  }

  static Widget commonPaddingForBookContent({required Widget child}) {

    return Padding(padding: EdgeInsets.only(left: 3.px,right: 20.px),child: child,);
  }
}
