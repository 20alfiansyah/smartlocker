import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlocker/authRoute.dart';
import 'package:smartlocker/bloc/auth/bloc/auth_bloc.dart';
import 'package:smartlocker/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dot_env.dotenv.load(fileName: ".env");
  
  // MultiBlocProvider should wrap the entire app, including MaterialApp
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthBloc())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color(0xFF0072FF),
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthRoute(),
    );
  }
}

