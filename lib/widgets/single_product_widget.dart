

import 'package:e_commerce_appmerce_app/appColors/app_colors.dart';
import 'package:flutter/material.dart';

class SingleProductWidget extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productModel;
  final int productPrice;
  final int productOldPrice;
  final Widget trilling;
  final VoidCallback onPressed;
  const SingleProductWidget({
    super.key,
    required this.productImage,
    required this.productModel,
    required this.productName,
    required this.productPrice,
    required this.productOldPrice,
    required this.onPressed,
    required this.trilling,
  });

  @override
  _SingleProductWidgetState createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
  bool isFave = false;

  // get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: 250,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.productImage,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.productName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.productModel,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.baseDarkPinkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  widget.trilling,
                  Row(
                    children: [
                      Text(
                        "\$ ${widget.productPrice}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "\$ ${widget.productOldPrice}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
