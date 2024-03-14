
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../appColors/app_colors.dart';
import '../../routes/routes.dart';
import '../../svgimages/svg_images.dart';
import '../../widgets/my_button_widget.dart';
import '../../widgets/my_textfromfield_widget.dart';
import '../confirmation/confirmation_page.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            SvgImages.plus,
            color: AppColors.baseBlackColor,
            width: 40,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            SvgImages.delete,
            color: AppColors.baseBlackColor,
            width: 25,
          ),
        )
      ],
    );
  }

  Widget buildTextField({
    required double leftPadding,
    required double rightPadding,
    required String hintText,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        top: 20,
        left: leftPadding,
        right: rightPadding,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.grey[100],
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Payment",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Order number is 1235462412",
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.baseGrey50Color,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: 180,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const SweepGradient(
                    center: AlignmentDirectional(1, -1),
                    startAngle: 1.7,
                    endAngle: 3,
                    colors: <Color>[
                      Color(0xff148535),
                      Color(0xff148535),
                      Color(0xff0D6630),
                      Color(0xff0D6630),
                      Color(0xff148535),
                      Color(0xff148535),
                    ],
                    stops: <double>[0.0, 0.3, 0.3, 0.7, 0.7, 1.0],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "VISA",
                          style: TextStyle(
                            fontSize: 24.30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.baseWhiteColor,
                          ),
                        ),
                        Text(
                          "visa Electron",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.baseWhiteColor,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "**** **** **** **** 1256",
                      style: TextStyle(
                        fontSize: 24.30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.baseWhiteColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Card holder",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.baseWhiteColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Faiza Afzaal",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.baseWhiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Expires",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.baseWhiteColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "2/24",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.baseWhiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  backgroundColor:
                                      AppColors.baseLightGreenColor,
                                  child: Icon(
                                    Icons.check,
                                    color: AppColors.baseWhiteColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              MyTextFromField(
                hintText: "Card holder",
                obscureText: false,
              ),
              MyTextFromField(
                hintText: "Card number",
                obscureText: false,
              ),
              Row(
                children: [
                  Expanded(
                    child: buildTextField(
                      hintText: "Exp",
                      leftPadding: 20,
                      rightPadding: 0,
                    ),
                  ),
                  Expanded(
                    child: buildTextField(
                      hintText: "CVV",
                      leftPadding: 3,
                      rightPadding: 10,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(right: 20),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          primary: AppColors.baseLightOrangeColor,
                          onSurface: Colors.grey,
                        ),
                        icon: SvgPicture.asset(
                          SvgImages.plus,
                          color: AppColors.baseWhiteColor,
                          width: 20,
                        ),
                        label: const Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.baseWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
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
                  text: "Confirmation",
                  onPress: () {
                    PageRouting.goToNextPage(
                        context: context, navigateTo: const ConfirmationPage());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
