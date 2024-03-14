import 'package:flutter/cupertino.dart';

import '../appColors/app_colors.dart';

class DetailScreenStyles {
  // companyTitleStyle
  static const TextStyle companyTitleStyle = TextStyle(
    color: AppColors.baseBlackColor,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
//productModelStyle
  static const TextStyle productModelStyle = TextStyle(
    color: AppColors.baseDarkPinkColor,
  );
//productPriceStyle

  static const TextStyle productPriceStyle = TextStyle(
    color: AppColors.baseBlackColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

//productOldPriceStyle

  static const TextStyle productOldPriceStyle = TextStyle(
    color: AppColors.baseGrey60Color,
    fontSize: 16,
    decoration: TextDecoration.lineThrough,
    fontWeight: FontWeight.w600,
  );

  //productFopDownValueStyle
  static const TextStyle productDropDownValueStyle = TextStyle(
    color: AppColors.baseBlackColor,
    fontSize: 12,
  );

//buttonTextStyle
  static const TextStyle buttonTextStyle = TextStyle(
    color: AppColors.baseWhiteColor,
    fontSize: 20,
  );
//descriptionTextStyle
  static const TextStyle descriptionTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.baseBlackColor,
  );
  //sizeGuideTextStyle
  static const TextStyle sizeGuideTextStyle = TextStyle(
    fontSize: 18.0,
    color: AppColors.baseBlackColor,
  );
//yottamolesTextStyle
  static const TextStyle youmayalsolikeTextStyle = TextStyle(
    fontSize: 18.0,
    color: AppColors.baseBlackColor,
  );

  //showAllTextStyle
  static const TextStyle showAllTextStyle = TextStyle(
    fontSize: 18.0,
    color: AppColors.baseDarkPinkColor,
  );
}
