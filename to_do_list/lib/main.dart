import 'package:flutter/material.dart';
import 'package:to_do_list/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}


var darktheme = ThemeData.dark(
  useMaterial3: true,
  
);
var theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      primary: Colors.deepOrange.shade800, 
      seedColor: Colors.deepOrange.shade800,
      primaryContainer: Colors.grey.shade200,
    ),
  
  brightness: Brightness.light,
  
  textTheme:  const TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      letterSpacing: 1.3,
      fontSize: 20
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.bold,
      letterSpacing: 1.3,
      fontSize: 20,
      color: Colors.white
    ),
  )
  
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}