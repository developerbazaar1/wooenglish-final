import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/splash/controllers/splash_controller.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

import '../../../data/local_database/database_const/database_const.dart';
import '../../../data/local_database/database_helper/database_helper.dart';

RxBool isGoldenSubscribed = false.obs;
RxBool isSilverSubscribed = false.obs;
RxBool isPlatinumSubscribed = false.obs;


class SubscriptionController extends AppController {
  RxBool isLoading = false.obs;
  RxBool isPaymentLoading = false.obs;

  final count = 0.obs;
  final inAsyncCall = false.obs;
  final currentIndexOfIncludePlan = [-1, -1, -1, -1].obs;
  final currentIndexOfPlan = Rxn<int>();
  RxInt selectedRadioButton = 0.obs;
  RxInt selectedRadioPrice = 0.obs;
  RxInt selectedRadioID = 0.obs;
  RxMap paymentIntent = Map().obs;
  RxMap GetSubcriptionData = Map().obs;
  RxMap paymentStatusData = Map().obs;
  RxString isnstansToekn = ''.obs;

  RxInt GetSubcriptionDataLength = 0.obs;

  @override
  void onInit() async{
    super.onInit();
    currentIndexOfPlan.value = -1;
    isnstansToekn.value =await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnToken);

    await GetSubcriptionAPI();


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

  void _setKey( key) async {


    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('subscribe', key);
    print('set key');
  }
  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod()) {
        onInit();
      } else {}
    });
  }

  void increment() => count.value++;

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  //____________________Payment Status API_____________________
  Future<void> PaymentStatusAPI(
      plan_id, amount, currency, status, transaction_id) async {
    try {
      var headers = {
        'Authorization':
            'Bearer Bearer 124|GQbMS82Uvmj78VlpOGMpj2GhnYmJIwSxC5V1cDyl'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://hostingbazaar.in/WooEnglish/api/payment-update'));
      request.fields.addAll({
        'plan_id': 1.toString(),
        'amount': 100.toString(),
        'currency': currency,
        'status': status,
        'transaction_id': transaction_id
      });
      print(" $amount $plan_id");
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var data = await response.stream.bytesToString();
      paymentStatusData.value = jsonDecode(data);
      print(paymentStatusData.value);
      if (response.statusCode == 200) {


        if(paymentStatusData.value['status']==true)
        Get.offAllNamed('/congratulation');
        _setKey(true);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> paymentStatusAPI(
    String plan_id,
    String amount,
    String currency,
    String status,
    String transaction_id,
  ) async {
    isLoading.value = true;
    try {
      var headers = {'Authorization': 'Bearer Bearer $token'};
      var request = http.MultipartRequest('POST',
          Uri.parse('https://hostingbazaar.in/WooEnglish/api/payment-update'));
      request.fields.addAll({
        'plan_id': plan_id,
        'amount': amount,
        'currency': currency,
        'status': status,
        'transaction_id': transaction_id
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(await response.stream.bytesToString()+'this is payment status app');
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  // _____________________Stripe payment details____________
  Future<void> makePaymet() async {
    isPaymentLoading.value = true;
    try {
      Map<String, dynamic> body = {
        "amount": '${selectedRadioPrice.value * 100}',
        "currency": "USD",
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          body: body,
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            'Authorization':
                'Bearer sk_test_51O9UUJL0eU4RO2jC7mqur9hInkdtZ1exQCT3Xjz73VI14ZiUI0u3FXOgqWqDWQbRhNO4D0gCh8lBcqJk8fFozsuh00BVlX4LVs',
            'Content-type': 'application/x-www-form-urlencoded'
          });
      isPaymentLoading.value = true;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent.value['client_secret'],
          // customFlow: true,
          //  googlePay:PaymentSheetGooglePay.fromJson(paymentIntent.value),
          //   applePay: PaymentSheetApplePay(merchantCountryCode: 'US'),
          style: ThemeMode.light,
          allowsDelayedPaymentMethods: true,

          merchantDisplayName: "Woo English",
          // allowsDelayedPaymentMethods: true,
          // removeSavedPaymentMethodMessage:
        ),
      );

      // await Stripe.instance.confirmPayment(paymentIntentClientSecret:  paymentIntent.value['client_secret']);

      paymentIntent.value = jsonDecode(response.body);
      print("Response is here ${paymentIntent.value}");
      //print("Transaction Id ${paymentIntent.value['data'][0]['balanceTransaction']}");

      isPaymentLoading.value = false;
      // DIsplay payment sheet
      await displayPaymentSheet();
    } catch (e) {
      isPaymentLoading.value = false;
      print(e);
      //throw Exception(e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      isLoading.value = false;
      await Stripe.instance
          .presentPaymentSheet(
              options: PaymentSheetPresentOptions(timeout: 1200000))
          .then((value) => {
                print('payment success'),
                print(" YYYYYYYYYYYYYYYYY $value"),
                // paymentStatusAPI();

                //
                // if(selectedRadioButton.value==1){
                // isSilverSubscribed.value = true,
                //   isSubscribed.value =true,
                //
                // }else
                //
                // if(selectedRadioButton.value==2){
                // isPlatinumSubscribed.value = true,
                //   isSubscribed.value =true,
                // }else
                //
                // if(selectedRadioButton.value==3){
                // isGoldenSubscribed.value=true,
                //   isSubscribed.value =true,
                // },
                PaymentStatusAPI(
                    selectedRadioID.value.toString(),
                    selectedRadioPrice.value.toString(),
                    paymentIntent.value['currency'],
                    'status',
                    paymentIntent.value['id'].toString()),

                //      print("______________kkkkkkkkkkkkkk___${isGoldenSubscribed.value} ${isGoldenSubscribed.value} ${isSilverSubscribed.value}"),

                print('payment success')
              });
    } catch (e) {
      print("display exception $e");
      throw Exception(e);
    }
  }

  // _____________________Subcription API calling___________
  Future<void> GetSubcriptionAPI() async {
    print(1);
    isLoading.value = true;
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer Bearer ${isnstansToekn.value}'
      };
      var request = http.Request('GET',
          Uri.parse('https://hostingbazaar.in/WooEnglish/api/subscriptions'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(2);

      var data = await response.stream.bytesToString();
      GetSubcriptionData.value = jsonDecode(data);
      print(GetSubcriptionData.value );

      if (response.statusCode == 200) {

        GetSubcriptionDataLength.value =
            GetSubcriptionData['subscription'].length;
        print(GetSubcriptionDataLength.value);

        print(GetSubcriptionData.value['subscription'][0]['plan_name']);
        isLoading.value = false;
        print(3);

      } else {

        print(response.reasonPhrase);
        isLoading.value = false;
        print(4);

      }
    } catch (e) {
      print(e);
      isLoading.value = false;
      print(5);

    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //return jsonDecode(response.body.toString());
    } catch (e) {
      print("create payment Exception $e");
      throw Exception(e);
    }
    //Initialize payment sheet
  }

  clickOnParticularPlan({
    required int index,
    required int price,
    required int ID,
  }) {

    inAsyncCall.value = true;

    selectedRadioButton.value = index + 1;
    selectedRadioPrice.value = price;
    selectedRadioID.value = ID;
    print('%%%%%%%%%%%%%${selectedRadioPrice.value.toString()}  ${currentIndexOfPlan.value}  $index');

    if (currentIndexOfPlan.value == index) {
     // currentIndexOfPlan.value = -1;
    } else {
      currentIndexOfPlan.value = index;
    }
    inAsyncCall.value = false;
  }

  void clickOnSubscriptionButton() {
    inAsyncCall.value = true;

    makePaymet();
    inAsyncCall.value = false;
  }
}
