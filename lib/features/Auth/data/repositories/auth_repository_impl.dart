import 'package:clean_architecture_getx/common/network/dio_exception.dart';
import 'package:clean_architecture_getx/common/repository/repository_helper.dart';
import 'package:clean_architecture_getx/features/Auth/data/datasources/auth_datasource.dart';
import 'package:clean_architecture_getx/features/Auth/data/models/auth_model.dart';
import 'package:clean_architecture_getx/features/Auth/domain/entities/auth_entity.dart';
import 'package:clean_architecture_getx/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show DioException;

class AuthRepositoryImpl extends AuthRepository with RepositoryHelper<AuthModel> {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<String, AuthEntity>> signUp(String email, String password) async {
    try {
      final authModel = await authDataSource.signUp(
        email: email,
        password: password,
      );

      return authModel;
    } on DioException catch (e) {
      final exeption = DioExceptions.fromDioError(e).toString();
      return Left(exeption);
    }
  }

  @override
  Future<Either<String, bool>> signInWithGoogle() async {
    try {
      final isSignIn = await authDataSource.socialSignIn();
      return isSignIn;
    } on DioException catch (e) {
      final exeption = DioExceptions.fromDioError(e).toString();
      return Left(exeption);
    }
  }

  @override
  Future<Either<String, bool>> signInWithFacebook() async {
    try {
      final isSignIn = await authDataSource.socialSignInWithFacebook();
      return isSignIn;
    } on DioException catch (e) {
      final exeption = DioExceptions.fromDioError(e).toString();
      return Left(exeption);
    }
  }
  
  @override
  Future<Either<String, AuthEntity>> signIn(String email, String password) async {
    try {
      final authModel = await authDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authModel;
    } on DioException catch (e) {
      final exeption = DioExceptions.fromDioError(e).toString();
      return Left(exeption);
    }
  }

}
