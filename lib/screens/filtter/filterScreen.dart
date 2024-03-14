
import 'package:flutter/material.dart';

import '../../appColors/app_colors.dart';
import '../../styles/detail_screen_styles.dart';
import '../../widgets/my_button_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? _ratingController;
  String? _categoryController;

  RangeValues _currentRangeValues = const RangeValues(40, 80);

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      centerTitle: true,
      title: const Text(
        "Filter",
        style: TextStyle(
          color: AppColors.baseBlackColor,
        ),
      ),
    );
  }

  Widget buildExpansionTil({
    required List<String> items,
    required String title,
    required String hint,
    required String value,
  }) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.baseBlackColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  fillColor: AppColors.basewhite60Color,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                iconSize: 30,
                hint: Text(
                  hint,
                  style: DetailScreenStyles.productDropDownValueStyle,
                ),
                value: value,
                items: items
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  setState(
                    () {
                      value = value;
                    },
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildListTile({required String title}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.baseBlackColor,
        ),
      ),
    );
  }

  Widget buildSizeGuides(
      {required String text,
      bool containerColor = false,
      required Color color}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: containerColor ? color : AppColors.baseGrey10Color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: containerColor
          ? Container()
          : Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Widget buildPriceExpansionTile() {
    return ExpansionTile(
      title: const Text(
        "Price",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.baseBlackColor,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              RangeSlider(
                values: _currentRangeValues,
                min: 0,
                max: 1000,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$\t${_currentRangeValues.start.toInt()}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.baseBlackColor,
                    ),
                  ),
                  Text(
                    "\$\t${_currentRangeValues.end.toInt()}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.baseBlackColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          buildListTile(
            title: "Most popular",
          ),
          const Divider(),
          buildListTile(
            title: "New Items",
          ),
          const Divider(),
          buildListTile(
            title: "Price:\t High - Low",
          ),
          const Divider(),
          buildListTile(
            title: "Price:\t Low - High",
          ),
          const Divider(),
          ExpansionTile(
            title: const Text(
              "Size",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.baseBlackColor,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  crossAxisCount: 5,
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    buildSizeGuides(
                      text: "5",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "5.5",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "6",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "6.5",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "7",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "7.5",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "8",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "8.5",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "9",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "9.5",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "10",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "10.5",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "11",
                      color: AppColors.baseBlackColor,
                    ),
                    buildSizeGuides(
                      text: "11",
                      color: AppColors.baseBlackColor,
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(),
          ExpansionTile(
            title: const Text(
              "Colors",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.baseBlackColor,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  crossAxisCount: 5,
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    buildSizeGuides(
                      color: AppColors.baseDarkPinkColor,
                      containerColor: true,
                      text: 'pink',
                    ),
                    buildSizeGuides(
                      color: Colors.yellow,
                      containerColor: true,
                      text: 'yellow',
                    ),
                    buildSizeGuides(
                      color: Colors.green,
                      containerColor: true,
                      text: 'green',
                    ),
                    buildSizeGuides(
                      color: Colors.pinkAccent,
                      containerColor: true,
                      text: 'pink',
                    ),
                    buildSizeGuides(
                      color: Colors.yellowAccent,
                      containerColor: true,
                      text: 'yellow',
                    ),
                  ],
                ),
              )
            ],
          ),
          buildPriceExpansionTile(),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: MyButtonWidget(
              color: AppColors.baseDarkPinkColor,
              onPress: () {},
              text: "View more item",
            ),
          ),
        ],
      ),
    );
  }
}
