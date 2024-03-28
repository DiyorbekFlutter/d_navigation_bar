import 'package:flutter/material.dart';
import 'package:flutter_application/d_navigation_bar.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExamplePage(),
    );
  }
}


class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final DNavigationBarController dNavigationBarController = DNavigationBarController(currentIndex: 0);

  @override
  void initState() {
    super.initState();
    dNavigationBarController.appBars = appBars;
    dNavigationBarController.pages = pages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: dNavigationBarController.appBar,
      body: dNavigationBarController.page,
      bottomNavigationBar: DNavigationBar(
        onChanged: (index){
          setState(() {});
        },
        controller: dNavigationBarController,
        items: [
          DNavigationBarItem(
            label: 'Asosiy',
            icon: const Icon(Icons.home_filled),
            activeIcon: const Icon(Icons.home, color: Colors.blue),
          ),
          DNavigationBarItem(
            label: 'Saqlangan',
            icon: const Icon(Icons.bookmark_border),
            activeIcon: const Icon(Icons.bookmark, color: Colors.blue),
          ),
          DNavigationBarItem(
            label: 'Qidirish',
            icon: const Icon(Icons.search),
            activeIcon: const Icon(Icons.search, color: Colors.blue),
          ),
          DNavigationBarItem(
            label: 'Sozlamalar',
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings, color: Colors.blue),
          ),
          DNavigationBarItem(
            label: 'Profile',
            icon: const Icon(Icons.person_outlined),
            activeIcon: const Icon(Icons.person, color: Colors.blue),
          )
        ],
      ),
    );
  }
}



const List<Widget> pages = [
  Center(child: Text('Asosiy')),
  Center(child: Text('Saqlangan')),
  Center(child: Text('Qidirish')),
  Center(child: Text('Sozlamalar')),
  Center(child: Text('Profile')),
];


List<PreferredSizeWidget> appBars = [
  AppBar(
      title: const Text("Asosiy", style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.amber,
      centerTitle: true
  ),
  AppBar(
    title: const Text("Saqlangan", style: TextStyle(fontWeight: FontWeight.bold)),
    backgroundColor: Colors.amber,
    centerTitle: true,
  ),
  AppBar(
    title: const Text("Qidirish", style: TextStyle(fontWeight: FontWeight.bold)),
    backgroundColor: Colors.amber,
    centerTitle: true,
  ),
  AppBar(
    title: const Text("Sozlamalar", style: TextStyle(fontWeight: FontWeight.bold)),
    backgroundColor: Colors.amber,
    centerTitle: true,
  ),
  AppBar(
    title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
    backgroundColor: Colors.amber,
    centerTitle: true,
  )
];
