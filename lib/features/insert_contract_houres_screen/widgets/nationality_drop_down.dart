import 'package:snood/core/models/get_hourly__package_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';

class NationalityDropdownWidget extends StatefulWidget {
  final List<AvailableCountry> countries;
  final Function(String?) onChanged;

  const NationalityDropdownWidget({
    super.key,
    required this.countries,
    required this.onChanged,
  });

  @override
  _NationalityDropdownWidgetState createState() => _NationalityDropdownWidgetState();
}

class _NationalityDropdownWidgetState extends State<NationalityDropdownWidget> {
  String? selectedNationality;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.0.sp),
      ),
      child: DropdownButton<String>(
        value: selectedNationality, // القيمة الحالية المختارة
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: AppColors.orange),
        iconSize: 24.sp,
        hint: Text("nationality".tr()), // النص الذي يظهر إذا لم يتم اختيار شيء
        elevation: 16,
        style: TextStyle(color: AppColors.black, fontSize: 16.sp),
        underline: Container(),
        onChanged: (String? newValue) {
          setState(() {
            selectedNationality = newValue; // تحديث القيمة المختارة
          });
          widget.onChanged(newValue); // استدعاء الدالة عند التغيير
        },
        items: widget.countries.map<DropdownMenuItem<String>>((AvailableCountry country) {
          return DropdownMenuItem<String>(
            value: country.name,
            child: Text(
              country.name ?? 'Unknown Country', // عرض اسم الدولة المختارة
            ),
          );
        }).toList(),
      ),
    );
  }
}
