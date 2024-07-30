import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartlocker/widgets/locker_card.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String username;
  final dynamic setLokerName;
  final Future<void> Function(String, int) startPayment;
  const HomePage(
      {super.key,
      required this.username,
      required this.startPayment,
      required this.setLokerName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  bool _isVisible = false;
  late DateTime date;
  late String formattedDate;
  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    formattedDate = DateFormat('dd/MM/yyyy').format(date);
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: const Color(0xFF17151A),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: const Color(0xFF17151A)),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Welcome,",
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.username,
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Color(0xFF0072FF),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.place,
                                      size: 15,
                                      color: Color(0xFF0072FF),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Location : ",
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Depok",
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      size: 15,
                                      color: Color(0xFF0072FF),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Date : ",
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      formattedDate,
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.punch_clock,
                                      size: 15,
                                      color: Color(0xFF0072FF),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Open : ",
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "07.00-15.00",
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            "lib/assets/images/locker3d.png",
                            scale: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.green),
                    width: 10,
                    height: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Booked",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.red),
                    width: 10,
                    height: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Cancel",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.yellow),
                    width: 10,
                    height: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Pending",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey),
                    width: 10,
                    height: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Empty",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Stack(
            children: [
              Visibility(
                visible: _isVisible,
                maintainState: true,
                maintainAnimation: true,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LockerCard(
                          productName: "Loker1",
                          productPrice: 10000,
                          startPayment: widget.startPayment,
                          setLokerName: widget.setLokerName,
                        ),
                        LockerCard(
                          productName: "Loker2",
                          productPrice: 10000,
                          startPayment: widget.startPayment,
                          setLokerName: widget.setLokerName,
                        ),
                        LockerCard(
                          productName: "Loker3",
                          productPrice: 10000,
                          startPayment: widget.startPayment,
                          setLokerName: widget.setLokerName,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LockerCard(
                          productName: "Loker4",
                          productPrice: 10000,
                          startPayment: widget.startPayment,
                          setLokerName: widget.setLokerName,
                        ),
                        LockerCard(
                          productName: "Loker5",
                          productPrice: 10000,
                          startPayment: widget.startPayment,
                          setLokerName: widget.setLokerName,
                        ),
                        LockerCard(
                          productName: "Loker6",
                          productPrice: 10000,
                          startPayment: widget.startPayment,
                          setLokerName: widget.setLokerName,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LockerCard(
                          productName: "Loker7",
                          productPrice: 10000,
                          startPayment: widget.startPayment,
                          setLokerName: widget.setLokerName,
                        ),
                        LockerCard(
                          productName: "Loker8",
                          productPrice: 10000,
                          startPayment: widget.startPayment,
                          setLokerName: widget.setLokerName,
                        ),
                        LockerCard(
                          productName: "Loker9",
                          productPrice: 10000,
                          startPayment: widget.startPayment,
                          setLokerName: widget.setLokerName,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                visible: !_isVisible,
                maintainState: true,
                maintainAnimation: true,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
