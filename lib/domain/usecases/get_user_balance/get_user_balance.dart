import '../../../data/repositories/user_repository.dart';
import '../../entities/result.dart';
import 'get_user_balance_param.dart';
import '../usecase.dart';

class GetUserBalance implements Usecase<Result<int>, GetUserBalanceParam> {
  final UserRepository _userRepository;

  GetUserBalance({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<int>> call(GetUserBalanceParam params) =>
      _userRepository.getUserBalance(uid: params.userId);
}
