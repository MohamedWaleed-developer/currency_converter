import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/currency_flags.dart';
import '../../../../core/constants/currency_names.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../domain/entities/currency.dart';

class CurrencyPicker extends StatefulWidget {
  final List<Currency> currencies;
  final Currency? selectedCurrency;
  final String title;
  final ValueChanged<Currency> onChanged;

  const CurrencyPicker({
    super.key,
    required this.currencies,
    required this.selectedCurrency,
    required this.title,
    required this.onChanged,
  });

  @override
  State<CurrencyPicker> createState() => _CurrencyPickerState();
}

class _CurrencyPickerState extends State<CurrencyPicker> {
  final TextEditingController searchController = TextEditingController();

  late List<Currency> filteredCurrencies;

  @override
  void initState() {
    super.initState();

    filteredCurrencies = List.from(widget.currencies);

    searchController.addListener(_filterCurrencies);
  }

  void _filterCurrencies() {
    final query = searchController.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredCurrencies = List.from(widget.currencies);
        return;
      }

      filteredCurrencies = widget.currencies.where((currency) {
        final code = currency.code.toLowerCase();
        final arabicName =
        CurrencyNames.getArabicName(currency.code).toLowerCase();

        return code.contains(query) || arabicName.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController
      ..removeListener(_filterCurrencies)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      height: 0.82.sh,
      decoration: BoxDecoration(
        color: Color(0xffF8FAFC),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            width: 42.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Color(0xffD0D5DD),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              18.h,
              20.w,
              14.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${l10n.selectCurrency} ${widget.title}',
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff172033),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: 23.sp,
                    color: Color(0xff667085),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              controller: searchController,
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff172033),
              ),
              decoration: InputDecoration(
                hintText: l10n.searchCurrency,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff98A2B3),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 22.sp,
                  color: Color(0xff667085),
                ),
                filled: true,
                fillColor: Color(0xffEEF2F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: filteredCurrencies.isEmpty
                ? Center(
              child: Text(
                l10n.noCurrencyFound,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff667085),
                ),
              ),
            )
                : ListView.separated(
              padding: EdgeInsets.fromLTRB(
                20.w,
                4.h,
                20.w,
                24.h,
              ),
              itemCount: filteredCurrencies.length,
              separatorBuilder: (_, __) {
                return SizedBox(height: 8.h);
              },
              itemBuilder: (context, index) {
                final currency = filteredCurrencies[index];

                final isSelected =
                    currency.code ==
                        widget.selectedCurrency?.code;

                return Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(17.r),
                    onTap: () {
                      widget.onChanged(currency);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xffE8F0F8),
                              borderRadius:
                              BorderRadius.circular(15.r),
                            ),
                            child: Text(
                              CurrencyFlags.getFlag(currency.code),
                              style: TextStyle(
                                fontSize: 25.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  CurrencyNames.getArabicName(
                                    currency.code,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff172033),
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  currency.code,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xff667085),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle_rounded,
                              size: 23.sp,
                              color: Color(0xff3B82F6),
                            ),
                        ],
                      ),
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