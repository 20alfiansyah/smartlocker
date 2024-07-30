// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderCard extends StatefulWidget {
  final dynamic orderData;
  const OrderCard({super.key, this.orderData});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    String lokerName = widget.orderData['lokerName'];
    String orderStatus = widget.orderData['orderStatus'];
    String orderQR = widget.orderData['orderQR'];
    String orderTime = widget.orderData['orderTime'];
    String orderType = widget.orderData['orderType'];
    Color buttonColor;
    bool absorbPointer;

    switch (orderStatus) {
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
        absorbPointer = false;
        break;
      default:
        buttonColor = Colors.grey;
        absorbPointer = true;
        break;
    }

    dynamic showModalButton() {
      return showDialog(
          context: context,
          builder: (BuildContext) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Column(
                          children: [
                            Text(
                              lokerName,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Column(
                          children: [
                            Text(
                              orderType.toUpperCase(),
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: QrImageView(
                        data: orderQR,
                      ),
                    ),
                  ],
                ),
              ],
            );
          });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        height: 140,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          lokerName,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.place,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Location : Depok",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          orderTime,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AbsorbPointer(
                      absorbing: absorbPointer,
                      child: InkWell(
                        onTap: () {
                          showModalButton();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Image.asset(
                            "lib/assets/images/QrCode.png",
                            scale: 5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 80,
                      height: 25,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Status",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color: buttonColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
