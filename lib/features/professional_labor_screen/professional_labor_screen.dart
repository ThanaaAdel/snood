import 'package:snood/core/utils/app_colors.dart';
import 'package:snood/core/widgets/shared_appbar.dart';
import 'package:snood/features/professional_labor_screen/widgets/professional_labor_contracts_card.dart';
import 'package:snood/features/professional_labor_screen/widgets/professional_labor_request_details_screen.dart';
import 'package:snood/features/professional_labor_screen/widgets/professional_labor_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/assets_manager.dart';
import '../hourly_contracts_screen/widgets/pagination_widget.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ProfessionalLaborScreen extends StatefulWidget {
  const ProfessionalLaborScreen({super.key});

  @override
  State<ProfessionalLaborScreen> createState() => _ProfessionalLaborScreenState();
}

class _ProfessionalLaborScreenState extends State<ProfessionalLaborScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfessionalLaborCubit>().getProfessionalEmployment();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfessionalLaborCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: SharedAppbar(text: "professional_employment".tr()),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<ProfessionalLaborCubit, ProfessionalLaborState>(
              builder: (context, state) {
                return Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProfessionalLaborWidget(
                              selectedIndexOrder: 0,
                              text: "pending".tr(),
                              cubit: cubit,
                            ),
                            SizedBox(width: 10.w),
                            ProfessionalLaborWidget(
                              selectedIndexOrder: 1,
                              text: "in_progress".tr(),
                              cubit: cubit,
                            ),
                            SizedBox(width: 10.w),
                            ProfessionalLaborWidget(
                              selectedIndexOrder: 2,
                              text: "archived".tr(),
                              cubit: cubit,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      if (state is GetProfessionalEmploymentLoadingState)
                        Center(child: CircularProgressIndicator(color: AppColors.blue,))
                      else if (state is GetProfessionalEmploymentSuccessState) ...[
                        if (cubit.professionalEmploymentModel?.data?.items?.isEmpty ?? true)
                          _buildNoDataWidget()
                        else
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: cubit.professionalEmploymentModel?.data?.items?.length ?? 0,
                              itemBuilder: (context, index) {
                                var item = cubit.professionalEmploymentModel!.data!.items![index];
                                return ProfessionalLaborCard(
                                  item: item,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        ProfessionalLaborRequestDetailsScreen(
                                          inProgress: item.statusClient == "in_progress" ? true : false,
                                      isArchive: item.statusClient == "archived" ? true : false,
                                      item:
                                    cubit.professionalEmploymentModel!.data!.items![index],
                                      onPressed: () {
                                        cubit.archiveProfessionalEmployment(itemId: item.id.toString(),context: context);
                                      }
                                      ,),));
                                  },
                                );
                              },
                            ),
                          ),
                        // Pagination controls
                        SizedBox(height: 10.h),
                        if (cubit.professionalEmploymentModel?.data?.items?.isNotEmpty ?? false)
                        PaginationWidget(
                          currentPage: cubit.pageNo,
                          totalPages: cubit.totalPages,
                          onPageChanged: (page) {
                            cubit.changePage(page); // This will call the function to change pages
                          },
                        ),
                      ] else
                        Center(child: Text("no_data".tr())),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // No data widget
  Widget _buildNoDataWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100.h),
        Image.asset(ImageAssets.noData, width: 200.w, height: 200.h),
        SizedBox(height: 20.h),
        Text(
          "no_data".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: AppColors.blue,
          ),
        ),
      ],
    );
  }
}
