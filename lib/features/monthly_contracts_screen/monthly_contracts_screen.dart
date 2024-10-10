import 'package:snood/core/utils/app_colors.dart';
import 'package:snood/core/widgets/shared_appbar.dart';
import 'package:snood/features/monthly_contracts_screen/widgets/monthly_contract_request_details_screen.dart';
import 'package:snood/features/monthly_contracts_screen/widgets/monthly_contracts-widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/assets_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'widgets/monthly_contracts_card.dart';
import 'widgets/pagination_widget.dart'; // Import your pagination widget

class MonthlyContractsScreen extends StatefulWidget {
  const MonthlyContractsScreen({super.key});

  @override
  State<MonthlyContractsScreen> createState() => _MonthlyContractsScreenState();
}

class _MonthlyContractsScreenState extends State<MonthlyContractsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MonthlyContractsCubit>().getMonthlyContract();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MonthlyContractsCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: SharedAppbar(text: "monthly_contracts".tr()),
            ),
            SizedBox(height: 20.h),
            BlocBuilder<MonthlyContractsCubit, MonthlyContractsState>(
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
                            MonthlyContractsWidget(
                              selectedIndexOrder: 0,
                              text: "pending".tr(),
                              cubit: cubit,
                            ),
                            SizedBox(width: 10.w),
                            MonthlyContractsWidget(
                              selectedIndexOrder: 1,
                              text: "in_progress".tr(),
                              cubit: cubit,
                            ),
                            SizedBox(width: 10.w),
                            MonthlyContractsWidget(
                              selectedIndexOrder: 2,
                              text: "archived".tr(),
                              cubit: cubit,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      if (state is GetMonthlyContractLoadingState)
                        Center(child: CircularProgressIndicator(color: AppColors.blue,))
                      else if (state is GetMonthlyContractSuccessState) ...[
                        if (cubit.monthlyContractModel?.data?.items?.isEmpty ?? true)
                          _buildNoDataWidget()
                        else
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: cubit.monthlyContractModel?.data?.items?.length ?? 0,
                              itemBuilder: (context, index) {
                                var item = cubit.monthlyContractModel!.data!.items![index];
                                return MonthlyContractsCard(
                                  item: item,
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyContractRequestDetailsScreen(
                                      inProgress: item.statusClient == "in_progress" ? true : false,
                                      isArchive: item.statusClient == "archived" ? true : false,
                                      item:
                                    cubit.monthlyContractModel!.data!.items![index],
                                      onPressed: () {
                                        cubit.archiveMonthlyContract(itemId: item.id.toString(),context: context);
                                      }
                                      ,),));
                                  },
                                );
                              },
                            ),
                          ),
                        // Pagination controls
                        SizedBox(height: 10.h),
                        if (cubit.monthlyContractModel?.data?.items?.isNotEmpty ?? false)
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
