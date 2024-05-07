import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:smartlocker/bloc/auth/bloc/auth_bloc.dart';
import 'package:smartlocker/screens/login_page.dart';

class AppBars extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final VoidCallback setPage;
  const AppBars(
      {super.key, required this.selectedIndex, required this.setPage});

  @override
  State<AppBars> createState() => _AppBarsState();
  @override
  Size get preferredSize => Size.fromHeight(100);
}

class _AppBarsState extends State<AppBars> {
  @override
  Widget build(BuildContext context) {
    return _appBar();
  }

  Widget _appBar() {
    return Container(
      decoration: _boxDecoration(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _topBar(),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(color: Color(0xFF17151A));
  }

  Widget _topBar() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success!',
              message: "Well Done You'been sign in",
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
        else if (state is AuthError){
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: state.message,
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                widget.selectedIndex == 0 ?
                BlocProvider.of<AuthBloc>(context).add(SignOutUser()):
                widget.setPage();
              },
              child: Transform(
                  transform: Matrix4.rotationY(math.pi),
                  alignment: Alignment.center,
                  child: widget.selectedIndex == 0
                      ? Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 30,
                        )
                      : Icon(
                          Icons.chevron_right_outlined,
                          color: Colors.white,
                          size: 30,
                        )),
            ),
            Text(
              widget.selectedIndex == 1
                  ? "Pesanan"
                  : widget.selectedIndex == 2
                      ? "Profile"
                      : "Home",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
            ),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            )
          ],
        );
      },
    );
  }
}
