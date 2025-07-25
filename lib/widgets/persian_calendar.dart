// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
// import 'package:safar_khaneh/core/constants/colors.dart';
// import 'package:table_calendar/table_calendar.dart';

// class PersianTableCalendar extends StatefulWidget {
//   final List<DateTime> availableDates;
//   final void Function(Jalali start, Jalali? end)? onRangeSelected;

//   const PersianTableCalendar({
//     super.key,
//     required this.availableDates,
//     this.onRangeSelected,
//   });

//   @override
//   State<PersianTableCalendar> createState() => _PersianTableCalendarState();
// }

// class _PersianTableCalendarState extends State<PersianTableCalendar> {
//   Jalali? rangeStart;
//   Jalali? rangeEnd;
//   DateTime focusedDay = DateTime.now();

//   late final Set<String> _availableJalaliStrings;

//   @override
//   void initState() {
//     super.initState();
//     _availableJalaliStrings =
//         widget.availableDates
//             .map((date) => Gregorian.fromDateTime(date).toJalali().toString())
//             .toSet();
//   }

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
//       year++;
//     }
//     while (month < 1) {
//       month += 12;
//       year--;
//     }

//     final maxDay = Jalali(year, month, 1).monthLength;
//     if (day > maxDay) day = maxDay;

//     return Jalali(year, month, day);
//   }

//   bool _isAvailable(Jalali date) {
//     return _availableJalaliStrings.contains(date.toString());
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
//         // کنترل ماه قبل و بعد
//         Padding(
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

//         // تقویم
//         TableCalendar(
//           locale: 'fa_IR',
//           firstDay: firstDay.toDateTime(),
//           lastDay: lastDay.toDateTime(),
//           focusedDay: focusedDay,
//           rangeStartDay: rangeStart?.toDateTime(),
//           rangeEndDay: rangeEnd?.toDateTime(),
//           calendarFormat: CalendarFormat.month,
//           headerVisible: false,
//           rangeSelectionMode: RangeSelectionMode.toggledOn,

//           calendarBuilders: CalendarBuilders(
//             defaultBuilder: (context, day, _) {
//               final jDay = Gregorian.fromDateTime(day).toJalali();
//               final isAvailable = _isAvailable(jDay);
//               final isInRange =
//                   rangeStart != null &&
//                   rangeEnd != null &&
//                   !jDay.isBefore(rangeStart!) &&
//                   !jDay.isAfter(rangeEnd!);

//               return Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: isInRange ? Colors.teal.shade50 : null,
//                 ),
//                 child: Text(
//                   toPersianNumber(jDay.day),
//                   style: TextStyle(
//                     fontFamily: 'Vazir',
//                     color:
//                         isAvailable
//                             ? (isInRange ? Colors.teal : Colors.black)
//                             : Colors.grey,
//                     fontWeight: isInRange ? FontWeight.bold : FontWeight.normal,
//                   ),
//                 ),
//               );
//             },

//             todayBuilder: (context, day, _) {
//               final jDay = Gregorian.fromDateTime(day).toJalali();
//               return Container(
//                 alignment: Alignment.center,
//                 decoration: const BoxDecoration(
//                   color: AppColors.primary800,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   toPersianNumber(jDay.day),
//                   style: const TextStyle(
//                     fontFamily: 'Vazir',
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               );
//             },

//             rangeStartBuilder: (context, day, _) {
//               final jDay = Gregorian.fromDateTime(day).toJalali();
//               return Container(
//                 alignment: Alignment.center,
//                 decoration: const BoxDecoration(
//                   color: AppColors.sky50,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   toPersianNumber(jDay.day),
//                   style: const TextStyle(
//                     fontFamily: 'Vazir',
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               );
//             },

//             rangeEndBuilder: (context, day, _) {
//               final jDay = Gregorian.fromDateTime(day).toJalali();
//               return Container(
//                 alignment: Alignment.center,
//                 decoration: const BoxDecoration(
//                   color: AppColors.sky50,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   toPersianNumber(jDay.day),
//                   style: const TextStyle(
//                     fontFamily: 'Vazir',
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
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

//             bool allAvailable = true;

//             if (jalaliEnd == null) {
//               allAvailable = _isAvailable(jalaliStart);
//             } else {
//               Jalali current = jalaliStart;
//               while (!current.isAfter(jalaliEnd)) {
//                 if (!_isAvailable(current)) {
//                   allAvailable = false;
//                   break;
//                 }
//                 current = current.addDays(1);
//               }
//             }

//             if (!allAvailable) return;

//             setState(() {
//               rangeStart = jalaliStart;
//               rangeEnd = jalaliEnd;
//               focusedDay = focused;
//             });

//             if (widget.onRangeSelected != null) {
//               widget.onRangeSelected!(jalaliStart, jalaliEnd);
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/features/residence/data/models/calendar_model.dart';

class PersianTableCalendar extends StatefulWidget {
  final List<CalendarModel> calendarData;
  final void Function(Jalali start, Jalali? end)? onRangeSelected;

  const PersianTableCalendar({
    super.key,
    required this.calendarData,
    this.onRangeSelected,
  });

  @override
  State<PersianTableCalendar> createState() => _PersianTableCalendarState();
}

class _PersianTableCalendarState extends State<PersianTableCalendar> {
  Jalali? rangeStart;
  Jalali? rangeEnd;
  DateTime focusedDay = DateTime.now();

  final Set<String> _availableDates = {};
  final Set<String> _reservedDates = {};

  @override
  void initState() {
    super.initState();

    _availableDates.addAll(
      widget.calendarData
          .where((e) => e.status == 'available')
          .map(
            (e) =>
                Gregorian.fromDateTime(
                  DateTime.parse(e.date),
                ).toJalali().toString(),
          ),
    );

    _reservedDates.addAll(
      widget.calendarData
          .where((e) => e.status != 'available')
          .map(
            (e) =>
                Gregorian.fromDateTime(
                  DateTime.parse(e.date),
                ).toJalali().toString(),
          ),
    );
  }

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
      year++;
    }
    while (month < 1) {
      month += 12;
      year--;
    }

    final maxDay = Jalali(year, month, 1).monthLength;
    if (day > maxDay) day = maxDay;

    return Jalali(year, month, day);
  }

  bool _isAvailable(Jalali date) => _availableDates.contains(date.toString());

  bool _isReserved(Jalali date) => _reservedDates.contains(date.toString());

  String toPersianNumber(int number) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String s = number.toString();
    for (int i = 0; i < english.length; i++) {
      s = s.replaceAll(english[i], persian[i]);
    }
    return s;
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
        // کنترل ماه‌ها
        Padding(
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

        // تقویم
        TableCalendar(
          locale: 'fa_IR',
          firstDay: firstDay.toDateTime(),
          lastDay: lastDay.toDateTime(),
          focusedDay: focusedDay,
          rangeStartDay: rangeStart?.toDateTime(),
          rangeEndDay: rangeEnd?.toDateTime(),
          calendarFormat: CalendarFormat.month,
          headerVisible: false,
          rangeSelectionMode: RangeSelectionMode.toggledOn,

          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, _) {
              final jDay = Gregorian.fromDateTime(day).toJalali();
              final isAvailable = _isAvailable(jDay);
              final isReserved = _isReserved(jDay);
              final isInRange =
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
                  toPersianNumber(jDay.day),
                  style: TextStyle(
                    fontFamily: 'Vazir',
                    color:
                        isReserved
                            ? Colors.red
                            : (isAvailable
                                ? (isInRange ? Colors.teal : Colors.black)
                                : Colors.grey),
                    fontWeight: isInRange ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            },

            todayBuilder: (context, day, _) {
              final jDay = Gregorian.fromDateTime(day).toJalali();
              return Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary800,
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

            rangeStartBuilder: (context, day, _) {
              final jDay = Gregorian.fromDateTime(day).toJalali();
              return Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.sky50,
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

            rangeEndBuilder: (context, day, _) {
              final jDay = Gregorian.fromDateTime(day).toJalali();
              return Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.sky50,
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

            bool allAvailable = true;

            if (jalaliEnd == null) {
              allAvailable = _isAvailable(jalaliStart);
            } else {
              Jalali current = jalaliStart;
              while (!current.isAfter(jalaliEnd)) {
                if (!_isAvailable(current)) {
                  allAvailable = false;
                  break;
                }
                current = current.addDays(1);
              }
            }

            if (!allAvailable) return;

            setState(() {
              rangeStart = jalaliStart;
              rangeEnd = jalaliEnd;
              focusedDay = focused;
            });

            if (widget.onRangeSelected != null) {
              widget.onRangeSelected!(jalaliStart, jalaliEnd);
            }
          },
        ),
      ],
    );
  }
}
