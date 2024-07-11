import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:meas/pizza/Cart/Cart_view.dart';
import 'package:meas/pizza/Order/order_view.dart';
import 'package:meas/pizza/Order/order_viewmodel.dart';

import 'package:meas/pizza/pizza_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
      ],
      child: Builder(
        builder: (context) {
          // Use GetMaterialApp here to access providers
          return GetMaterialApp(
            home: MainPage(),
            getPages: [
              GetPage(name: '/orderPage', page: () => const OrderPage()),
              GetPage(name: '/mainPage', page: () => MainPage())
            ],
          );
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    PizzaPage(),
    CartPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza App'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
            label: 'Pizza',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
