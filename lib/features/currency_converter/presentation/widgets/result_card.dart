import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/currency_flags.dart';
import '../../../../core/localization/app_localizations.dart';

class ResultCard extends StatelessWidget {
  final String result;
  final String fromCurrency;
  final String toCurrency;
  final double? rate;

  const ResultCard({
    super.key,
    required this.result,
    required this.fromCurrency,
    required this.toCurrency,
    this.rate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffFFFFFF),
            Color(0xffF3F7FF),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.9),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff172033).withValues(alpha: 0.08),
            blurRadius: 22.r,
            offset: Offset(0, 9.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Color(0xffE8F1FF),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 19.sp,
                  color: Color(0xff3B82F6),
                ),
              ),
              SizedBox(width: 9.w),
              Expanded(
                child: Text(
                  l10n.conversionResult,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff667085),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 9.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffEAF1FF),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'RATE',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3B82F6),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            result,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 31.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: Color(0xff172033),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            toCurrency,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff3B82F6),
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: Color(0xffE4EAF2),
              ),
            ),
            child: Row(
              children: [
                Text(
                  CurrencyFlags.getFlag(fromCurrency),
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(width: 7.w),
                Text(
                  fromCurrency,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff172033),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(0xffD0D5DD),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 17.sp,
                            color: Color(0xff98A2B3),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xffD0D5DD),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  CurrencyFlags.getFlag(toCurrency),
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(width: 7.w),
                Text(
                  toCurrency,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff172033),
                  ),
                ),
              ],
            ),
          ),
          if (rate != null) ...[
            SizedBox(height: 13.h),
            Row(
              children: [
                Icon(
                  Icons.swap_horiz_rounded,
                  size: 18.sp,
                  color: Color(0xff3B82F6),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    '${l10n.exchangeRate}: 1 $fromCurrency = '
                        '${rate!.toStringAsFixed(4)} $toCurrency',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: Color(0xff667085),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}