import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:meas/pizza/Cart/Cart_viewmodel.dart';

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
    return Center(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Id')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Flavor')),
            DataColumn(label: Text('Price')),
          ],
          rows: List<DataRow>.generate(history!.length, (index) {
            var item = history![index];
            return DataRow(cells: [
              DataCell(
                  Text(item['id'] != null ? item['id'].toString() : 'null')),
              DataCell(Text(
                  item['taste'] != null ? item['taste'].toString() : 'null')),
              DataCell(Text(
                  item['flavor'] != null ? item['flavor'].toString() : 'null')),
              DataCell(Text(
                  item['price'] != null ? item['price'].toString() : 'null')),
            ]);
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _cubit.close();
    super.dispose();
  }
}
