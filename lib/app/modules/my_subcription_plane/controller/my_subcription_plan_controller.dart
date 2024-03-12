import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';

import '../../../api/api_constant/api_constant.dart';
import '../../../api/http_methods/http_methods.dart';
import '../../../common/common_method/common_method.dart';
import '../../../data/local_database/database_const/database_const.dart';
import '../../../data/local_database/database_helper/database_helper.dart';
import 'package:http/http.dart'as http;

import '../../splash/controllers/splash_controller.dart';

class MySubscriptionController extends AppController{
  final inAsyncCall = false.obs;
  RxString MembershipPlan = ''.obs;
  RxString MembershipDate = ''.obs;
  RxString MembershipExpireDate = ''.obs;
  RxString MembershipDuration = ''.obs;
  RxString MembershipPeriods = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isUpgrade = false.obs;
  RxMap GetSubcriptionData = Map().obs;
  RxString isnstansToekn = ''.obs;
  RxString planPrice = ''.obs;
  RxString planName= ''.obs;
  RxInt GetSubcriptionDataLength = 0.obs;
  RxInt selectedRadioButton = 0.obs;
  RxInt selectedRadioPrice = 0.obs;
  RxInt selectedRadioID = 0.obs;
  final currentIndexOfPlan = Rxn<int>();
  RxMap paymentIntent1 = Map().obs;
           RxBool isPaymentLoading = false.obs;
  Map<String, dynamic> bodyParamsForPaymentStatus = {};
  RxMap paymentStatusData = Map().obs;

  @override
  void onInit()async {

    MembershipPlan.value=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnMembershipPlan);
    MembershipDate.value=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnMembershipDate);

    MembershipExpireDate.value=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnMembershipExpireDate);

    isnstansToekn.value =await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnToken);
    print(MembershipPlan.value+MembershipExpireDate.value+MembershipDate.value+'token in my plan page');
    if(isnstansToekn.value!=null)
    await GetSubcriptionAPI();




    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }
  void clickOnUpgradeButton() {
    inAsyncCall.value = true;
    print('Subcription value ${selectedRadioButton.value}');
    if (selectedRadioButton.value == null ||
        selectedRadioButton.value == 0) {
      CM.showToast('Please select any Payment',);

    } else {
     clickOnSubscriptionButton();
    }




    inAsyncCall.value = false;
  }

  void clickOnSubscriptionButton() async {
    inAsyncCall.value = true;

    await makePaymet();
    inAsyncCall.value = false;
  }
  Future<void> makePaymet() async {
    isPaymentLoading.value = true;
    try {
      await createPaymentIntent(selectedRadioPrice.value.toString(), "USD");

      isPaymentLoading.value = true;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent1.value['client_secret'],

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

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
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
      paymentIntent1.value = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
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
            paymentIntent1.value['currency'],
            'success',
            paymentIntent1.value['id'].toString()),

        print('payment success')
      });
      print("this is amount ${selectedRadioPrice.value}");
    } catch (e) {
      print("display exception $e");
      throw Exception(e);
    }
  }

  // Future<bool> PaymentStatusAPICalling(plan_id, amount, currency, status, transaction_id) async {
  //   bodyParamsForPaymentStatus = {
  //     ApiKey.plan_id: plan_id,
  //     ApiKey.amount: amount,
  //     ApiKey.currency: currency,
  //     ApiKey.status: status,
  //     ApiKey.transaction_id: transaction_id,
  //   };
  //   http.Response? response = await HttpMethod.instance.postRequest(
  //       url: UriConstant.endPointPaymentStatus,
  //       bodyParams: bodyParamsForPaymentStatus);
  //   if (CM.responseCheckForPostMethod(response: response)) {
  //     print(paymentStatusData.value);
  //     if (response!.statusCode == 200) {
  //       if (paymentStatusData.value['status'] == true)
  //         Get.offAllNamed('/congratulation');
  //       // _setKey(true);
  //     } else {
  //       inAsyncCall.value = false;
  //       print(response.reasonPhrase);
  //     }
  //     bodyParamsForPaymentStatus.clear();
  //     return true;
  //   } else {
  //     bodyParamsForPaymentStatus.clear();
  //     return false;
  //   }
  // }

  Future<void> PaymentStatusAPI(
      plan_id, amount, currency, status, transaction_id) async {

    try {

      inAsyncCall.value = true;
      var headers = {
        'Authorization': 'Bearer $token'

      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://hostingbazaar.in/WooEnglish/api/payment-update'));
      request.fields.addAll({
        'plan_id': plan_id,
        'amount':amount,
        'currency': currency,
        'status': status,
        'transaction_id': transaction_id
      });
      print(" $amount $plan_id diad");
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var data = await response.stream.bytesToString();
      paymentStatusData.value = jsonDecode(data);
      inAsyncCall.value = false;
      print(paymentStatusData.value);
      if (response.statusCode == 200) {
        if (paymentStatusData.value['status'] == true)
          Get.offAllNamed('/congratulation');
       // _setKey(true);
      } else {
        inAsyncCall.value = false;
        print(response.reasonPhrase);
      }
    } catch (e) {
      inAsyncCall.value = false;
      print(e);
    }
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
    print(
        '%%%%%%%%%%%%%${selectedRadioPrice.value.toString()}  ${currentIndexOfPlan.value}  $index');

    if (currentIndexOfPlan.value == index) {
      // currentIndexOfPlan.value = -1;
    } else {
      currentIndexOfPlan.value = index;
    }
    inAsyncCall.value = false;
  }
  Future<void> GetSubcriptionAPI() async {
inAsyncCall.value = true;

    isLoading.value = true;
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('GET',
          Uri.parse('https://hostingbazaar.in/WooEnglish/api/subscriptions'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(2);

      var data = await response.stream.bytesToString();
      GetSubcriptionData.value = jsonDecode(data);
      print('my plan api data${GetSubcriptionData.value}');


      if (response.statusCode == 200) {

        GetSubcriptionDataLength.value =
            GetSubcriptionData['subscription'].length;
        for(int i = 0;i<=GetSubcriptionDataLength.value;i++ ){
          print(GetSubcriptionData.value['subscription'][i]['id'].toString()+'this is id');
          print(MembershipPlan.value+'this is member');
          if(GetSubcriptionData.value['subscription'][i]['id'].toString()== MembershipPlan.value){
            print('Plan Id matched');
            planName.value= GetSubcriptionData.value['subscription'][i]['plan_name'].toString();
            planPrice.value = GetSubcriptionData.value['subscription'][i]['plan_price'].toString();
            MembershipDuration.value = GetSubcriptionData.value['subscription'][i]['plan_duration'].toString();
            MembershipPeriods.value = GetSubcriptionData.value['subscription'][i]['plan_period'].toString();
            MembershipDate.value=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnMembershipDate);
            MembershipExpireDate.value=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnMembershipExpireDate);
            inAsyncCall.value = false;
          }else{

            print('value not matched ${MembershipPlan.value}');
            inAsyncCall.value = false;
          }

        }

        isLoading.value = false;


      } else {

        print(response.reasonPhrase);
        isLoading.value = false;

        inAsyncCall.value = false;

      }
    } catch (e) {
      print(e);
      isLoading.value = false;

    }
  }
}
