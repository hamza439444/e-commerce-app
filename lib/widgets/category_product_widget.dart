
import 'package:e_commerce_appmerce_app/appColors/app_colors.dart';
import 'package:e_commerce_appmerce_app/styles/category_screen_styles.dart';
import 'package:flutter/material.dart';

class CategoryProductWidget extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productModel;
  final Function onPressed;
  const CategoryProductWidget({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productModel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed(),
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 20, bottom: 20),
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                    productImage,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: CategoryScreenStyles.categoryProductNameStyle,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    productModel,
                    style: CategoryScreenStyles.categoryProductModelStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.baseBlackColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
