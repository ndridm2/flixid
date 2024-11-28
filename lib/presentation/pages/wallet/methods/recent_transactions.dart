import '../../../misc/methods.dart';
import '../../../providers/transaction_data/transaction_data_provider.dart';
import '../../../widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> recentTransaction(WidgetRef ref) => [
      const Text(
        'Recent Transactions',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(24),
      ...ref.watch(transactionDataProvider).when(
            data: (transactions) => transactions.isEmpty
                ? [const Text("You don't have a transactions")]
                : (transactions
                      ..sort((a, b) =>
                          -a.transactionTime!.compareTo(b.transactionTime!)))
                    .map((transaction) =>
                        TransactionCard(transaction: transaction))
                    .toList(),
            error: (error, stackTrace) => [],
            loading: () => [const CircularProgressIndicator()],
          ),
    ];
