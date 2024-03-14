
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../appColors/app_colors.dart';
import '../../data/category-data/category.data.dart';
import '../../styles/category_screen_styles.dart';
import '../../svgimages/svg_images.dart';
import '../tabbar/categorytabbar/category_all_tabbar.dart';
import '../tabbar/categorytabbar/category_men_tabbar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Welcome To Lapify",
        style: CategoryScreenStyles.categoryAppBarTitleStyle,
      ),
      actions: [
        RotationTransition(
          turns: const AlwaysStoppedAnimation(90 / 360),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              SvgImages.filter,
              color: AppColors.baseBlackColor,
              width: 35,
            ),
          ),
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
      bottom: const TabBar(
        indicator: BoxDecoration(color: Colors.transparent),
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: AppColors.baseBlackColor,
        labelColor: AppColors.baseDarkPinkColor,
        automaticIndicatorColorAdjustment: false,
        tabs: [
          Text("All"),
          Text("Men"),
          Text("Woman"),
          Text("Kids"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.baseWhiteColor,
        appBar: buildAppBar(),
        body: TabBarView(
          children: [
            //All Place
            const CategoryAllTabBar(),
            //Men  Place
            CategoryMenTabBar(
              categoryProductModel: menCategoryData,
            ),
            //woman Place
            CategoryMenTabBar(
              categoryProductModel: womenCategoryData,
            ),
            //Kids place
            CategoryMenTabBar(
              categoryProductModel: forKids,
            ),
          ],
        ),
      ),
    );
  }
}
