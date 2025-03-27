import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';

class SigninWithFacebook implements UseCase<bool, bool> {
  final AuthRepository authRepository;

  SigninWithFacebook(this.authRepository);

  @override
  Future<Either<String, bool>> call(bool parms) async {
    return authRepository.signInWithFacebook();
  }
}
