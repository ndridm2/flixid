import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/movie_detail/movie_detail.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/entities/transaction/transaction.dart';
import '../../../domain/usecases/create_transaction/create_transaction.dart';
import '../../../domain/usecases/create_transaction/create_transaction_param.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/int_extension.dart';
import '../../misc/constants.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/transaction_data/transaction_data_provider.dart';
import '../../providers/usecase/create_transaction_provider/create_transaction_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/back_navigation_bar.dart';
import '../../widgets/network_image_card.dart';
import 'methods/transaction_row.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingConfirmationPage({
    super.key,
    required this.transactionDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;

    transaction = transaction.copyWith(
      total: transaction.ticketAmount! * transaction.ticketPrice! +
          transaction.adminFee,
    );

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: Column(
              children: [
                BackNavigationBar(
                  title: 'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(25),
                NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  borderRadius: 15,
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${movieDetail.backdropPath ?? movieDetail.posterPath}',
                  fit: BoxFit.cover,
                ),
                verticalSpace(25),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpace(5),
                const Divider(color: ghostWhite),
                verticalSpace(5),
                transactionRow(
                  title: 'Showing Date',
                  value: DateFormat('EEEE, d MMMM y').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          transaction.watchTime ?? 0)),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: 'Theater',
                  value: '${transaction.theaterName}',
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: 'Seat Numbers',
                  value: transaction.seats.join(', '),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: '# of Tickets',
                  value: '${transaction.ticketAmount} ticket(s)',
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: 'Ticket Price',
                  value: '${transaction.ticketPrice?.toIDRCurrencyFormat()}',
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: 'Adm. Fee',
                  value: transaction.adminFee.toIDRCurrencyFormat(),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                const Divider(color: ghostWhite),
                transactionRow(
                  title: 'Total Price',
                  value: transaction.total.toIDRCurrencyFormat(),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                verticalSpace(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      int transactionTime =
                          DateTime.now().millisecondsSinceEpoch;

                      transaction = transaction.copyWith(
                        transactionTime: transactionTime,
                        id: 'flx-$transactionTime-${transaction.uid}',
                      );

                      CreateTransaction createTransaction =
                          ref.read(createTransactionProvider);

                      await createTransaction(
                              CreateTransactionParam(transaction: transaction))
                          .then((result) {
                        switch (result) {
                          case Success(value: _):
                            // Menampilkan Snackbar
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Transaction successful!'),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            ref
                                .read(transactionDataProvider.notifier)
                                .refreshTransactionData();
                            ref
                                .read(userDataProvider.notifier)
                                .refreshUserData();
                            ref.read(routerProvider).goNamed('main');
                          case Failed(:final message):
                            // ignore: use_build_context_synchronously
                            context.showSnackBar(message);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: ghostWhite,
                        backgroundColor: prime,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: const Text('Pay Now'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
