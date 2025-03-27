import 'package:clean_architecture_getx/features/user/presentation/widgets/floating_navigation_icon_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
          // title: const SearchBar(
          //   leading: Icon(Icons.search),
          // ),
          actions: [IconButton(onPressed: () => {}, icon: const Icon(Icons.notifications))],
          toolbarHeight: 70,
        ),
        body:  BottomNavigations(),
        bottomNavigationBar: Align(alignment: Alignment.bottomCenter, child: BottomNavigations()));
  }
}
