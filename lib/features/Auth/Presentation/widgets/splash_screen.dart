import 'package:clean_architecture_getx/core/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'splash_running_dot.dart';
import '../Screens/singnup_screen.dart';

class SplashController extends GetxController {
  var currentPage = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    super.onInit();
    startAutoScroll();
  }

  void setCurrentPage(int page) {
    currentPage.value = page;
  }

  void moveToNext() {
    currentPage.value++;
    pageController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 2000),
      curve: Curves.fastOutSlowIn,
    );
  }

  void startAutoScroll() {
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (currentPage.value < 3) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }

      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 2000),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.put(SplashController());
    List<Map<String, String>> splashData = [
      {
        "image": "asset/images/Splash_1.png",
        "appTopic": "RENTA",
        "happyTitle": "Find the best deals for your rental needs every day",
        "welcomeTitle": "Welcome to Renta App!",
        "featureText": "Discover a wide range of items to rent all around the world. Renting made easy and affordable."
      },
      {
        "image": "asset/images/Splash_2.png",
        "appTopic": "RENTA",
        "happyTitle": "Start earning today by listing items you don't use",
        "welcomeTitle": "List Your Items Today!",
        "featureText": "List your items and start earning. Turn your unused possessions into a source of income effortlessly."
      },
      {
        "image": "asset/images/Splash_3.png",
        "appTopic": "RENTA",
        "happyTitle": "Rent or list, maximize your value with every deal",
        "welcomeTitle": "Rent & List with Ease",
        "featureText": "Whether you're looking to rent or list, our platform offers you the best of both worlds, all in one place."
      },
      {
        "image": "asset/images/Splash_4.png",
        "appTopic": "RENTA",
        "happyTitle": "Access any item you need, whenever you need it",
        "welcomeTitle": "Rent Anything You Need",
        "featureText":
            "From vehicles to tools, rent anything you need or list anything you have. Our platform connects you with endless possibilities."
      }
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.025,
              ),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: splashController.pageController, // Assign the controller
                  onPageChanged: (value) => splashController.setCurrentPage(value),
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    height: height,
                    width: width,
                    image: splashData[index]["image"] ?? "asset/images/default_image.png",
                    appTopic: splashData[index]["appTopic"] ?? "Default App Topic",
                    happyTitle: splashData[index]["happyTitle"] ?? "Default Happy Title",
                    welcomeTitle: splashData[index]["welcomeTitle"] ?? "Default Welcome Title",
                    featureText: splashData[index]["featureText"] ?? "Default feature text.",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the children inside the Row
                  children: List.generate(
                    splashData.length,
                    (index) => Obx(
                      () => SplashRunningDot(
                        index: index,
                        currentPage: splashController.currentPage.value,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (splashController.currentPage.value == 3) {
                          Get.to(() => const SignupScreen());
                        } else {
                          splashController.moveToNext();
                        }
                      },
                      child: Obx(()=> Text(splashController.currentPage.value == 3 ? "Get Start.." : "Continue")),
                    )),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SplashContent extends StatelessWidget {
  const SplashContent({
    super.key,
    required this.height,
    required this.width,
    required this.image,
    required this.appTopic,
    required this.happyTitle,
    required this.welcomeTitle,
    required this.featureText,
  });

  final double height;
  final double width;
  final String appTopic, happyTitle, welcomeTitle, featureText, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.15,
        ),
        SizedBox(
          height: height * 0.025,
        ),
        Text(
          appTopic,
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 50,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          happyTitle,
          style: normaltext,
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Image(
          image: AssetImage(image),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          welcomeTitle,
          style: headLine0,
        ),
        SizedBox(
          height: height * 0.05,
        ),
        SizedBox(
          width: width * 0.7,
          child: Text(
            featureText,
            textAlign: TextAlign.center,
            style: paragraphCenterAlign,
          ),
        ),
      ],
    );
  }
}
