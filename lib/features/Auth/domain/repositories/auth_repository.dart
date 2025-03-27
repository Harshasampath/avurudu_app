import 'package:clean_architecture_getx/features/Auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<String, AuthEntity>> signUp(String email, String password);
  Future<Either<String, AuthEntity>> signIn(String email, String password);
  Future<Either<String, bool>> signInWithGoogle();
  Future<Either<String, bool>> signInWithFacebook();
}
