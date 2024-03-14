
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../appColors/app_colors.dart';
import '../../models/single_product_models.dart';
import '../../styles/sub_category_styles.dart';
import '../../svgimages/svg_images.dart';
import '../../widgets/single_product_widget.dart';

class SubCategory extends StatefulWidget {
  final List<SingleProductModel> productData;
  final String productName;
  final String productModel;
  const SubCategory(
      {super.key,
      required this.productData,
      required this.productName,
      required this.productModel});
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  int isSelect = 1;

  List<bool> isSelected = [true, false, false];
  FocusNode focusNodeButton1 = FocusNode();
  FocusNode focusNodeButton2 = FocusNode();
  FocusNode focusNodeButton3 = FocusNode();
  late List<FocusNode> focusToggle;

  @override
  void initState() {
    focusToggle = [
      focusNodeButton1,
      focusNodeButton2,
      focusNodeButton3,
    ];
    super.initState();
  }

  @override
  void dispose() {
    focusNodeButton1.dispose();
    focusNodeButton2.dispose();
    focusNodeButton3.dispose();

    super.dispose();
  }

  Widget buildToggleButton() {
    return ToggleButtons(
      borderWidth: 0,
      focusColor: null,
      fillColor: Colors.transparent,
      selectedColor: AppColors.baseDarkPinkColor,
      disabledColor: AppColors.baseBlackColor,
      selectedBorderColor: Colors.transparent,
      borderColor: Colors.transparent,
      focusNodes: focusToggle,
      onPressed: (int index) {
        if (index == 0) {
          setState(() {
            isSelect = 1;
          });
        } else if (index == 1) {
          setState(() {
            isSelect = 2;
          });
        } else if (index == 2) {
          setState(() {
            isSelect = 3;
          });
        }

        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: isSelected,
      children: const [
        Icon(
          Icons.grid_view,
          size: 25,
        ),
        Icon(
          Icons.view_agenda_outlined,
          size: 25,
        ),
        Icon(
          Icons.crop_landscape_sharp,
          size: 25,
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      actions: [
        IconButton(
          icon: RotationTransition(
            turns: const AlwaysStoppedAnimation(
              90 / 360,
            ),
            child: SvgPicture.asset(
              SvgImages.filter,
              color: AppColors.baseBlackColor,
              width: 35,
            ),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            SvgImages.search,
            color: AppColors.baseBlackColor,
            width: 35,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: SubCategoryStyles.subCategoryTitleStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${widget.productData.length} Products",
                  style: SubCategoryStyles.subCategoryProductItemStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.list_alt_sharp,
                            color: AppColors.baseBlackColor,
                            size: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Product Model',
                            style: SubCategoryStyles.subCategoryModelNameStyle,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildToggleButton(),
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: widget.productData.length,
                  primary: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isSelect == 1
                        ? 2
                        : isSelect == 2
                            ? 1
                            : isSelect == 3
                                ? 1
                                : 2,
                    childAspectRatio: isSelect == 1
                        ? 0.7
                        : isSelect == 2
                            ? 1.5
                            : isSelect == 3
                                ? 0.8
                                : 0.7,
                  ),
                  itemBuilder: (context, index) {
                    var data = widget.productData[index];
                    return SingleProductWidget(
                      trilling: Container(),
                      onPressed: () {
                        // PageRouting.goToNextPage(
                        //   navigateTo: DetailScreen(
                        //     data: data,
                        //   ),
                        //   context: context,
                        // );
                      },
                      productImage: data.productImage,
                      productModel: data.productModel,
                      productOldPrice: data.productOldPrice.toInt(),
                      productName: data.productName,
                      productPrice: data.productPrice.toInt(),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
