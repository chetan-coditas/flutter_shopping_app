import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        centerTitle: true,
        foregroundColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 232, 227, 227),
      ),
      body: const Center(
        child: Text("No purchase history available"),
      ),
    );
  }
}
