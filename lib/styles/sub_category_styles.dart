import 'package:flutter/cupertino.dart';

import '../appColors/app_colors.dart';

class SubCategoryStyles {
  // subCategoryTitleStyle
  static const TextStyle subCategoryTitleStyle = TextStyle(
    color: AppColors.baseBlackColor,
    fontSize: 34,
    fontWeight: FontWeight.bold,
  );

//subCategoryProductItemStyle
  static const TextStyle subCategoryProductItemStyle = TextStyle(
    color: AppColors.baseGrey60Color,
  );

  //subCategoryProductItemStyle
  static const TextStyle subCategoryModelNameStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.baseGrey70Color,
  );
}
