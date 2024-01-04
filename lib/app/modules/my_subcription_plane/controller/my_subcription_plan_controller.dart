import 'dart:convert';

import 'package:get/get.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';

import '../../../data/local_database/database_const/database_const.dart';
import '../../../data/local_database/database_helper/database_helper.dart';
import 'package:http/http.dart'as http;

class MySubscriptionController extends AppController{
  final inAsyncCall = false.obs;
  RxString MembershipPlan = ''.obs;
  RxString MembershipDate = ''.obs;
  RxString MembershipExpireDate = ''.obs;
  RxString MembershipDuration = ''.obs;
  RxString MembershipPeriods = ''.obs;
  RxBool isLoading = false.obs;
  RxMap GetSubcriptionData = Map().obs;
  RxString isnstansToekn = ''.obs;
  RxString planPrice = ''.obs;
  RxString planName= ''.obs;
  RxInt GetSubcriptionDataLength = 0.obs;

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
    Get.back();


    inAsyncCall.value = false;
  }
  Future<void> GetSubcriptionAPI() async {

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
          }else{

            print('value not matched ${MembershipPlan.value}');
          }

        }

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
}
