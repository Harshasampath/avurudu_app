import 'package:clean_architecture_getx/common/widget/async_widget.dart';
import 'package:clean_architecture_getx/core/app_style.dart';
import 'package:clean_architecture_getx/di.dart';
import 'package:clean_architecture_getx/features/Auth/Presentation/Screens/signin_screen.dart';
import 'package:clean_architecture_getx/features/Auth/Presentation/controller/auth_controller.dart';
import 'package:clean_architecture_getx/features/Auth/domain/entities/auth_entity.dart';
import 'package:clean_architecture_getx/features/user/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                        progressStatusTitle: "Signing up...",
                        failureStatusTitle: controller.errorMessage.value,
                        successStatusTitle: "Signup successful",
                        onRetryPressed: () => controller.signup(AuthEntity(email: email, password: password)),
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
          child: const Text("Sign Up"),
        ));
  }

  Widget get signupForm {
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
                    " Signup",
                    style: headLine0,
                  )),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: "Email", suffixIcon: Icon(Icons.email)),
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
                decoration: const InputDecoration(labelText: "Password", suffixIcon: Icon(Icons.password_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Password must contain at least one number';
                  }
                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'Password must contain at least one special character';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: signupForm, // Your signup form widget
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
                  Get.to(const SigninScreen(), transition: Transition.circularReveal, duration: const Duration(milliseconds: 500));
                  // Handle Facebook sign-in logic here
                },
                child: const Text(
                  "Already have an account? Login",
                  style: normaltext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
