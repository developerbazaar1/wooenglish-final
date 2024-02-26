import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/routes/app_pages.dart';

import '../../splash/controllers/splash_controller.dart';

class PaymentController extends GetxController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final formKey = GlobalKey<FormState>();
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cardExpiryDateController = TextEditingController();
  final cardCvvCodeController = TextEditingController();

  Map paymentIntent = Map();

  var ready;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

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
          .then((value) => {print('payment success'),
      Get.snackbar(
      'payment Success',
      'Payment Successfully done',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      colorText: Colors.black,
      ),
        //Get.offAllNamed(newRouteName)




          });
    } catch (e) {
      print("display exception $e");
      throw Exception(e);


    }

  }

   createPaymentIntent(String amount,String currency) async {
    print('Api key $token');
    try {

      //return jsonDecode(response.body.toString());
    } catch (e) {
      print("create payment Exception $e");
      throw Exception(e);
    }
    //Initialize payment sheet



  }


  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await createPaymentIntent('100',"USD");

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['paymentIntent'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['customer'],
          // Extra options


        ),
      );

        ready = true;

    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
   //   );
      rethrow;
    }
  }




  void increment() => count.value++;

  void clickOnBackButton() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  void clickOnVisaLogo() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnPayPalLogo() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnMasterLogo() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnPaymentButton() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    if (formKey.currentState!.validate()) {
      makePaymet();
      //Get.toNamed(Routes.CONGRATULATION);
    }
    inAsyncCall.value = false;
  }
}
