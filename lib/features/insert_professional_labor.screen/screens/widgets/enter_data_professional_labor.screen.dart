import 'package:snood/core/utils/app_colors.dart';
import 'package:snood/core/widgets/button_widget.dart';
import 'package:snood/core/widgets/shared_text_filed.dart';
import 'package:snood/features/insert_professional_labor.screen/cubit/profissional_labor_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/appbar_widget_with_screens.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../cubit/profissional_labor_cubit.dart';

class EnterDataProfessionalLaborScreen extends StatefulWidget {
  const EnterDataProfessionalLaborScreen({super.key, required this.accId});
  final String accId;

  @override
  State<EnterDataProfessionalLaborScreen> createState() =>
      _EnterDataProfessionalEmploymentScreenState();
}

class _EnterDataProfessionalEmploymentScreenState
    extends State<EnterDataProfessionalLaborScreen> {
  String? visaNumber;

  int? selectedNationalityId;

  @override
  void initState() {
    super.initState();
    context.read<InsertProfessionalLaborCubit>().getExperiencesData();
    context.read<InsertProfessionalLaborCubit>().getCountryData();
    context.read<InsertProfessionalLaborCubit>().getReligionData();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<InsertProfessionalLaborCubit>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: BlocBuilder<InsertProfessionalLaborCubit,
              InsertProfissionalLaborState>(
            builder: (context, state) {
              if (state is GetExperiencesLoadingState ||
                  state is GetCountriesLoadingState ||
                  cubit.experanceModel == null ||
                  cubit.getCountriesModel == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppbarWidgetWithScreens(
                        title: "professional_employment".tr(),
                        description:
                        "please_enter_the_following_information".tr(),
                      ),
                      SizedBox(height: 20.h),
                      CustomDropdownWidget(
                        label: "nationality".tr(),
                        onChanged: (String? newValue) {
                          var selectedNationality = cubit.getCountriesModel?.data?.firstWhere(
                                (country) => country.name == newValue,
                             // Handle null case
                          );
                          setState(() {
                            selectedNationalityId = int.tryParse(selectedNationality?.id ?? '');
                            print("selectedNationalityId: $selectedNationalityId");
                          });
                        },
                        items: cubit.getCountriesModel != null && cubit.getCountriesModel!.data!.isNotEmpty
                            ? cubit.getCountriesModel!.data!.map((e) => e.name!).toList()
                            : [],
                      ),
                      SizedBox(height: 20.h),
                      CustomDropdownWidget(
                        label: "experience".tr(),
                        onChanged: (value) {
                          setState(() {
                            cubit.experanceName = value;
                            print("ExperanceName: ${cubit.experanceName}");
                          });
                        },
                        items: cubit.experanceModel?.data?.map((e) => e.name!).toList() ?? [],
                      ),
                      SizedBox(height: 20.h),
                      CustomDropdownWidget(
                        label: "employment_entity".tr(),
                        onChanged: (value) {
                          setState(() {
                            cubit.religionName = value;
                            print("religionName: ${cubit.religionName}");
                          });
                        },
                        items: cubit.religionsModel?.data?.map((e) => e.name!).toList() ?? [],
                      ),
                      SizedBox(height: 20.h),
                      SharedTextFiled(
                        keyboardType: TextInputType.number,
                        hintText: "visa_number".tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_visa_number'.tr();
                          }
                          if (value.length != 10) {
                            return 'visa_number_must_be_10_digits'.tr(); // رسالة الخطأ إذا لم يكن الطول 10 أرقام
                          }
                          return null; // إذا كان التحقق صحيحاً، لا يوجد خطأ
                        },
                        onSaved: (value) {
                          visaNumber = value;
                        },
                      ),
                      SizedBox(height: 20.h),
                      BlocBuilder<InsertProfessionalLaborCubit,
                          InsertProfissionalLaborState>(
                        builder: (context, state) {
                          return (state is InsertProfissionalEmploymentLoadingState)
                              ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.blue,
                              ))
                              : ButtonWidget(
                            onPressed: () {
                              if (cubit.formKey.currentState?.validate() ?? false) {
                                cubit.formKey.currentState?.save();
                                cubit.insertProfissionalEmploymentData(
                                  visaNo: visaNumber ?? '',
                                  countryId: selectedNationalityId?.toString() ?? '',
                                  context: context,
                                  occId: widget.accId,
                                );
                              }
                            },
                            textButton: "order_now".tr(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
