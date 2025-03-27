// login_usecase.dart
import 'package:clean_architecture_getx/common/usecase/usecase.dart';
import 'package:clean_architecture_getx/features/Auth/domain/entities/auth_entity.dart';
import 'package:clean_architecture_getx/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class LoginUseCase implements UseCase<AuthEntity,LoginParams> {
  final AuthRepository authRepository;

  const LoginUseCase(this.authRepository);

  @override
  Future<Either<String,AuthEntity>> call(LoginParams params) async {
    return await authRepository.signUp(params.email, params.password);
  }
}

@immutable
class LoginParams {
  final String email;
  final String password;

  const LoginParams(this.email, this.password);
}
