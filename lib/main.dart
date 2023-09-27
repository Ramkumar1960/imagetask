import 'package:assignment/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(splashscreen());
}

class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainpage(),
    );
  }
}

class mainpage extends StatefulWidget {
  const mainpage({super.key});

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5),(){
      Navigator.push(context,MaterialPageRoute(builder: (context) => MainPage()));
    });
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Image.asset("image/nnnnn.jpeg"),
      )

    );
  }
}
