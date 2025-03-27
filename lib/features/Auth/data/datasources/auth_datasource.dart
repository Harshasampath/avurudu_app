import 'package:clean_architecture_getx/features/Auth/data/models/auth_model.dart';
import 'package:clean_architecture_getx/features/Auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<Either<String, AuthEntity>> signUp({required String email, required String password});
  Future<Either<String, AuthEntity>> signInWithEmailAndPassword({required String email, required String password});
  Future<Either<String, bool>> socialSignIn();
  Future<Either<String, bool>> socialSignInWithFacebook();
}

class FirebaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<Either<String, AuthEntity>> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('Sign up failed: The user is null after sign up.');
      }

      var authprint = AuthModel.fromFirebaseAuthUser(userCredential.user!);

      return Right(authprint);
    } on FirebaseAuthException catch (e) {
      print("lede"+ e.code);
      if (e.code == 'weak-password') {
        return const Left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return const Left('The account already exists for that email.');
      } else {
        return Left(e.code);
      }
    }
  }

  @override
  Future<Either<String, bool>> socialSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final booly = userCredential.user != null ? true : false;
      // Once signed in, return the UserCredential
      return Right(booly);
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, bool>> socialSignInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      final booly = userCredential.user != null ? true : false;
      // Once signed in, return the UserCredential
      return Right(booly);
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, AuthEntity>> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      var authprint = AuthModel.fromFirebaseAuthUser(credential.user!);
      return Right(authprint);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return const Left("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return const Left("Wrong password provided for that user.");
      }
    }
    throw UnimplementedError();
  }
}
