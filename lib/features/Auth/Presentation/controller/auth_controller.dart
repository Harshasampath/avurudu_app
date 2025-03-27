import 'package:clean_architecture_getx/features/Auth/domain/entities/auth_entity.dart';
import 'package:clean_architecture_getx/features/Auth/domain/usecases/login_usecase.dart';
import 'package:clean_architecture_getx/features/Auth/domain/usecases/sign_in_usecase.dart';
import 'package:clean_architecture_getx/features/Auth/domain/usecases/signin_with_facebook.dart';
import 'package:clean_architecture_getx/features/Auth/domain/usecases/signin_with_google.dart';
import 'package:clean_architecture_getx/features/user/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clean_architecture_getx/common/controller/base_controller.dart';

class SignupController extends GetxController with StateMixin<AuthEntity>, BaseController {
  // Reactive variable to store the signup form state
  Rx<AuthEntity?> signedUpUser = Rx<AuthEntity?>(null);

  // UseCase for signing up a user
  final LoginUseCase loginUseCase;
  final SignInUsecase signInUsecase;
  final SigninWithGoogleUseCase signinWithGoogleUseCase;
  final SigninWithFacebook signinWithFacebook;

  // FormKey to manage form state
  final formKey = GlobalKey<FormState>();

  // TextEditingControllers for form fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupController({
    required this.signInUsecase,
    required this.loginUseCase,
    required this.signinWithGoogleUseCase,
    required this.signinWithFacebook,
  });

  Future<void> signup(AuthEntity userCredentials) async {
    change(null, status: RxStatus.loading());
    apiStatus.value = ApiState.loading;

    print("Loading");

    final failureOrSuccess = await loginUseCase.call(LoginParams(userCredentials.email, userCredentials.password));

    print("Worked failure or success");

    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
        apiStatus.value = ApiState.failure;
        errorMessage.value = failure;
        print("failure of API calling");
      },
      (AuthEntity authUser) {
        change(authUser, status: RxStatus.success());
        apiStatus.value = ApiState.success;
        print("success API calling");
      },
    );

    print("show popup");
  }

  Future<void> signin(AuthEntity userCredentials) async {
    change(null, status: RxStatus.loading());
    apiStatus.value = ApiState.loading;

    print("Loading");

    final failureOrSuccess = await signInUsecase.call(LoginParams2(userCredentials.email, userCredentials.password));

    print("Worked failure or success");

    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
        apiStatus.value = ApiState.failure;
        errorMessage.value = failure;
        print("failure of API calling");
      },
      (AuthEntity authUser) {
        change(authUser, status: RxStatus.success());
        apiStatus.value = ApiState.success;
        print("success API calling");
      },
    );

    print("show popup");
  }

  Future<void> signInWithGoogle() async {
    var result = await signinWithGoogleUseCase.call(true);

    result.fold((ifLeft) {
      print(result);
    }, (ifRight) {
      Get.to(const HomeScreen());
    });
  }

  Future<void> signInWithFacebook() async {
    var result = await signinWithFacebook.call(true);

    result.fold((ifLeft) {
      Get.dialog(
        AlertDialog(
          title: const Text('Alert'),
          content: Text(ifLeft),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Closes the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      print(result);
    }, (ifRight) {
      Get.to(const HomeScreen());
    });
  }
}
