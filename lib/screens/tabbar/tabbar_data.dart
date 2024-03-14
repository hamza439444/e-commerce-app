import 'package:flutter/material.dart';
import '../../models/single_product_models.dart';
import '../../widgets/single_product_widget.dart';

class TabBars extends StatelessWidget {
  final List<SingleProductModel> productData;
  const TabBars({super.key, required this.productData});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      primary: true,
      itemCount: productData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.7),
      itemBuilder: (context, index) {
        var data = productData[index];
        return SingleProductWidget(
          trilling: Container(),
          onPressed: () {},
          productImage: data.productImage,
          productModel: data.productModel,
          productName: data.productName,
          productOldPrice: data.productOldPrice.toInt(),
          productPrice: data.productPrice.toInt(),
        );
      },
    );
  }
}
