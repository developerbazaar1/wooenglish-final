import 'package:get/get.dart';

import '../../../api/api_model/get_dashboard_data_model.dart';
import '../../../app_controller/app_controller.dart';

class OnGoingController extends AppController{
  @override
  Future<void> onInit() async{
    // TODO: implement onInit
    super.onInit();
  }
  final inAsyncCall=false.obs;
  final responseCode = 0.obs;
  final isLastPage = false.obs;
  List<Books> booksList = [];
  final getDataModel = Rxn<GetDashBoardBooksModel>();



  Future<void> onRefresh() async {
    await onInit();
  }
  Future<void> clickOnParticularBook({required int index}) async {
    inAsyncCall.value = true;
    // String tag = CM.getRandomNumber();
    // Get.put(BookDetailController(), tag: tag);
    // await Navigator.of(Get.context!).push(MaterialPageRoute(
    //   builder: (context) => BookDetailView(
    //     showbookto: booksList[index].bookdetails!.showbookto.toString(),
    //     isAudio: booksList[index].bookdetails?.isAudio,
    //     tag: tag,
    //     bookId: booksList[index].bookId.toString(),
    //     isLiked: getDataModel.value!.favorite!
    //         .contains(booksList[index].bookId.toString()),
    //     categoryId: booksList[index].bookdetails?.category,
    //   ),
    // ));
    // await Get.delete<BookDetailController>(tag: tag);
    // offset = 0;
    // await onInit();
    // inAsyncCall.value = false;
  }

  Future<bool> onLoadMore() async {
    // offset = offset + 10;
    // await getUserAllViewBooksApiCalling();
    // increment();
     return true;
  }

  void clickOnSoundButton({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }
  void clickOnLikeButton({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

}