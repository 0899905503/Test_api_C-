import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart' as http;

import 'package:meas/pizza/Cart/Cart_viewmodel.dart';
import 'package:meas/routes/routes.dart';

class TkHomeArguments {
  String param;

  TkHomeArguments({
    required this.param,
  });
}

class CartPage extends StatelessWidget {
  // final TkHomeArguments arguments;

  const CartPage({
    Key? key,

    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const CartChildPage(),
    );
  }
}

class CartChildPage extends StatefulWidget {
  const CartChildPage({Key? key}) : super(key: key);

  @override
  State<CartChildPage> createState() => _CartChildPageState();
}

class _CartChildPageState extends State<CartChildPage> {
  List<Map<String, dynamic>>? history;

  CartViewModel a = CartViewModel();

  @override
  void initState() {
    super.initState();
    fetchTaste();
  }

  Future<void> fetchTaste() async {
    try {
      List<Map<String, dynamic>> cart = await a.getCart();
      setState(() {
        history = cart;
      });
      print(cart);
    } catch (e) {
      print('Error fetching taste : $e');
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
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              await a.clearCart();
              setState(() {
                history?.clear();
              });
            },
            child: Text("Clear Cart")),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: history!.length,
            itemBuilder: (context, index) {
              var cart = history?[index];
              return Card(
                child: ListTile(
                  leading: SizedBox(width: 50, height: 50, child: Text("")),
                  title: Text(
                      cart!['id'] != null ? cart['id'].toString() : 'null'),
                  subtitle: Text(cart['taste'] != null
                      ? cart['taste'].toString()
                      : 'null'),
                  onTap: () {
                    // Gọi hàm xử lý sự kiện khi tiêu đề được nhấn
                    Get.toNamed(RouteConfig.orderPage, arguments: {
                      'taste': cart['taste'].toString(),
                      'flavor': cart['flavor'].toString(),
                      'total': cart['price']
                    });
                    //   print(user!['users'][index]['id']);
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await a.deleteItem(cart['id']);
                      setState(() {
                        history?.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // _cubit.close();
    super.dispose();
  }
}
