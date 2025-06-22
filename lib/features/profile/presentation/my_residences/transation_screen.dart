import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/data/models/transaction_model.dart';
import 'package:safar_khaneh/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh/widgets/button.dart';

final List<TransactionModel> transactions = [
  TransactionModel(id: 1, price: 100000, date: '2025-06-09T12:38:51.082843Z'),
  TransactionModel(id: 2, price: 200000, date: '2025-06-09T12:38:51.082843Z'),
  TransactionModel(id: 3, price: 300000, date: '2025-06-09T12:38:51.082843Z'),
];

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('گزارش مالی'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 16,
                ),
                leading: CircleAvatar(
                  child: Text(formatNumberToPersian(transaction.id)),
                ),
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 60.0),
                      child: Text(formatNumberToPersian(transaction.price)),
                    ),
                    const Spacer(),
                    Text(
                      formatNumberToPersianWithoutSeparator(
                        convertToJalaliDate(transaction.date),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 20,
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${formatNumberToPersian(1000000)} تومان',
              style: TextStyle(
                color: AppColors.grey700,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Button(
                label: 'تسویه حساب',
                onPressed: () {},
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
