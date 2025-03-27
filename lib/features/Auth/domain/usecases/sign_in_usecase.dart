// login_usecase.dart
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/Auth/domain/entities/auth_entity.dart';
import 'package:clean_architecture_getx/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class SignInUsecase implements UseCase<AuthEntity,LoginParams2> {
  final AuthRepository authRepository;

  const SignInUsecase(this.authRepository);

  @override
  Future<Either<String,AuthEntity>> call(LoginParams2 params) async {
    return await authRepository.signIn(params.email, params.password);
  }
}

@immutable
class LoginParams2 {
  final String email;
  final String password;

  const LoginParams2(this.email, this.password);
}
