
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../appColors/app_colors.dart';
import '../../routes/routes.dart';
import '../../svgimages/svg_images.dart';
import '../../widgets/my_button_widget.dart';
import '../payment/payment_screen.dart';

class YourBagScreen extends StatefulWidget {
  const YourBagScreen({super.key});

  @override
  _YourBagScreenState createState() => _YourBagScreenState();
}

class _YourBagScreenState extends State<YourBagScreen> {
  late String sizeController;
  late String colorsController;
  late String quantityController;
  var cartData;
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            SvgImages.heart,
            color: AppColors.baseBlackColor,
            width: 40,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            SvgImages.delete,
            color: AppColors.baseBlackColor,
            width: 30,
          ),
        )
      ],
    );
  }

  Widget buildSingleBag() {
    return Card(
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/cc9be5be757f470b96eeaf00009dd6d6_9366/Adicolor_Classics_3-Stripes_Tee_Black_IB7407_21_model.jpg',
                            ),
                            // ""),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            '3 stripes shirt',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.baseBlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "adidas originals",
                            style: TextStyle(
                              color: AppColors.baseDarkPinkColor,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "\$40",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.baseBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$80",
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.baseGrey50Color,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.baseGrey30Color,
                        child: Icon(
                          Icons.check,
                          color: AppColors.baseWhiteColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double orderAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your bag",
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.baseBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  "You have 3 items in your bag",
                  style: TextStyle(
                    color: AppColors.baseGrey60Color,
                  ),
                ),
                buildSingleBag(),
                buildSingleBag(),
                buildSingleBag(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(
                            right: 20,
                          ),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: AppColors.basewhite60Color,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            "213132154",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.baseBlackColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          elevation: 0,
                          height: 40,
                          color: AppColors.baseLightOrangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: BorderSide.none,
                          ),
                          child: const Text(
                            "Employ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.baseWhiteColor,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Order amount",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.baseBlackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Your total amount of discount",
                        style: TextStyle(
                          color: AppColors.baseBlackColor,
                        ),
                      )
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "\$193",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.baseBlackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "\$-55.98",
                        style: TextStyle(
                          color: AppColors.baseBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: MyButtonWidget(
                    color: AppColors.baseDarkPinkColor,
                    text: "Checkout",
                    onPress: () {
                      PageRouting.goToNextPage(
                        context: context,
                        navigateTo: const PaymentScreen(),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
