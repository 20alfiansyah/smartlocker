import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartlocker/screens/home_page.dart';
import 'package:smartlocker/screens/order_page.dart';
import 'package:smartlocker/screens/profile_page.dart';
import 'package:smartlocker/widgets/app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  int _lastIndex = 0; // Track the last accessed index

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

  List<Widget> tabItems = [
    HomePage(),
    OrderPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.home_max_outlined),
              title: Text(
                "Home",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.shopping_basket_outlined),
              title: Text(
                "Pesanan",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.person_2_outlined),
              title: Text(
                "Profile",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
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
