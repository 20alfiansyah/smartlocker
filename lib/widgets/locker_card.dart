import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LockerCard extends StatefulWidget {
  final String productName;
  final int productPrice;
  final Future<void> Function(String, int) startPayment;
  const LockerCard({super.key, required this.productName, required this.productPrice, required this.startPayment});

  @override
  State<LockerCard> createState() => _LockerCardState();
}

class _LockerCardState extends State<LockerCard> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Container(
        width: 100,
        height: 100,
        child: ElevatedButton(
          onPressed: (){
            widget.startPayment(widget.productName, widget.productPrice);
            print('executed');
          },
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
            backgroundColor: MaterialStatePropertyAll(Colors.grey)
          ),
          child: Text(
            "${widget.productName}",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14
              )
            ),
          ),
        ),
      ),
    );
  }
}