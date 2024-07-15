import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:meas/pizza/Order/order_viewmodel.dart';
import 'package:meas/routes/routes.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class OrderPage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const OrderPage({
    Key? key,

    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const OrderChildPage(),
    );
  }
}

class OrderChildPage extends StatefulWidget {
  const OrderChildPage({Key? key}) : super(key: key);

  @override
  State<OrderChildPage> createState() => _OrderChildPageState();
}

class _OrderChildPageState extends State<OrderChildPage> {
  String? FlavorPizza;
  String? TypePizza;

  String? flavorCart;
  String? tasteCart;
  double? totalCart;

  List<Map<String, dynamic>>? tastePizza;
  List<Map<String, dynamic>>? flavorPizza;
  OrderViewModel a = OrderViewModel();

  final TextEditingController tasteController = TextEditingController();
  final TextEditingController flavorController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    flavorCart = Get.arguments['flavor'];
    tasteCart = Get.arguments['taste'];
    totalCart = Get.arguments['total'];
    // Nhận dữ liệu từ arguments khi khởi tạo màn hình
    FlavorPizza = Get.arguments['Flavor'];
    TypePizza = Get.arguments['Type'];
    if (tasteCart == null) {
      fetchTaste(int.parse(TypePizza!));
    }
    if (flavorCart == null) {
      fetchFlavor(int.parse(FlavorPizza!));
    }
    // infor();
  }

  Future<void> fetchTaste(int TasteId) async {
    try {
      List<Map<String, dynamic>> taste = await a.getTaste(TasteId);
      setState(() {
        tastePizza = taste;
      });
      print(taste);
    } catch (e) {
      print('Error fetching taste : $e');
      setState(() {});
    }
  }

  Future<void> fetchFlavor(int flavorId) async {
    try {
      List<Map<String, dynamic>> flavor = await a.getFlavor(flavorId);
      setState(() {
        flavorPizza = flavor;
      });
      print(flavor);
    } catch (e) {
      print('Error fetching flavor : $e');
      setState(() {});
    }
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
    double total =
        totalCart ?? (tastePizza![0]['price'] + flavorPizza![0]['price']);
    tasteController.text = tasteCart ?? tastePizza![0]['taste'];
    flavorController.text = flavorCart ?? flavorPizza![0]['flavor'];
    priceController.text = total.toString();
    return Container(
      child: Center(
        child: Column(
          children: [
            const Text(
              'Your Pizza Order',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              child: TextField(
                controller: tasteController,
                decoration: InputDecoration(
                  labelText: "Taste",
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: TextField(
                controller: flavorController,
                decoration: InputDecoration(
                  labelText: "Flavor",
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "Price",
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, String> data = {
                    'Taste': tasteController.text,
                    'Flavor': flavorController.text,
                    'price': priceController.text,
                  };
                  await a.addCart(data);
                  Get.snackbar("Success", "Pls! Check Cart");
                  Get.toNamed(RouteConfig.mainPage);
                },
                child: Text("BUY"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _cubit.close();
    tasteController.dispose();
    flavorController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
