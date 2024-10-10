import 'package:snood/features/login/cubit/cubit.dart';
import 'package:snood/features/login/cubit/state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snood/core/utils/app_colors.dart';
import '../../../core/utils/style_text.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isOtpValid = false; // Track whether OTP is valid

  @override
  void initState() {
    super.initState();
    context.read<LoginCubit>().startCountdown();
    context.read<LoginCubit>().otpController = TextEditingController();
    context.read<LoginCubit>().otpController.addListener(() {
      setState(() {
        isOtpValid = context.read<LoginCubit>().otpController.text.length == 6;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.all(20.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "verification_code".tr(),
                            style: TextStyles.size22FontWidgetBoldBlue
                                .copyWith(fontSize: 20.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 100.h),
                      _buildVerificationText(),
                      SizedBox(height: 10.h),
                      _buildOtpTextField(cubit),
                      SizedBox(height: 20.h),
                      _buildVerifyButton(context, cubit, state),
                      SizedBox(height: 20.h),
                      _buildTimerAndResend(context),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildVerificationText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 270.w,
          child: Text(
            "text_verification_screen".tr(),
            style: TextStyles.size16FontWidgetRegularBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpTextField(LoginCubit cubit) {
    return PinCodeFields(
      obscureText: false,
      length: 6,
      controller: cubit.otpController,
      borderWidth: 0.0,
      fieldBackgroundColor: AppColors.blue.withOpacity(0.08),
      fieldHeight: 52.h,
      fieldWidth: 45.w,
      borderColor: AppColors.white,
      borderRadius: BorderRadius.zero,
      keyboardType: TextInputType.number,
      textStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black.withOpacity(0.2),
      ),
      onComplete: (String value) {},
    );
  }

  Widget _buildVerifyButton(
      BuildContext context, LoginCubit cubit, LoginState state) {
    return SizedBox(
      width: double.infinity,
      child: (state is VerificationLoadingState ||
          state is CompleteRegisterLoadingState ||
          state is LoginWithClientIdLoadingState)
          ? Center(
        child: CircularProgressIndicator(color: AppColors.blue),
      )
          : ElevatedButton(
        onPressed: isOtpValid // Button is only enabled if OTP is valid
            ? () {
          context.read<LoginCubit>().endTimer();
          cubit.verificationData(context);
        }
            : null, // Disable the button if OTP is not valid
        style: ElevatedButton.styleFrom(
          backgroundColor: isOtpValid
              ? AppColors.blue
              : AppColors.blue.withOpacity(0.5), // Change button color based on OTP validity
          padding: EdgeInsets.symmetric(vertical: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          "verify".tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTimerAndResend(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        String timerText = '';
        bool isResendAvailable = false;

        if (state is VerificationTimerRunning) {
          timerText = state.timerText;
        } else if (state is VerificationResendAvailable) {
          isResendAvailable = true;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "resend_text".tr(),
              style: TextStyles.size16FontWidgetBoldBlack,
            ),
            if (!isResendAvailable)
              Text(
                timerText,
                style: TextStyles.size40FontWidgetBoldBlack,
              ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isResendAvailable
                    ? () {
                  context.read<LoginCubit>().resendCode();
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: AppColors.orange.withOpacity(0.3),
                  backgroundColor: isResendAvailable
                      ? AppColors.orange
                      : AppColors.orange.withOpacity(0.5),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "resend_code".tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
