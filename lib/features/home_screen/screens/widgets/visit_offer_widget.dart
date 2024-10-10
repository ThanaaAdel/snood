import 'package:snood/config/routes/app_routes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/login_with_client_id_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/style_text.dart';
import 'container_widget_home.dart';

class VisitsOffersWidget extends StatelessWidget {
  const VisitsOffersWidget({
    super.key, required this.loginWithClientIdModel,
  });
final LoginWithClientIdModel loginWithClientIdModel;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: 20.w,right: 20.w),
          child: AutoSizeText("visits_offers".tr(),style: TextStyles.size20FontWidgetBoldOrange),
        ),
         Row(
          children: [
            ContainerWidgetHome(
              onPressed: () {
                Navigator.pushNamed(context, Routes.contractHoursRoute,arguments: loginWithClientIdModel);
              },
              text: "contract_hours".tr(),image: ImageAssets.contractMonthIcon,),
            ContainerWidgetHome(
              onPressed: () {
                Navigator.pushNamed(context, Routes.contractMonthRoute,arguments: loginWithClientIdModel);
              },
              text: "contract_month".tr(),image: ImageAssets.contractHourIcon,),

          ],
        )

      ],);
  }
}