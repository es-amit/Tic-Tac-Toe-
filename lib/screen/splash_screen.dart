import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/screen/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static var customFont = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    )
  );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    _navigatorToHome();
  }

  void _navigatorToHome() async{
    await Future.delayed(Duration(milliseconds: 1800));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D58),
      body: Center(
        child: Container(child: Text("Tic Tac Toe Game",
        style: SplashScreen.customFont,),),
      ),
    );
  }
}