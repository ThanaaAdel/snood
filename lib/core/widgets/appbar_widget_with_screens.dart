import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/style_text.dart';

class AppbarWidgetWithScreens extends StatelessWidget {
  const AppbarWidgetWithScreens({
    super.key, required this.title, required this.description, this.isHaveArrow,
  });
final String title,description;
final bool? isHaveArrow;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child:Directionality.of(context) == TextDirection.rtl ?  Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orange),
                child: Icon(Icons.arrow_back_rounded, color: AppColors.white),
              ):
              Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orange),
                child: Icon(Icons.arrow_back, color: AppColors.white),
              )
          ),
          SizedBox(width: 10.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.size22FontWidgetBoldBlue.copyWith(fontSize: 20.sp)
              ),

              SizedBox(

                child: Text(
                  description,
                  style: TextStyles.size13FontWidgetSemiBoldBlackWithOpacity6.copyWith(fontSize: 10.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}