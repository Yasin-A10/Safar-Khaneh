// import 'package:flutter/material.dart';
// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
// import 'package:table_calendar/table_calendar.dart';

// class ReservedDate {
//   final Jalali startDate;
//   final Jalali endDate;
//   ReservedDate({required this.startDate, required this.endDate});
// }

// class PersianTableCalendar extends StatefulWidget {
//   const PersianTableCalendar({super.key});

//   @override
//   State<PersianTableCalendar> createState() => _PersianTableCalendarState();
// }

// class _PersianTableCalendarState extends State<PersianTableCalendar> {
//   Jalali? rangeStart;
//   Jalali? rangeEnd;

//   final List<ReservedDate> reservedDates = [
//     ReservedDate(startDate: Jalali(1404, 4, 10), endDate: Jalali(1404, 4, 13)),
//     ReservedDate(startDate: Jalali(1404, 4, 16), endDate: Jalali(1404, 4, 17)),
//   ];

//   DateTime focusedDay = DateTime.now();

//   // لیست نام ماه‌های فارسی
//   static const List<String> persianMonths = [
//     'فروردین',
//     'اردیبهشت',
//     'خرداد',
//     'تیر',
//     'مرداد',
//     'شهریور',
//     'مهر',
//     'آبان',
//     'آذر',
//     'دی',
//     'بهمن',
//     'اسفند',
//   ];

//   // تابع ایمن برای اضافه کردن ماه
//   Jalali safeAddMonths(Jalali date, int monthsToAdd) {
//     int year = date.year;
//     int month = date.month + monthsToAdd;
//     int day = date.day;

//     while (month > 12) {
//       month -= 12;
//       year += 1;
//     }
//     while (month < 1) {
//       month += 12;
//       year -= 1;
//     }

//     final maxDay = Jalali(year, month, 1).monthLength;

//     if (day > maxDay) {
//       day = maxDay;
//     }

//     return Jalali(year, month, day);
//   }

//   // تبدیل عدد انگلیسی به فارسی
//   String toPersianNumber(int number) {
//     const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
//     const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
//     String s = number.toString();
//     for (int i = 0; i < english.length; i++) {
//       s = s.replaceAll(english[i], persian[i]);
//     }
//     return s;
//   }

//   // بررسی اینکه آیا روز رزرو شده هست یا خیر
//   bool _isReserved(Jalali date) {
//     for (var reserved in reservedDates) {
//       if (!date.isBefore(reserved.startDate) &&
//           !date.isAfter(reserved.endDate)) {
//         return true;
//       }
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final focusedJalali = Gregorian.fromDateTime(focusedDay).toJalali();

//     final firstDay = Jalali(focusedJalali.year, focusedJalali.month, 1);
//     final lastDay = firstDay.addMonths(1).addDays(-1);

//     // محدودیت ها: ۲ ماه قبل و ۲ ماه بعد از ماه جاری (الان)
//     final Jalali todayJalali = Jalali.now();
//     final Jalali minMonth = safeAddMonths(todayJalali, 0);
//     final Jalali maxMonth = safeAddMonths(todayJalali, 2);

//     return Column(
//       children: [
//         // هدر با دکمه‌های تغییر ماه و نمایش ماه و سال فارسی
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.chevron_left),
//                 onPressed: () {
//                   final prevMonth = safeAddMonths(focusedJalali, -1);
//                   // فقط اگر قبلی در محدوده باشه اجازه بده
//                   if (!prevMonth.isBefore(minMonth)) {
//                     setState(() {
//                       focusedDay = prevMonth.toDateTime();
//                     });
//                   }
//                 },
//               ),
//               Text(
//                 '${persianMonths[focusedJalali.month - 1]} ${toPersianNumber(focusedJalali.year)}',
//                 style: const TextStyle(
//                   fontFamily: 'Vazir',
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.chevron_right),
//                 onPressed: () {
//                   final nextMonth = safeAddMonths(focusedJalali, 1);
//                   // فقط اگر بعدی در محدوده باشه اجازه بده
//                   if (!nextMonth.isAfter(maxMonth)) {
//                     setState(() {
//                       focusedDay = nextMonth.toDateTime();
//                     });
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),

//         TableCalendar(
//           locale: 'fa_IR',
//           firstDay: firstDay.toDateTime(),
//           lastDay: lastDay.toDateTime(),
//           focusedDay: focusedDay,
//           rangeStartDay: rangeStart?.toDateTime(),
//           rangeEndDay: rangeEnd?.toDateTime(),
//           calendarFormat: CalendarFormat.month,
//           headerVisible: false, // هدر پیش‌فرض تقویم را مخفی می‌کنیم
//           availableCalendarFormats: const {CalendarFormat.month: 'ماهانه'},
//           calendarStyle: CalendarStyle(
//             defaultTextStyle: const TextStyle(fontFamily: 'Vazir'),
//             rangeHighlightColor: Colors.teal.shade100,
//             todayTextStyle: const TextStyle(color: Colors.white),
//             todayDecoration: const BoxDecoration(
//               color: Colors.teal,
//               shape: BoxShape.circle,
//             ),
//           ),
//           calendarBuilders: CalendarBuilders(
//             defaultBuilder: (context, day, focusedDay) {
//               final jDay = Gregorian.fromDateTime(day).toJalali();
//               final reserved = _isReserved(jDay);

//               return Center(
//                 child: Text(
//                   toPersianNumber(jDay.day),
//                   style: TextStyle(
//                     color: reserved ? Colors.red : Colors.black,
//                     fontWeight: reserved ? FontWeight.bold : FontWeight.normal,
//                   ),
//                 ),
//               );
//             },
//           ),
//           onRangeSelected: (start, end, focused) {
//             setState(() {
//               rangeStart =
//                   start != null
//                       ? Gregorian.fromDateTime(start).toJalali()
//                       : null;
//               rangeEnd =
//                   end != null ? Gregorian.fromDateTime(end).toJalali() : null;
//               focusedDay = focused;
//             });
//           },
//           onDaySelected: (_, __) {}, // غیرفعال کردن انتخاب تکی
//           rangeSelectionMode: RangeSelectionMode.enforced,
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
// import 'package:safar_khaneh/core/constants/colors.dart';
// import 'package:safar_khaneh/data/models/reserve_model.dart';
// import 'package:table_calendar/table_calendar.dart';

// class PersianTableCalendar extends StatefulWidget {
//   const PersianTableCalendar({super.key});

//   @override
//   State<PersianTableCalendar> createState() => _PersianTableCalendarState();
// }

// class _PersianTableCalendarState extends State<PersianTableCalendar> {
//   Jalali? rangeStart;
//   Jalali? rangeEnd;

//   final List<ReservedDate> reservedDates = [
//     ReservedDate(startDate: Jalali(1404, 4, 10), endDate: Jalali(1404, 4, 13)),
//     ReservedDate(startDate: Jalali(1404, 4, 16), endDate: Jalali(1404, 4, 17)),
//   ];

//   DateTime focusedDay = DateTime.now();

//   // لیست نام ماه‌های فارسی
//   static const List<String> persianMonths = [
//     'فروردین',
//     'اردیبهشت',
//     'خرداد',
//     'تیر',
//     'مرداد',
//     'شهریور',
//     'مهر',
//     'آبان',
//     'آذر',
//     'دی',
//     'بهمن',
//     'اسفند',
//   ];

//   Jalali safeAddMonths(Jalali date, int monthsToAdd) {
//     int year = date.year;
//     int month = date.month + monthsToAdd;
//     int day = date.day;

//     while (month > 12) {
//       month -= 12;
//       year += 1;
//     }
//     while (month < 1) {
//       month += 12;
//       year -= 1;
//     }

//     final maxDay = Jalali(year, month, 1).monthLength;

//     if (day > maxDay) {
//       day = maxDay;
//     }

//     return Jalali(year, month, day);
//   }

//   String toPersianNumber(int number) {
//     const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
//     const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
//     String s = number.toString();
//     for (int i = 0; i < english.length; i++) {
//       s = s.replaceAll(english[i], persian[i]);
//     }
//     return s;
//   }

//   bool _isReserved(Jalali date) {
//     for (var reserved in reservedDates) {
//       if (!date.isBefore(reserved.startDate) &&
//           !date.isAfter(reserved.endDate)) {
//         return true;
//       }
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final focusedJalali = Gregorian.fromDateTime(focusedDay).toJalali();

//     final firstDay = Jalali(focusedJalali.year, focusedJalali.month, 1);
//     final lastDay = firstDay.addMonths(1).addDays(-1);

//     final Jalali todayJalali = Jalali.now();
//     final Jalali minMonth = safeAddMonths(todayJalali, 0);
//     final Jalali maxMonth = safeAddMonths(todayJalali, 2);

//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: const Icon(Iconsax.arrow_circle_right),
//                 onPressed: () {
//                   final prevMonth = safeAddMonths(focusedJalali, -1);
//                   if (!prevMonth.isBefore(minMonth)) {
//                     setState(() {
//                       focusedDay = prevMonth.toDateTime();
//                     });
//                   }
//                 },
//               ),
//               Text(
//                 '${persianMonths[focusedJalali.month - 1]} ${toPersianNumber(focusedJalali.year)}',
//                 style: const TextStyle(
//                   fontFamily: 'Vazir',
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Iconsax.arrow_circle_left),
//                 onPressed: () {
//                   final nextMonth = safeAddMonths(focusedJalali, 1);
//                   if (!nextMonth.isAfter(maxMonth)) {
//                     setState(() {
//                       focusedDay = nextMonth.toDateTime();
//                     });
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),

//         TableCalendar(
//           locale: 'fa_IR',
//           firstDay: firstDay.toDateTime(),
//           lastDay: lastDay.toDateTime(),
//           focusedDay: focusedDay,
//           rangeStartDay: rangeStart?.toDateTime(),
//           rangeEndDay: rangeEnd?.toDateTime(),
//           calendarFormat: CalendarFormat.month,
//           headerVisible: false,
//           availableCalendarFormats: const {CalendarFormat.month: 'ماهانه'},
//           calendarStyle: CalendarStyle(
//             defaultTextStyle: const TextStyle(fontFamily: 'Vazir'),
//             rangeHighlightColor: Colors.teal.shade100,
//             todayTextStyle: const TextStyle(color: Colors.black),
//             todayDecoration: const BoxDecoration(
//               color: AppColors.accentColor,
//               shape: BoxShape.circle,
//             ),
//           ),
//           calendarBuilders: CalendarBuilders(
//             defaultBuilder: (context, day, focusedDay) {
//               final jDay = Gregorian.fromDateTime(day).toJalali();
//               final reserved = _isReserved(jDay);

//               return Center(
//                 child: Text(
//                   toPersianNumber(jDay.day),
//                   style: TextStyle(
//                     color: reserved ? Colors.red : Colors.black,
//                     fontWeight: reserved ? FontWeight.bold : FontWeight.normal,
//                   ),
//                 ),
//               );
//             },
//           ),
//           onRangeSelected: (start, end, focused) {
//             if (start == null) return;

//             final jalaliStart = Gregorian.fromDateTime(start).toJalali();
//             final jalaliEnd =
//                 end != null ? Gregorian.fromDateTime(end).toJalali() : null;

//             bool rangeHasReserved = false;

//             if (jalaliEnd == null) {
//               rangeHasReserved = _isReserved(jalaliStart);
//             } else {
//               Jalali current = jalaliStart;
//               while (!current.isAfter(jalaliEnd)) {
//                 if (_isReserved(current)) {
//                   rangeHasReserved = true;
//                   break;
//                 }
//                 current = current.addDays(1);
//               }
//             }

//             if (rangeHasReserved) {
//               // اگر بازه شامل روز رزرو شده بود، انتخاب انجام نشود
//               return;
//             }

//             setState(() {
//               rangeStart = jalaliStart;
//               rangeEnd = jalaliEnd;
//               focusedDay = focused;
//             });
//           },
//           onDaySelected: (_, __) {}, // غیرفعال کردن انتخاب تکی
//           rangeSelectionMode: RangeSelectionMode.enforced,
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/data/models/reserve_model.dart';
import 'package:table_calendar/table_calendar.dart';

class PersianTableCalendar extends StatefulWidget {
  const PersianTableCalendar({super.key});

  @override
  State<PersianTableCalendar> createState() => _PersianTableCalendarState();
}

class _PersianTableCalendarState extends State<PersianTableCalendar> {
  Jalali? rangeStart;
  Jalali? rangeEnd;

  final List<ReservedDate> reservedDates = [
    ReservedDate(startDate: Jalali(1404, 4, 10), endDate: Jalali(1404, 4, 13)),
    ReservedDate(startDate: Jalali(1404, 4, 16), endDate: Jalali(1404, 4, 17)),
  ];

  DateTime focusedDay = DateTime.now();

  static const List<String> persianMonths = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  Jalali safeAddMonths(Jalali date, int monthsToAdd) {
    int year = date.year;
    int month = date.month + monthsToAdd;
    int day = date.day;

    while (month > 12) {
      month -= 12;
      year += 1;
    }
    while (month < 1) {
      month += 12;
      year -= 1;
    }

    final maxDay = Jalali(year, month, 1).monthLength;
    if (day > maxDay) day = maxDay;

    return Jalali(year, month, day);
  }

  String toPersianNumber(int number) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String s = number.toString();
    for (int i = 0; i < english.length; i++) {
      s = s.replaceAll(english[i], persian[i]);
    }
    return s;
  }

  bool _isReserved(Jalali date) {
    for (var reserved in reservedDates) {
      if (!date.isBefore(reserved.startDate) &&
          !date.isAfter(reserved.endDate)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final focusedJalali = Gregorian.fromDateTime(focusedDay).toJalali();
    final firstDay = Jalali(focusedJalali.year, focusedJalali.month, 1);
    final lastDay = firstDay.addMonths(1).addDays(-1);

    final Jalali todayJalali = Jalali.now();
    final Jalali minMonth = safeAddMonths(todayJalali, 0);
    final Jalali maxMonth = safeAddMonths(todayJalali, 2);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Iconsax.arrow_circle_right),
                onPressed: () {
                  final prevMonth = safeAddMonths(focusedJalali, -1);
                  if (!prevMonth.isBefore(minMonth)) {
                    setState(() {
                      focusedDay = prevMonth.toDateTime();
                    });
                  }
                },
              ),
              Text(
                '${persianMonths[focusedJalali.month - 1]} ${toPersianNumber(focusedJalali.year)}',
                style: const TextStyle(
                  fontFamily: 'Vazir',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Iconsax.arrow_circle_left),
                onPressed: () {
                  final nextMonth = safeAddMonths(focusedJalali, 1);
                  if (!nextMonth.isAfter(maxMonth)) {
                    setState(() {
                      focusedDay = nextMonth.toDateTime();
                    });
                  }
                },
              ),
            ],
          ),
        ),

        TableCalendar(
          locale: 'fa_IR',
          firstDay: firstDay.toDateTime(),
          lastDay: lastDay.toDateTime(),
          focusedDay: focusedDay,
          rangeStartDay: rangeStart?.toDateTime(),
          rangeEndDay: rangeEnd?.toDateTime(),
          calendarFormat: CalendarFormat.month,
          headerVisible: false,
          availableCalendarFormats: const {CalendarFormat.month: 'ماهانه'},
          calendarStyle: CalendarStyle(
            defaultTextStyle: const TextStyle(fontFamily: 'Vazir'),
            rangeHighlightColor: Colors.teal.shade100,
            todayDecoration: const BoxDecoration(
              color: AppColors.accentColor,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              final jDay = Gregorian.fromDateTime(day).toJalali();
              final reserved = _isReserved(jDay);
              final bool isInRange =
                  rangeStart != null &&
                  rangeEnd != null &&
                  !jDay.isBefore(rangeStart!) &&
                  !jDay.isAfter(rangeEnd!);

              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isInRange ? Colors.teal.shade50 : null,
                ),
                child: Text(
                  toPersianNumber(
                    jDay.day,
                  ), // 🔥 عدد فارسی حتی در حالت انتخاب‌شده
                  style: TextStyle(
                    fontFamily: 'Vazir',
                    color:
                        reserved
                            ? Colors.red
                            : isInRange
                            ? Colors.teal
                            : Colors.black,
                    fontWeight:
                        reserved || isInRange
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
              );
            },

            todayBuilder: (context, day, focusedDay) {
              final jDay = Gregorian.fromDateTime(day).toJalali();
              return Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.accentColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  toPersianNumber(jDay.day),
                  style: const TextStyle(
                    fontFamily: 'Vazir',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            rangeStartBuilder: (context, day, focusedDay) {
              final jDay = Gregorian.fromDateTime(day).toJalali();
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  toPersianNumber(jDay.day),
                  style: const TextStyle(
                    fontFamily: 'Vazir',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            rangeEndBuilder: (context, day, focusedDay) {
              final jDay = Gregorian.fromDateTime(day).toJalali();
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  toPersianNumber(jDay.day),
                  style: const TextStyle(
                    fontFamily: 'Vazir',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          onRangeSelected: (start, end, focused) {
            if (start == null) return;

            final jalaliStart = Gregorian.fromDateTime(start).toJalali();
            final jalaliEnd =
                end != null ? Gregorian.fromDateTime(end).toJalali() : null;

            bool rangeHasReserved = false;

            if (jalaliEnd == null) {
              rangeHasReserved = _isReserved(jalaliStart);
            } else {
              Jalali current = jalaliStart;
              while (!current.isAfter(jalaliEnd)) {
                if (_isReserved(current)) {
                  rangeHasReserved = true;
                  break;
                }
                current = current.addDays(1);
              }
            }

            if (rangeHasReserved) return;

            setState(() {
              rangeStart = jalaliStart;
              rangeEnd = jalaliEnd;
              focusedDay = focused;
            });
          },
          onDaySelected: (_, __) {}, // غیرفعال کردن انتخاب تکی
          rangeSelectionMode: RangeSelectionMode.toggledOn,
        ),
      ],
    );
  }
}
