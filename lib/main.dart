import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_b/presentation/bloc/bloc/auth_bloc.dart';
import 'package:med_b/presentation/bloc/screens/home_screen.dart';
import 'package:med_b/presentation/bloc/screens/login_screen.dart';
import 'package:med_b/presentation/bloc/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
  create: (context) => AuthBloc(),
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
   theme: ThemeData( primarySwatch: Colors.blue,
    brightness: Brightness.light, 
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
     textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black87),
    ),
       elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
     ),
    home:SplashScreen(),
  ),
);


    
  }
}