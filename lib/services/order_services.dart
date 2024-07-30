import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class OrderServices {
  final User? _auth = FirebaseAuth.instance.currentUser;
  Future<void> addOrder(String lokerName, String orderId, String orderStatus,
      String newOrderQR) async {
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    try {
      User? user = _auth;
      dynamic uid = user?.uid;
      final DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(uid);
      // Fetch existing orders
      DocumentSnapshot userSnapshot = await userDoc.get();
      List<dynamic> existingOrders = userSnapshot.get('order') ?? [];
      // Add new order
      Map<String, dynamic> newOrder = {
        'lokerName': lokerName,
        'orderID': orderId,
        'orderStatus': orderStatus,
        'orderQR': newOrderQR,
        'orderTime': formattedDate,
        'orderType': "masuk",
      };
      existingOrders.add(newOrder);
      // Update the entire orders array
      await userDoc.update({'order': existingOrders});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateOrderStatus(
      int index, String newOrderStatus, String docID) async {
    try {
      final DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(docID);
      DocumentSnapshot userSnapshot = await userDoc.get();
      List<dynamic> existingOrders = userSnapshot.get('order') ?? [];
      // Update order status at the specified index
      if (index >= 0 && index < existingOrders.length) {
        existingOrders[index]['orderStatus'] = newOrderStatus;
        // Update the entire orders array
        await userDoc.update({'order': existingOrders});
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> searchOrderID(int index, String docID) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(docID).get();

    List<dynamic> existingOrders = userSnapshot.get('order') ?? [];

    // Check if the index is within the bounds of existingOrders
    if (index >= 0 && index < existingOrders.length) {
      // Check if the orderID exists at the specified index
      if (existingOrders[index] != null &&
          existingOrders[index].containsKey('orderID')) {
        // Return the orderID if it exists
        return existingOrders[index]['orderID'].toString();
      }
    }

    // Return null if the orderID doesn't exist or the index is out of bounds
    return null;
  }
}
