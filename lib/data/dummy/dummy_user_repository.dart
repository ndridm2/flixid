import 'dart:io';

import '../repositories/user_repository.dart';
import '../../domain/entities/result.dart';
import '../../domain/entities/user/user.dart';

class DummyUserRepository implements UserRepository {
  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) {
    // implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    await Future.delayed(const Duration(seconds: 1));
    return Result.success(
        User(uid: uid, email: 'dummy@flixid.com', name: 'Dummy'));
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) {
    // implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUser({required User user}) {
    // implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) {
    // implement updateUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> uploadProfilePicture(
      {required User user, required File imageFile}) {
    // implement uploadProfilePicture
    throw UnimplementedError();
  }
}
