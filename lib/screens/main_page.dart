import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:smartlocker/screens/home_page.dart';
import 'package:smartlocker/screens/order_page.dart';
import 'package:smartlocker/screens/profile_page.dart';
import 'package:smartlocker/services/token_services.dart';
import 'package:smartlocker/widgets/app_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MidtransSDK? _midtrans;
  String orderID = "";
  int _selectedIndex = 0;
  int _lastIndex = 0; // Track the last accessed index
  final User? _auth = FirebaseAuth.instance.currentUser;
  String username = "";
  String email = "";
  List<Object?> order = [];

  Future<void> userDetails() async {
    User? user = _auth;
    dynamic _uid = user?.uid;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      username = userDoc.get('username');
      email = userDoc.get('email');
      order = userDoc.get('order');
    });
  }

  Future<void> startPayment(String productName, int productPrice) async {
    print("hai");
    final result = await TokenService().getToken(productName, productPrice);
    if (result.isRight()){
       String? token = result.fold((l) => null, (r) => r.token);
       _midtrans?.startPaymentUiFlow(token: token);
       if (token == null ) {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: "Token Can't be null",
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          return;
       }
    }else{
      final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: "Transcation Failed",
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          return;
    }
  }
  void setPage() {
    setState(() {
      if (_selectedIndex > 0) {
        _lastIndex = _selectedIndex;
        _selectedIndex = 0; // Go back to the home index
      } else {
        _selectedIndex = _lastIndex;
      }
    });
  }

  void _initSDK() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: dot_env.dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
        merchantBaseUrl: "",
        colorTheme: ColorTheme(
          colorPrimary: Colors.blue,
          colorPrimaryDark: Colors.blue,
          colorSecondary: Colors.blue,
        ),
      ),
    );
    _midtrans?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
    _midtrans!.setTransactionFinishedCallback((result) {
      setState(() {
        orderID = result.orderId ?? "";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    userDetails();
    _initSDK(); 
  }
  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> tabItems = [
      HomePage(username: username,startPayment: startPayment,),
      OrderPage(),
      ProfilePage(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBars(selectedIndex: _selectedIndex, setPage: setPage),
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.home_max_outlined),
              title: Text(
                "Home",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.shopping_basket_outlined),
              title: Text(
                "Pesanan",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.person_2_outlined),
              title: Text(
                "Profile",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            tabItems[_selectedIndex]
          ],
        ),
      ),
    );
  }
}
