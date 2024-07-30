import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartlocker/services/order_services.dart';
import 'package:http/http.dart' as http;

class LockerCard extends StatefulWidget {
  final String productName;
  final int productPrice;
  final dynamic setLokerName;
  final Future<void> Function(String, int) startPayment;

  const LockerCard({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.startPayment,
    required this.setLokerName,
  });

  @override
  State<LockerCard> createState() => _LockerCardState();
}

class _LockerCardState extends State<LockerCard> {
  final OrderServices _orderServices = OrderServices();
  final StreamController<String> _orderStatusController =
      StreamController<String>.broadcast();
  Timer? _timer;
  bool _isDisposed = false;
  String currentStatus = "Empty";

  @override
  void initState() {
    super.initState();
    fetchDataStatus(); // Initial fetch
    checkLokerNameInAllUsers(widget.productName);
    _startPeriodicFetch(); // Start periodic fetch
    _orderStatusController.stream.listen((status) {
      if (!_isDisposed) {
        setState(() {
          currentStatus = status;
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    _orderStatusController.close();
    super.dispose();
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchDataStatus();
      checkLokerNameInAllUsers(widget.productName);
    });
  }

  Future<String?> checkLokerNameInAllUsers(String lokerName) async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        if (data.containsKey('order')) {
          List<dynamic> orders = data['order'];
          for (var order in orders) {
            if (order['lokerName'] == lokerName) {
              return doc.id;
            }
          }
        }
      }
    } catch (e) {
      print("Error checking lokerName in all users: $e");
    }
    return null;
  }

  Future<int?> fetchDataIndex(String productName, String docId) async {
    try {
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(docId).get();
      List<dynamic> orders = userDoc.get('order');
      for (int i = 0; i < orders.length; i++) {
        if (orders[i]['lokerName'] == productName) {
          return i;
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return null;
  }

  Future<void> fetchDataStatus() async {
    String? docID = await checkLokerNameInAllUsers(widget.productName);
    print("${widget.productName} $docID");
    if (_isDisposed) return; // Check if widget is disposed

    if (docID == null) {
      if (!_isDisposed) _orderStatusController.add("Empty");
      return;
    }
    int? index = await fetchDataIndex(widget.productName, docID);
    if (_isDisposed) return; // Check if widget is disposed

    if (index == null) {
      if (!_isDisposed) _orderStatusController.add("Empty");
      return;
    }

    String? orderID = await _orderServices.searchOrderID(index, docID);
    if (_isDisposed) return; // Check if widget is disposed

    if (orderID == null) {
      if (!_isDisposed) _orderStatusController.add("Empty");
      return;
    }

    const String keyServer = "SB-Mid-server-i_Y-vcDNiW9fBHpTpDPdzZ3N";
    String basicAuth = 'Basic ${base64Encode(utf8.encode(keyServer))}';

    try {
      var response = await http.get(
        Uri.parse("https://api.sandbox.midtrans.com/v2/$orderID/status"),
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
        },
      );

      if (_isDisposed) return; // Check if widget is disposed

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String orderStatus;
        switch (jsonResponse['transaction_status']) {
          case "settlement":
          case "capture":
            orderStatus = "Success";
            break;
          case "pending":
            orderStatus = "Pending";
            break;
          case "deny":
          case "cancel":
          case "expire":
            orderStatus = "Denied";
            break;
          default:
            orderStatus = "Empty";
            break;
        }
        await _orderServices.updateOrderStatus(index, orderStatus, docID);
        if (!_isDisposed) _orderStatusController.add(orderStatus);
      } else {
        if (!_isDisposed) _orderStatusController.add("Empty");
      }
    } catch (e) {
      print("Error fetching status: $e");
      if (!_isDisposed) _orderStatusController.add("Empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    bool absorbPointer;

    switch (currentStatus) {
      case "Pending":
        buttonColor = Colors.yellow;
        absorbPointer = true;
        break;
      case "Denied":
        buttonColor = Colors.red;
        absorbPointer = true;
        break;
      case "Success":
        buttonColor = Colors.green;
        absorbPointer = true;
        break;
      default:
        buttonColor = Colors.grey;
        absorbPointer = false;
        break;
    }

    return AbsorbPointer(
      absorbing: absorbPointer,
      child: SizedBox(
        width: 100,
        height: 100,
        child: ElevatedButton(
          onPressed: () {
            widget.startPayment(widget.productName, widget.productPrice);
            widget.setLokerName(widget.productName);
          },
          style: ButtonStyle(
            side: MaterialStatePropertyAll(
                BorderSide(width: 2, color: const Color(0xFF17151A))),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
          child: Text(
            widget.productName,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
