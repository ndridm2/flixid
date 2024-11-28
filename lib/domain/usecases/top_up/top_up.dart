import '../../../data/repositories/transaction_repository.dart';
import '../../entities/result.dart';
import '../../entities/transaction/transaction.dart';
import '../create_transaction/create_transaction.dart';
import '../create_transaction/create_transaction_param.dart';
import 'top_up_param.dart';
import '../usecase.dart';

class TopUp implements Usecase<Result<void>, TopUpParam> {
  final TransactionRepository _transactionRepository;

  TopUp({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(TopUpParam params) async {
    CreateTransaction createTransaction =
        CreateTransaction(transactionRepository: _transactionRepository);

    int transactionTime = DateTime.now().millisecondsSinceEpoch;

    var createTransactionResult =
        await createTransaction(CreateTransactionParam(
            transaction: Transaction(
      uid: params.userId,
      id: 'flxtp-$transactionTime-${params.userId}',
      title: 'Top Up',
      adminFee: 0,
      total: -params.amount,
      transactionTime: transactionTime,
    )));

    return switch (createTransactionResult) {
      Success(value: _) => const Result.success(null),
      Failed(message: _) => const Result.failed("Failed to top up")
    };
  }
}
