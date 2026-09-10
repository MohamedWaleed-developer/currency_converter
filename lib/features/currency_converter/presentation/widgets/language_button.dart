import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/language_cubit.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final language = context.watch<LanguageCubit>().state;

    return PopupMenuButton<String>(
      onSelected: (value) {
        context.read<LanguageCubit>().changeLanguage(value);
      },
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'ar',
          child: Row(
            children: [
              Text(
                '🇪🇬',
                style: TextStyle(fontSize: 18.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  l10n.arabic,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff172033),
                  ),
                ),
              ),
              if (language == 'ar')
                Icon(
                  Icons.check_rounded,
                  size: 20.sp,
                  color: Color(0xff3B82F6),
                ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'en',
          child: Row(
            children: [
              Text(
                '🇺🇸',
                style: TextStyle(fontSize: 18.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  l10n.english,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff172033),
                  ),
                ),
              ),
              if (language == 'en')
                Icon(
                  Icons.check_rounded,
                  size: 20.sp,
                  color: Color(0xff3B82F6),
                ),
            ],
          ),
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: Color(0xffD9E2EC),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language_rounded,
              size: 19.sp,
              color: Color(0xff3B82F6),
            ),
            SizedBox(width: 6.w),
            Text(
              language.toUpperCase(),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xff172033),
              ),
            ),
            SizedBox(width: 2.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18.sp,
              color: Color(0xff667085),
            ),
          ],
        ),
      ),
    );
  }
}