import 'package:snood/core/utils/app_colors.dart';
import 'package:snood/features/insert_professional_labor.screen/screens/widgets/profictionail_labor_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/appbar_widget_with_screens.dart';
import '../cubit/profissional_labor_cubit.dart';
import '../cubit/profissional_labor_state.dart';

class InsertProfessionalLaborScreen extends StatefulWidget {
  const InsertProfessionalLaborScreen({super.key, required this.clientId});
final String clientId;
  @override
  State<InsertProfessionalLaborScreen> createState() => _InsertProfessionalEmploymentScreenState();
}

class _InsertProfessionalEmploymentScreenState extends State<InsertProfessionalLaborScreen> {
  @override
  initState() {
    super.initState();
    context.read<InsertProfessionalLaborCubit>().getOccupationsData(clientId:widget.clientId);
    context.read<InsertProfessionalLaborCubit>().getCountryData();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<InsertProfessionalLaborCubit>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(10.0.sp),
        child: Column(
          children: [
            AppbarWidgetWithScreens(
              title: "professional_employment".tr(),
              description: "please_select_a_profession".tr(),
            ),
            SizedBox(
              height: 20.h,
            ),

            Expanded(
              child: BlocBuilder<InsertProfessionalLaborCubit,InsertProfissionalLaborState>(
                builder: (context,state) {
                  return (state is GetCountriesLoadingState ||state is GetOccupationsLoadingState || cubit.occupationsData == null || cubit.getCountriesModel == null)?
                  const Center(child: CircularProgressIndicator(),):
                  ListView.builder(
                            itemBuilder: (context, index) =>
                             ProfessionalLaborContainer(
                               cubit:cubit.occupationsData!.data![index],
                              onTap: () {
                                Navigator.pushNamed(context, Routes.enterDataProfessionalEmploymentRoute,
                                    arguments: cubit.occupationsData?.data?[index].id ?? '');
                              },
                            ),
                            itemCount: cubit.occupationsData!.data!.length,
                  );
                }
              ),
            )

          ],
        ),
      ),
    ));
  }
}
