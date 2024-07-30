import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smartlocker/widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  final dynamic fetchUserDetails;
  final List<dynamic> order;
  const OrderPage(
      {super.key, required this.fetchUserDetails, required this.order});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Timer? _timer;

  void fetchUserDetails() async {
    await widget.fetchUserDetails();
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      fetchUserDetails();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
    _startPeriodicFetch(); // Start periodic fetching
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> orderCards =
        widget.order.map((order) => OrderCard(orderData: order)).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: orderCards,
      ),
    );
  }
}
