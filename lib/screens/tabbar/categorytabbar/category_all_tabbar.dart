
import 'package:flutter/material.dart';
import '../../../data/home-page-data/home_page_data.dart';
import '../../../models/single_product_models.dart';
import '../../../widgets/show_all_widget.dart';
import '../../../widgets/single_product_widget.dart';

class CategoryAllTabBar extends StatelessWidget {
  const CategoryAllTabBar({super.key});

  Widget builderRender({required List<SingleProductModel> singleProduct}) {
    return SizedBox(
      height: 250,
      child: GridView.builder(
        itemCount: singleProduct.length,
        shrinkWrap: true,
        primary: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.4,
        ),
        itemBuilder: (context, index) {
          var data = singleProduct[index];
          return SingleProductWidget(
            trilling: Container(),
            onPressed: () {
              // PageRouting.goToNextPage(
              //     navigateTo: DetailScreen(data: data), context: context);
            },
            productImage: data.productImage,
            productModel: data.productModel,
            productName: data.productName,
            productOldPrice: data.productOldPrice.toInt(),
            productPrice: data.productPrice.toInt(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ShowAllWidget(
          leftText: "Clothing",
        ),
        builderRender(singleProduct: clothsData),
        ShowAllWidget(
          leftText: "Shoes",
        ),
        builderRender(
          singleProduct: shoesData,
        ),
        ShowAllWidget(
          leftText: "Accessories",
        ),
        builderRender(
          singleProduct: accessoriesData,
        ),
      ],
    );
  }
}
