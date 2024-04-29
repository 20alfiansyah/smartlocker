import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  final _formfield =  GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool isShow = false;
  void setisShow(){
    setState(() {
      isShow =!isShow;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'lib/assets/images/loginSplash.png',
                    ),
                    Text(
                      "Welcome back!",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "Sign in to continue!",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Form(
                  key: _formfield,
                  child: Column(
                    children: [
                      //EMAIL ADDRESS
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "E-mail address",
                                style: GoogleFonts.poppins(
                                   textStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          TextFormField(
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Please enter your email";
                              }
                              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                              if(!emailValid){
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                   color: Colors.black,
                                   fontSize: 15,
                                   fontWeight: FontWeight.w500,
                                 ),
                                ),
                            controller: _emailController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.2),width: 2),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFF0072FF),width: 2),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFFF1D00),width: 2),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              errorStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFFFF1D00),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              suffixIcon: const Icon(Icons.email_outlined,size: 25),
                              hintText: "Enter your email address",
                              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17)
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      //PASSWORD
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Passwords",
                                style: GoogleFonts.poppins(
                                   textStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          TextFormField(
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Please enter your password";
                              }
                              bool passValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{5,}$').hasMatch(value);
                              if (!passValid) {
                                return "Please enter a valid password";
                              }
                              return null;
                            },
                            obscureText: isShow ? false : true,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                   color: Colors.black,
                                   fontSize: 15,
                                   fontWeight: FontWeight.w500,
                                 ),
                                ),
                            controller: _passController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.2),width: 2),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFF0072FF),width: 2),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFFF1D00),width: 2),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              errorStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFFFF1D00),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              suffixIcon: IconButton(
                                icon: isShow ? const Icon(Icons.visibility, size: 25) : const Icon(Icons.visibility_off, size: 25),
                                onPressed: setisShow,
                              ),
                              hintText: "Enter your passwords",
                              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 17)
                            )
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (){},
                                child: Text(
                                  "Forgot Password?",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                      color: Color(0xFF0072FF),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: (){
                                        if (_formfield.currentState!.validate()) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("NIce"))
                                        );
                                      }
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(horizontal: 20, vertical: 14)
                                        ),
                                        backgroundColor: const MaterialStatePropertyAll(Color(0xFF0072FF)),
                                        shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        )
                                      ),
                                      child: Text(
                                        "Login",
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  InkWell(
                                    onTap: (){},
                                    child: Text(
                                      "Sign Up",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                          color: Color(0xFF0072FF),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],   
            ),
          )
        ],
      ),
    );
  }
}