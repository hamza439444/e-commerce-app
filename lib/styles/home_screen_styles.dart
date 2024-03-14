import 'package:flutter/material.dart';

import '../appColors/app_colors.dart';

class HomeScreenStyles {
  // appBarUpperTitleStyles styles
  static const TextStyle appBarUpperTitleStyles = TextStyle(
    color: AppColors.baseBlackColor,
    fontWeight: FontWeight.bold,
  );
//appBarBottomTitleStyles
  static const TextStyle appBarBottomTitleStyles = TextStyle(
    color: AppColors.baseDarkPinkColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    fontSize: 17,
  );
  //trendingProductNameStyle
  static const TextStyle trendingProductNameStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
//trendingProductModelStyle
  static const TextStyle trendingProductModelStyle = TextStyle(
    fontSize: 14,
    color: AppColors.baseDarkPinkColor,
  );
  //trendingProductPriceStyle
  static const TextStyle trendingProductPriceStyle = TextStyle(
    fontSize: 18,
    color: AppColors.baseWhiteColor,
  );
}
