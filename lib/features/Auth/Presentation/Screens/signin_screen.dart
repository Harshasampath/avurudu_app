import 'dart:io';
import 'package:clean_architecture_getx/common/widget/async_widget.dart';
import 'package:clean_architecture_getx/core/app_style.dart';
import 'package:clean_architecture_getx/di.dart'; 
import 'package:clean_architecture_getx/features/Auth/Presentation/Screens/singnup_screen.dart';
import 'package:clean_architecture_getx/features/Auth/Presentation/controller/auth_controller.dart';
import 'package:clean_architecture_getx/features/Auth/domain/entities/auth_entity.dart';
import 'package:clean_architecture_getx/features/user/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SigninScreen> {
  final SignupController controller = getIt<SignupController>();

  Widget get signupButton {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              // Extracting the user's credentials from the form controllers
              final email = controller.emailController.text;
              final password = controller.passwordController.text;
              // Passing the credentials to the signup method
              controller.signup(AuthEntity(email: email, password: password));

              showDialog(
                context: context,
                builder: (_) {
                  return Obx(
                    () {
                      return AsyncWidget(
                        apiState: controller.apiStatus.value,
                        progressStatusTitle: "Signing In...",
                        failureStatusTitle: controller.errorMessage.value,
                        successStatusTitle: "Sign in successful",
                        onRetryPressed: () => controller.signin(
                            AuthEntity(email: email, password: password)),
                        onSuccessPressed: () {
                          Get.to(const HomeScreen());
                          // Navigate to another screen after successful signup
                        },
                      );
                    },
                  );
                },
              );
            }
          },
          child: const Text("Sign In"),
        ));
  }

  Widget get signInForm {
    return Form(
        key: controller.formKey,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("asset/images/app_logo_5.png"),
                height: 150,
              ),
              const SizedBox(height: 30),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    " Wellcome Back!",
                    style: headLine0,
                  )),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                    labelText: "Email", suffixIcon: Icon(Icons.email)),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.isEmail) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password",
                    suffixIcon: Icon(Icons.password_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password Does not have at least 8 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              signupButton,
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if(didPop){
          exit(0);}
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: signInForm, // Your signup form widget
                ),
                const SizedBox(height: 50),
                const Text(
                  "Or",
                  style: normaltext,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle Google sign-in logic here
                        controller.signInWithGoogle();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          'asset/icons/Google.png',
                          height: 35.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle Facebook sign-in logic here
                        controller.signInWithFacebook();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          'asset/icons/facebook.png',
                          height: 38.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Get.to(const SignupScreen(),
                        transition: Transition.circularReveal,
                        duration: const Duration(milliseconds: 500));
                    // Handle Facebook sign-in logic here
                  },
                  child: const Text(
                    "Do not have an account? SignUp.",
                    style: normaltext,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
