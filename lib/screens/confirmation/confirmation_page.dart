import 'package:flutter/material.dart';
import '../../appColors/app_colors.dart';
import '../../routes/routes.dart';
import '../../widgets/my_button_widget.dart';
import '../confirmationsuccesspage/confirmation_succes_page.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  AppBar buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
    );
  }

  Widget buildBottomPart(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: AppColors.baseGrey10Color,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Order amount",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.baseBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Your total amount of discount",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.baseBlackColor,
                  ),
                ),
              ],
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  "\$103.98",
                  style: TextStyle(
                    fontSize: 14,
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
                    fontSize: 12,
                    color: AppColors.baseBlackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: AppColors.baseGrey10Color,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 23),
          child: MyButtonWidget(
            color: AppColors.baseDarkPinkColor,
            text: "Place Order",
            onPress: () {
              PageRouting.goToNextPage(
                context: context,
                navigateTo: const ConfirmationSuccessPage(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildConfirmationProduct() {
    return Card(
      child: SizedBox(
        height: 140,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/45559fd582dd461ba06daf6c00b6e252_9366/AEROREADY_3-Stripes_Tee_Blue_IB8866_21_model.jpg"),
                            )),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "3 stripes shirt",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.baseBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$ 40",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.baseBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "adidas originals",
                                style: TextStyle(
                                  color: AppColors.baseDarkPinkColor,
                                ),
                              ),
                              Text(
                                "\$ 80",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 16,
                                  color: AppColors.baseBlackColor,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Color:\tBlack",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.baseGrey60Color,
                            ),
                          ),
                          const Text(
                            "Quantity:\tx1",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.baseGrey60Color,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      backgroundColor: AppColors.baseGrey10Color,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            color: AppColors.baseWhiteColor,
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    "Confirmation",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.baseBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("order number #123123213"),
                ),
                buildConfirmationProduct(),
                buildConfirmationProduct(),
                buildConfirmationProduct(),
                buildBottomPart(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
