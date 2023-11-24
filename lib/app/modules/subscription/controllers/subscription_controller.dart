import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:http/http.dart'as http;

class SubscriptionController extends AppController {

  final count = 0.obs;
  final inAsyncCall=false.obs;
  final currentIndexOfIncludePlan = [-1,-1,-1,-1].obs;
  final currentIndexOfPlan=Rxn<int>();
  Map paymentIntent = Map();



  @override
  void onInit() {
    super.onInit();
    currentIndexOfPlan.value=-1;
    onReload();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onReload(){
    connectivity.onConnectivityChanged.listen((event) async {
      if(await CM.internetConnectionCheckerMethod())
      {
        onInit();
      }
      else
      {

      }
    });
  }


  void increment() => count.value++;

  void clickOnBackButton() {
    inAsyncCall.value=true;
    Get.back();
    inAsyncCall.value=false;
  }


  // Stripe payment details____________
  Future<void> makePaymet()async{
    try{

      Map<String, dynamic> body = {
        "amount": '100',
        "currency": "USD",
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          body:body,
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            'Authorization':'Bearer sk_test_51O9UUJL0eU4RO2jC7mqur9hInkdtZ1exQCT3Xjz73VI14ZiUI0u3FXOgqWqDWQbRhNO4D0gCh8lBcqJk8fFozsuh00BVlX4LVs',
            'Content-type': 'application/x-www-form-urlencoded'
          });
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(

          paymentIntentClientSecret: paymentIntent['client_secret'],
          //  googlePay:PaymentSheetGooglePay.fromJson(paymentIntent.value),
          //   applePay: PaymentSheetApplePay(merchantCountryCode: 'US'),
          style: ThemeMode.light,

          merchantDisplayName: "Woo English",


        ),

      );
      print("Response is here ${jsonDecode(response.body)}");


      paymentIntent = jsonDecode(response.body);
      // DIsplay payment sheet
      await displayPaymentSheet();




    }catch(e){
      print(e);
      //throw Exception(e.toString());
    }


  }

  displayPaymentSheet()async{
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) => {
        print('payment success'),

        Get.offAllNamed('/congratulation'),

        print('payment success')});
    } catch (e) {
      print("display exception $e");
      throw Exception(e);


    }

  }

  createPaymentIntent(String amount,String currency) async {

    try {

      //return jsonDecode(response.body.toString());
    } catch (e) {
      print("create payment Exception $e");
      throw Exception(e);
    }
    //Initialize payment sheet



  }




  void clickOnParticularPlan({required int index}) {
    inAsyncCall.value=true;
    if (currentIndexOfPlan.value == index) {
      currentIndexOfPlan.value = -1;
    } else {
      currentIndexOfPlan.value = index;
    }
    inAsyncCall.value=false;
  }

  void clickOnSubscriptionButton() {
    inAsyncCall.value=true;
    makePaymet();
    inAsyncCall.value=false;
  }

}
