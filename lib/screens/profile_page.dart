import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartlocker/bloc/auth/bloc/auth_bloc.dart';
import 'package:smartlocker/screens/login_page.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String email;
  const ProfilePage({super.key, required this.username, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
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
                    child: Container(),
                  ),
                ],
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 3, color: const Color(0xFF17151A)),
                      shape: BoxShape.circle),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage("lib/assets/images/profile.png"),
                    radius: 60,
                  ),
                ),
              )
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Username",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.username,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Email",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            children: [
                              const Icon(Icons.email),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.email,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 15)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.blue),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Edit Profile",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthInitial) {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                        final snackBar = SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Success!',
                            message: "Well Done You'been log out",
                            contentType: ContentType.success,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else if (state is AuthError) {
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
                      return ElevatedButton(
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 15)),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.red),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(SignOutUser());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log Out",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                              size: 25,
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
