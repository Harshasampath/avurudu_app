import 'package:clean_architecture_getx/features/user/presentation/controller/navgationbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigations extends StatelessWidget {
  BottomNavigations({super.key});

  final NavigationController _navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the floating bar
        borderRadius: BorderRadius.circular(30), // Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 80,
          ),
        ],
      ),
      child: SizedBox(
        child: Obx(() {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_filled, Icons.home_outlined, "Home", 0),
              _buildNavItem(Icons.find_in_page, Icons.find_in_page_outlined, "Explore", 1),
              _buildNavItem(Icons.favorite, Icons.favorite_outline, "Favorite", 2),
              _buildNavItem(Icons.message, Icons.message_outlined, "Message", 3),
              _buildNavItem(Icons.person, Icons.person_outline, "Profile", 4),
            ],
          );
        }),
      ),
    );
  }

  Column _buildNavItem(IconData filledIcon, IconData outlinedIcon, String label, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            _navigationController.changeIndex(index);
          },
          icon: Icon(
            _navigationController.selectedIndex.value == index ? filledIcon : outlinedIcon, // Switch between filled and outlined icons
            color: Colors.blue,
          ),
          iconSize: 30,
        ),
        Text(label),
        const SizedBox(height: 10),
      ],
    );
  }
}
