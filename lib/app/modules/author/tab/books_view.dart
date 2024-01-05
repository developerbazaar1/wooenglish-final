import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/modules/author/controllers/author_controller.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

class BooksView extends GetView<AuthorController> {
  const BooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      body: Obx(() {
        if (controller.getAuthorDetailsModel.value?.authorBooks != null &&
            controller.getAuthorDetailsModel.value!.authorBooks!.isNotEmpty) {
          return ScrollConfiguration(
            behavior: ListScrollBehaviour(),
            child: CW.commonRefreshIndicator(
              child: CustomScrollView(
                slivers: [gridView()],
              ),
              onRefresh: () => controller.onRefresh(),
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  Widget gridView() => SliverPadding(
        padding: EdgeInsets.only(
            left: C.margin + 10.px,
            right: C.margin + 10.px,
            bottom: C.margin + C.margin),
        sliver: SliverGrid.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => controller.clickOnParticularBook(index: index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.px),
                child: imageViewBook(index: index),
              ),
            );
          },
          itemCount:
              controller.getAuthorDetailsModel.value?.authorBooks?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.63,
              crossAxisSpacing: 15.px,
              mainAxisSpacing: 15.px),
        ),
      );

  Widget imageViewBook({required int index}) {
    if (controller
            .getAuthorDetailsModel.value?.authorBooks![index].bookThumbnail !=
        null) {
      return Image.network(
        CM.getImageUrl(
            value: controller.getAuthorDetailsModel.value?.authorBooks![index]
                    .bookThumbnail ??
                ""),
        height: 150.px,
        width: 100.px,
        fit: BoxFit.cover,
        loadingBuilder:
            (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 150.px,
              width: 100.px,
              radius: 10.px);
        },
        errorBuilder:(context, error, stackTrace) {
          return Image.asset(
            C.imageBookImage,
            height: 150.px,
            width: 100.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageBookImage,
        height: 150.px,
        width: 100.px,
        fit: BoxFit.cover,
      );
    }
  }
}
