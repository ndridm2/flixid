import '../repositories/authentication.dart';
import '../../domain/entities/result.dart';

class DummyAuthentication implements Authentication {
  @override
  String? getLoggedInUserid() {
    //
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Result.success('ID-12345');
  }

  @override
  Future<Result<void>> logout() {
    //
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) {
    //
    throw UnimplementedError();
  }
}
