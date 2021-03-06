
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/screens/home/home_screen.dart';
import 'package:scholar_chat/screens/login/login.dart';
import 'package:scholar_chat/screens/register/register_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.id : (context)=>LoginScreen(),
        HomeScreen.id :(context) => HomeScreen(),
        RegisterScreen.id: (context)=>RegisterScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute:  LoginScreen.id,
    );
  }
}