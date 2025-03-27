import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SigninWithGoogleUseCase implements UseCase<bool,bool>{
  final AuthRepository authRepository;

  SigninWithGoogleUseCase(this.authRepository);

  @override
  Future<Either<String, bool>> call(bool parms) async {
      return authRepository.signInWithGoogle();
  }
}
