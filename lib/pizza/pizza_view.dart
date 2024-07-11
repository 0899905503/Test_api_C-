import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meas/routes/routes.dart';

class TkHomeArguments {
  String pizza;
  String flavor;

  TkHomeArguments({
    required this.pizza,
    required this.flavor,
  });
}

class PizzaPage extends StatelessWidget {
  const PizzaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PizzaChildPage(),
    );
  }
}

class PizzaChildPage extends StatefulWidget {
  const PizzaChildPage({Key? key}) : super(key: key);

  @override
  State<PizzaChildPage> createState() => _PizzaChildPageState();
}

class _PizzaChildPageState extends State<PizzaChildPage> {
  String? _selectedPizza;
  String? _selectedFlavor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        SizedBox(
          height: 30,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: selectTaste("Tomato", "1",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7773-wggMwWMPUyRcsXUBqsqNU-3K2fL5Mg&s"),
              ),
              Expanded(
                child: selectTaste("Mango", "2",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvzx2NUKkUd_iGXkbDuRHDNsK6NC7qPrkDzA&s"),
              ),
              Expanded(
                child: selectTaste("Chilly", "3",
                    "https://img.lovepik.com/photo/48012/6661.jpg_wh860.jpg"),
              ),
              Expanded(
                child: selectTaste("Pobcorn", "4",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXh3d4CBUZZk_dFiWiQJUxj_8EJGnAJzHtTA&s"),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        const Expanded(
            child: Text(
          "Select Pizza Type",
          style: TextStyle(fontSize: 30),
        )),
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: selectOrder("Spicy", "1"),
              ),
              Expanded(
                child: selectOrder("Sweet", "2"),
              ),
              Expanded(
                child: selectOrder("Sour", "3"),
              ),
              Expanded(
                child: selectOrder("Salty", "4"),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Expanded(
            child: Text(
          "Select Flavor",
          style: TextStyle(fontSize: 30),
        )),
        SizedBox(
          child: ElevatedButton(
            onPressed: () {
              if (_selectedPizza != null && _selectedFlavor != null) {
                Get.toNamed(RouteConfig.orderPage, arguments: {
                  'Flavor': _selectedFlavor,
                  'Type': _selectedPizza
                });
              }
            },
            child: const Text('Order'),
          ),
        )
      ],
    );
  }

  Widget selectTaste(String title, String value, String imagePath) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListTile(
        title: Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.network(
                imagePath,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Center(child: Text(title)),
          ],
        ),
        leading: Radio<String>(
          value: value,
          groupValue: _selectedPizza,
          onChanged: (String? value) {
            setState(() {
              _selectedPizza = value;
            });
          },
        ),
      ),
    );
  }

  Widget selectOrder(String title, String value) {
    return SizedBox(
      height: 100,
      width: 150,
      child: ListTile(
        title: Text(title),
        leading: Radio<String>(
          value: value,
          groupValue: _selectedFlavor,
          onChanged: (String? value) {
            setState(() {
              _selectedFlavor = value;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
