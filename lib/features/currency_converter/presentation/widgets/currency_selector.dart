import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/currency_flags.dart';
import '../../../../core/constants/currency_names.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../domain/entities/currency.dart';
import 'currency_picker.dart';

class CurrencySelector extends StatelessWidget {
  final Currency? selectedCurrency;
  final List<Currency> currencies;
  final String title;
  final ValueChanged<Currency> onChanged;

  const CurrencySelector({
    super.key,
    required this.selectedCurrency,
    required this.currencies,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final currency = selectedCurrency;
    final l10n = AppLocalizations.of(context);

    final localizedTitle = title == 'From'
        ? l10n.from
        : title == 'To'
        ? l10n.to
        : title;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => CurrencyPicker(
            currencies: currencies,
            selectedCurrency: selectedCurrency,
            title: localizedTitle,
            onChanged: onChanged,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Color(0xffD9E2EC),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff172033).withValues(alpha: 0.05),
              blurRadius: 14.r,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffE8F0F8),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: currency == null
                  ? Text(
                '--',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff172033),
                ),
              )
                  : Text(
                CurrencyFlags.getFlag(currency.code),
                style: TextStyle(fontSize: 25.sp),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizedTitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xff667085),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    currency == null
                        ? l10n.selectCurrency
                        : CurrencyNames.getArabicName(currency.code),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff172033),
                    ),
                  ),
                ],
              ),
            ),
            if (currency != null)
              Text(
                currency.code,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff667085),
                ),
              ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 26.sp,
              color: Color(0xff475467),
            ),
          ],
        ),
      ),
    );
  }
}