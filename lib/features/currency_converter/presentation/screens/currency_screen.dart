import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/app_localizations.dart';
import '../cubit/currency_cubit.dart';
import '../cubit/currency_state.dart';
import '../widgets/amount_field.dart';
import '../widgets/convert_button.dart';
import '../widgets/currency_selector.dart';
import '../widgets/language_button.dart';
import '../widgets/result_card.dart';
import '../widgets/swap_button.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F7FB),
      body: Stack(
        children: [
          _BackgroundDecoration(),
          SafeArea(
            child: BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff3B82F6),
                    ),
                  );
                }

                if (state is CurrencyError) {
                  return _ErrorView(
                    message: state.message,
                    onRetry: () {
                      context.read<CurrencyCubit>().fetchCurrencies();
                    },
                  );
                }

                if (state is CurrencySuccess) {
                  return _CurrencyContent(
                    state: state,
                    amountController: amountController,
                  );
                }

                return Center(
                  child: Text(
                    AppLocalizations.of(context).preparing,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff172033),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencyContent extends StatelessWidget {
  final CurrencySuccess state;
  final TextEditingController amountController;

  const _CurrencyContent({
    required this.state,
    required this.amountController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<CurrencyCubit>();

    final hasResult =
        state.result != null &&
            state.fromCurrency != null &&
            state.toCurrency != null;

    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),
          SizedBox(height: 18.h),
          Text(
            l10n.currency,
            style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff172033),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            l10n.description,
            style: TextStyle(
              fontSize: 11.5.sp,
              color: Color(0xff667085),
            ),
          ),
          if (hasResult) ...[
            SizedBox(height: 14.h),
            ResultCard(
              result: state.result!.toStringAsFixed(2),
              fromCurrency: state.fromCurrency!.code,
              toCurrency: state.toCurrency!.code,
              rate: state.toCurrency!.rate /
                  state.fromCurrency!.rate,
            ),
          ],
          SizedBox(height: 14.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.amount,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff344054),
                    ),
                  ),
                  SizedBox(height: 7.h),
                  AmountField(
                    controller: amountController,
                  ),
                  SizedBox(height: 14.h),
                  CurrencySelector(
                    title: 'From',
                    selectedCurrency: state.fromCurrency,
                    currencies: state.currencies,
                    onChanged: cubit.selectFromCurrency,
                  ),
                  SizedBox(height: 7.h),
                  Center(
                    child: SwapButton(
                      onPressed: cubit.swapCurrencies,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  CurrencySelector(
                    title: 'To',
                    selectedCurrency: state.toCurrency,
                    currencies: state.currencies,
                    onChanged: cubit.selectToCurrency,
                  ),
                  SizedBox(height: 15.h),
                  ConvertButton(
                    onPressed: () {
                      cubit.convert(amountController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 12,
              sigmaY: 12,
            ),
            child: Container(
              width: 48.w,
              height: 48.w,
              padding: EdgeInsets.all(7.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.appName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff172033),
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                l10n.tagline,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.5.sp,
                  color: Color(0xff667085),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        LanguageButton(),
      ],
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -70.h,
              right: -45.w,
              child: _BlurCircle(
                size: 190.w,
                color: Color(0xff3B82F6).withValues(alpha: 0.10),
              ),
            ),
            Positioned(
              top: 270.h,
              left: -80.w,
              child: _BlurCircle(
                size: 170.w,
                color: Color(0xff60A5FA).withValues(alpha: 0.07),
              ),
            ),
            Positioned(
              bottom: -80.h,
              right: -60.w,
              child: _BlurCircle(
                size: 180.w,
                color: Color(0xff2563EB).withValues(alpha: 0.06),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlurCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 35,
          sigmaY: 35,
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: Color(0xffFEECEC),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 30.sp,
                color: Color(0xffEF4444),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              l10n.get(message),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff344054),
              ),
            ),
            SizedBox(height: 14.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color(0xff3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 22.w,
                  vertical: 11.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                l10n.retry,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}