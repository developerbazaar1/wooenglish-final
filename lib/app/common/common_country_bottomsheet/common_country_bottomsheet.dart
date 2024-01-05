import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/countries/get_countries_model.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

class CB extends StatelessWidget {
  GetCountriesModel? getCountriesModel;
  void Function(int)? indexValue;

  CB({Key? key, required this.getCountriesModel,required this.indexValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ScrollConfiguration(
        behavior: ListScrollBehaviour(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.px),
              child: const Text("Select Countries"),
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.px),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.px),
                            onTap: () {
                              indexValue?.call(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.px, horizontal: C.margin),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.px),
                                  color: Col.inverseSecondary),
                              child: Row(
                                children: [
                                  Image.network(
                                    getCountriesModel
                                            ?.country?[index].flags?.png ??
                                        "",
                                    height: 30.px,
                                    width: 35.px,
                                  ),
                                  SizedBox(
                                    width: 20.px,
                                  ),
                                  Expanded(
                                    child: Text(
                                        getCountriesModel?.country?[index].name
                                                ?.common ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: getCountriesModel?.country?.length),
            ),
          ],
        ),
      ),
    );
  }
}
