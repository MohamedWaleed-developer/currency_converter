import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'currency_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(milliseconds: 1800),
          () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const CurrencyScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F8FC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                color: const Color(0xffE8F0F8),
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.all(14.w),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'تحويله',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff172033),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Tahwila',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff475467),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Convert. Track. Go.',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xff667085),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}