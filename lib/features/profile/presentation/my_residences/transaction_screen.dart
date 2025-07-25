import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh/features/profile/data/models/transaction_model.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/features/profile/data/services/transaction_services.dart';

class TransactionScreen extends StatefulWidget {
  final ResidenceContextModel contextModel;
  const TransactionScreen({super.key, required this.contextModel});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TransactionService _transactionService = TransactionService();

  late Future<PayoutModel> _payoutInfo;
  late Future<List<TransactionModel>> _transactions;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _payoutInfo = _transactionService.fetchPayoutInfo(
      widget.contextModel.residence.id!,
    );
    _transactions = _transactionService.fetchTransactions(
      widget.contextModel.residence.id!,
    );
  }

  void _handlePayoutRequest(context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _transactionService.sendPayoutRequest(
        widget.contextModel.residence.id!,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(e.toString(), textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handlePayoutModal(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('درخواست تسویه حساب'),
          content: FutureBuilder<PayoutModel>(
            future: _payoutInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return const Text(
                  'مبلغی موجود نیست',
                  textDirection: TextDirection.rtl,
                );
              }

              final payout = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'آیا از ارسال درخواست تسویه حساب مطمئن هستید؟',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'مبلغ کومیسیون',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary800,
                        ),
                      ),
                      Text(
                        '${formatNumberToPersian(payout.commission / 10)} تومان',
                        style: TextStyle(
                          color: AppColors.grey700,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'مبلغ قابل تسویه',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary800,
                        ),
                      ),
                      Text(
                        '${formatNumberToPersian(payout.finalValue / 10)} تومان',
                        style: TextStyle(
                          color: AppColors.grey700,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                'انصراف',
                style: TextStyle(color: AppColors.error200, fontSize: 16),
              ),
            ),
            FutureBuilder<PayoutModel>(
              future: _payoutInfo,
              builder: (context, snapshot) {
                final isEnabled =
                    snapshot.hasData && snapshot.data!.finalValue != 0;
                return Button(
                  enabled: isEnabled,
                  onPressed: () {
                    _handlePayoutRequest(context);
                    context.pop();
                  },
                  label: 'تایید',
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _payoutInfo = _transactionService.fetchPayoutInfo(
        widget.contextModel.residence.id!,
      );
      _transactions = _transactionService.fetchTransactions(
        widget.contextModel.residence.id!,
      );
    });
  }

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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Stack(
          children: [
            FutureBuilder(
              future: _transactions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('هیچ تراکنشی یافت نشد'));
                }
                final transactions = snapshot.data ?? [];
                return ListView.builder(
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
                            child: Text(
                              '${formatNumberToPersian(transaction.amount)} تومان',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey700,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            formatNumberToPersianWithoutSeparator(
                              convertToJalaliDate(transaction.createdAt),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
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
            FutureBuilder(
              future: _payoutInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text('مبلغی یافت نشد');
                }
                if (snapshot.data == null) {
                  return const Text('مبلغی یافت نشد');
                }
                return Text(
                  '${formatNumberToPersian(snapshot.data!.finalValue / 10)} تومان',
                  style: TextStyle(
                    color: AppColors.grey700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Button(
                label: 'تسویه حساب',
                onPressed: () {
                  _handlePayoutModal(context);
                },
                width: double.infinity,
                isLoading: _isLoading,
                enabled: (widget.contextModel.payout?.finalValue != 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
