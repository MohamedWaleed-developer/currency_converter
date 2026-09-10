import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/app_localizations.dart';

class AmountField extends StatelessWidget {
  final TextEditingController controller;

  const AmountField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xff172033),
      ),
      decoration: InputDecoration(
        hintText: l10n.enterAmount,
        hintStyle: TextStyle(
          color: Color(0xff98A2B3),
          fontSize: 16.sp,
        ),
        prefixIcon: Icon(
          Icons.attach_money_rounded,
          size: 24.sp,
          color: Color(0xff3B82F6),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide(
            color: Color(0xffD9E2EC),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide(
            color: Color(0xffD9E2EC),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.r),
          borderSide: BorderSide(
            color: Color(0xff3B82F6),
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 18.h,
        ),
      ),
    );
  }
}