
import 'package:flutter/material.dart';

import '../../../data/category-data/category.data.dart';
import '../../../data/home-page-data/home_page_data.dart';
import '../../../models/categoryProductModel.dart';
import '../../../routes/routes.dart';
import '../../../widgets/category_product_widget.dart';
import '../../category/sub_category.dart';

class CategoryMenTabBar extends StatelessWidget {
  List<CategoryProductModel> categoryProductModel = [];
  CategoryMenTabBar({
    super.key,
    required this.categoryProductModel,
  });

  @override
  Widget build(BuildContext context) {
    CategoryProductModel data;
    buildConditions(index) {
      if (index == 0) {
        PageRouting.goToNextPage(
          //fillClothData[index]
          navigateTo: SubCategory(
            productModel: clothsData[index].productModel,
            productData: clothsData,
            productName: womenCategoryData[index].productName,
          ),
          context: context,
        );
      } else if (index == 1) {
        PageRouting.goToNextPage(
          //fillClothData[index]
          navigateTo: SubCategory(
              productModel: shoesData[index].productModel,
              productData: shoesData,
              productName: menCategoryData[index].productName),
          context: context,
        );
      } else if (index == 2) {
        PageRouting.goToNextPage(
          navigateTo: SubCategory(
            productModel: accessoriesData[index].productModel,
            productData: accessoriesData,
            productName: forKids[index].productName,
          ),
          context: context,
        );
      } else if (index == 3) {
        PageRouting.goToNextPage(
          navigateTo: SubCategory(
            productModel: accessoriesData[index].productModel,
            productData: accessoriesData,
            productName: menCategoryData[index].productName,
          ),
          context: context,
        );
      } else if (index == 4) {
        PageRouting.goToNextPage(
          navigateTo: SubCategory(
            productModel: accessoriesData[index].productModel,
            productData: accessoriesData,
            productName: menCategoryData[index].productName,
          ),
          context: context,
        );
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: categoryProductModel.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        data = categoryProductModel[index];
        return CategoryProductWidget(
          onPressed: () {
            buildConditions(index);
          },
          productImage: data.productImage,
          productModel: "${clothsData.length}\t${data.productModel}",
          productName: data.productName,
        );
      },
    );
  }
}
