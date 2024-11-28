import '../../../data/repositories/user_repository.dart';
import '../../entities/result.dart';
import '../../entities/user/user.dart';
import 'upload_profile_picture_param.dart';
import '../usecase.dart';

class UploadProfilePicture
    implements Usecase<Result<User>, UploadProfilePictureParam> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<User>> call(UploadProfilePictureParam params) => _userRepository
      .uploadProfilePicture(user: params.user, imageFile: params.imageFile);
}
