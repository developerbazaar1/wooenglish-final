import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/modules/author/controllers/author_controller.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

class ReviewsView extends GetView<AuthorController> {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        if (controller.getAuthorDetailsModel.value?.authorBooksReviews !=
                null &&
            controller
                .getAuthorDetailsModel.value!.authorBooksReviews!.isNotEmpty) {
          return ScrollConfiguration(
            behavior: ListScrollBehaviour(),
            child: CW.commonRefreshIndicator(
                onRefresh: () => controller.onRefresh(),
                child: listViewReviewList()),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  Widget listViewReviewList() => ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 20.px),
          child: Column(
            children: [
              Container(
                height: 60.px,
                decoration: BoxDecoration(
                  color: Col.onSurface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.px),
                    topRight: Radius.circular(4.px),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15.px, top: 5.px, bottom: 5.px),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.px),
                        child: imageViewReviewUser(index: index),
                      ),
                      SizedBox(
                        width: 5.px,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller
                                    .getAuthorDetailsModel
                                    .value
                                    ?.authorBooksReviews?[index]
                                    .userdetails
                                    ?.name !=
                                null)
                              Row(
                                children: [
                                  textViewReviewUser(
                                      value: controller
                                              .getAuthorDetailsModel
                                              .value
                                              ?.authorBooksReviews?[index]
                                              .userdetails
                                              ?.name ??
                                          ""),
                                  SizedBox(width: 5.px,),
                                  if (controller.getAuthorDetailsModel.value
                                      ?.authorBooksReviews?[index].userdetails!.status== "active")
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Image(
                                          image:
                                          AssetImage(C.imageUserVerified),
                                          width: 15,
                                          height: 15,
                                        ))
                                ],
                              ),
                            if (controller.getAuthorDetailsModel.value
                                    ?.authorBooksReviews?[index].rating !=
                                null)
                              imageViewRatting(
                                  value: double.parse(controller
                                          .getAuthorDetailsModel
                                          .value
                                          ?.authorBooksReviews?[index]
                                          .rating ??
                                      "0.0")),



                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (controller.getAuthorDetailsModel.value
                      ?.authorBooksReviews?[index].review !=
                  null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Col.inverseSecondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.px),
                      bottomRight: Radius.circular(4.px),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 15.px, top: 8.px, bottom: 8.px),
                    child: textViewReadMore(
                        value: controller.getAuthorDetailsModel.value
                                ?.authorBooksReviews?[index].review ??
                            ""),
                  ),
                ),
            ],
          ),
        ),
        padding: EdgeInsets.only(
            left: C.margin + 10.px,
            right: C.margin + 10.px,
            bottom: C.margin + C.margin),
        itemCount:
            controller.getAuthorDetailsModel.value?.authorBooksReviews?.length,
      );

  Widget imageViewReviewUser({required int index}) {
    if (controller.getAuthorDetailsModel.value?.authorBooksReviews?[index]
            .userdetails?.userImage !=
        null) {
      return Image.network(
        CM.getImageUrl(
            value: controller.getAuthorDetailsModel.value
                    ?.authorBooksReviews?[index].userdetails?.userImage ??
                ""),
        height: 50.px,
        width: 50.px,
        fit: BoxFit.cover,
        loadingBuilder:
            (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 50.px,
              width: 50.px,
              radius: 30.px);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageUserProfile,
            height: 50.px,
            width: 50.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageUserProfile,
        height: 50.px,
        width: 50.px,
        fit: BoxFit.cover,
      );
    }
  }

  Widget textViewReviewUser({required String value}) => Text(
        value,
        style: CT.openSansBodyMedium(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget imageViewRatting({required double value}) =>
      CW.commonRattingView(rating: value);

  Widget textViewReadMore({required String value}) {
    return CW.commonReadMoreText(
      value: value,
    );
  }
}
