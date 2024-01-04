import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/app/validator/validator.dart';

import '../../Showpopup/showpopup.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    ShowPopup showPopup = ShowPopup();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      print("pop up called");
      _showBottomSheet(context);
      showPopup.shouldShowPopup().then((value) {
        print(value);
      });
      FutureBuilder(
        future: showPopup.shouldShowPopup(),
          builder: (context, snapshot) {
            print("pop  called");
      return _showBottomSheet(context);

          }

      );

    });
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.absorbing.value,
        child: GestureDetector(
          onTap: () => CM.unFocsKeyBoard(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Form(
              key: controller.formKey,
              autovalidateMode: C.autoValidateMode,
              child: ScrollConfiguration(
                behavior: ListScrollBehaviour(),
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: C.margin,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: C.wooEnglishAppLogoMargin,
                                ),
                                imageViewWooEnglishApp(),
                                SizedBox(
                                  height: 30.px,
                                ),
                                Column(
                                  children: [
                                    textViewHello(),
                                    textViewWellCome(),
                                    SizedBox(
                                      height: 15.px,
                                    ),
                                    Row(
                                      children: [
                                        textViewMobileNumber(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.px,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 5,
                                            child: textFieldCountryCode()),
                                        SizedBox(
                                          width: 10.px,
                                        ),
                                        Expanded(
                                            flex: 13,
                                            child: textFieldViewMobileNumber()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.px,
                                    ),
                                    buttonViewGetOtp(),
                                    SizedBox(
                                      height: 30.px,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Divider(
                                          color: Col.onSecondary,
                                          thickness: 2.px,
                                          endIndent: 10.px,
                                        )),
                                        textViewContinueWith(),
                                        Expanded(
                                            child: Divider(
                                          color: Col.onSecondary,
                                          thickness: 2.px,
                                          indent: 10.px,
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.px,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        /* SizedBox(
                                          height: 30.px,
                                          width: 30.px,
                                          child: floatingButtonViewFacebook(),
                                        ),
                                        SizedBox(
                                          width: 30.px,
                                        ),*/
                                        SizedBox(
                                          height: 30.px,
                                          width: 30.px,
                                          child: floatingButtonViewGoogle(),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.px,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textViewDontHaveAccount(),
                                        buttonViewSignUp()
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: C.margin,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageViewWooEnglishApp() => Image.asset(
        C.imageWooEnglishAppLogo,
        height: 150.px,
        width: 150.px,
      );

  Widget textViewHello() => Text(
        C.textHelloAgain,
        style: Theme.of(Get.context!)
            .textTheme
            .headlineSmall
            ?.copyWith(fontFamily: C.fontPlayfairDisplay, fontSize: 32.px),
      );

  Widget textViewWellCome() => Text(
        C.textWelcomeBack,
        style: Theme.of(Get.context!)
            .textTheme
            .headlineSmall
            ?.copyWith(fontFamily: C.fontPlayfairDisplay, fontSize: 32.px),
      );

  Widget textViewMobileNumber() => Text(
        C.textMobileNumber,
        style: CT.playfairHeadLineMedium(),
      );

  Widget textFieldViewMobileNumber() => CW.commonTextFieldForLoginSignUP(
        controller: controller.mobileNumberController,
        hintText: C.textEnterNumber,
        keyboardType: TextInputType.number,
        validator: (value) => Validator.isValid(value: value, title: "Number"),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxHeight: 52.px,
        onChanged: (value) {},
      );

  Widget textFieldCountryCode() => CW.textFieldCountryCode(
        onTap: () => controller.clickOnCountryCode(),
        code: controller.countryCodeController.text,
        logo: controller.countyLogo.value,
      );

  Widget buttonViewGetOtp() => CW.commonElevatedButtonForLoginSignUp(
      onPressed: () => controller.isOtpButtonClicked.value
          ? null
          : controller.clickOnGetOtpButton(),
      child: textViewGetOtp(),
      isClicked: controller.isOtpButtonClicked.value,
      wantContentSizeButton: false,
      buttonColor: Col.darkGreen);

  Widget textViewGetOtp() =>
      Text(C.textGetOtp, style: CT.openSansDisplayLarge());

  Widget textViewContinueWith() => Text(
        C.textContinueWith,
        style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(
            color: Col.onSecondary, fontSize: 18.px, fontFamily: C.fontLato),
      );

  Widget floatingButtonViewFacebook() => FloatingActionButton(
        onPressed: () => controller.clickOnFacebookButton(),
        heroTag: null,
        backgroundColor: Col.blue,
        child: imageViewFacebookLogo(),
      );

  Widget imageViewFacebookLogo() => Image.asset(
        C.imageFacebookLogo,
        height: 15.px,
        width: 9.px,
      );

  Widget floatingButtonViewGoogle() => FloatingActionButton(
        onPressed: () => controller.clickOnGoogleButton(),
        heroTag: null,
        backgroundColor: Col.onError,
        child: imageViewGoogleLogo(),
      );

  Widget imageViewGoogleLogo() => Image.asset(
        C.imageGoogleLogo,
        height: 10.px,
        width: 16.px,
      );

  Widget textViewDontHaveAccount() => Text(C.textDontHaveAccount,
      style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
          fontFamily: C.fontOpenSans,
          fontSize: 12.px,
          color: Col.secondaryContainer));

  Widget buttonViewSignUp() => CW.commonTextButton(
      onPressed: () => controller.clickOnSignUpButton(),
      contentPadding: EdgeInsets.zero,
      child: textViewSignUp());

  Widget textViewSignUp() => Text(
        C.textSignUp,
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(fontFamily: C.fontOpenSans, color: Col.darkGreen),
      );

   _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16.0),
          child: Stack(
           // mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              SingleChildScrollView(
                child: Column(
                  children: [
                    Text("ACCEPT COOKIES",style: TextStyle(color: Col.primary,fontSize: 20,fontFamily: 'Helvetica'),),
                    SizedBox(height: 10,),
                    Text(
                      "On May 16, 2023, we announced that we will require partners using our publisher products — Google AdSense, Ad Manager, or AdMob — to use a certified CMP that integrates with IAB Europe’s Transparency and Consent Framework (TCF) when serving ads to users in the European Economic Area (EEA) or the UK. You can view a list of certified CMPs in our help center (Ad Manager, AdMob, AdSense)."
                      "\n \n In July, as a follow up, we announced that we will begin to apply this requirement on January 16, 2024. This email serves as a reminder of that approaching deadline."
                      "\n \n Enforcement will begin January 16 on a small percentage of EEA and UK traffic, and will ramp up until we enforce across all EEA and UK traffic by end of February 2024. To ensure your monetization is not impacted, please have a certified CMP in place by January 16, 2024."
                      "\n \n Once enforcement begins, if you send Google an ad request for EEA or UK traffic, and it does not use a TCF-certified CMP (Ad Manager, AdMob, AdSense), personalized and non-personalized ads will no longer be eligible to serve. Instead, only Limited ads will be eligible to serve on Ad Manager and AdMob, and no ads will serve on AdSense. As a reminder, Limited ads are significantly more restrictive than non-personalized ads. As such, relying solely on Limited ads will likely decrease your EEA and UK revenue."
                      "\n \n We will continue to support your transition as you prepare for the new requirements. Please review our help center for further details (Ad Manager, AdMob, AdSense), including the full list of Google-certified CMPs.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.0,fontFamily: 'Helvetica'),

                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Align(
                alignment:Alignment.bottomCenter ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,



                      ),


                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Text('Reject Cookies',style: TextStyle(
                        color: Col.darkGreen
                      ),),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Col.darkGreen,



                      ),


                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Text('Accept Cookies',style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
