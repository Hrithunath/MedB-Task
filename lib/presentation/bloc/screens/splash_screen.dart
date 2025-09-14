import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:med_b/core/utils/responsive_utils.dart';
import 'package:med_b/presentation/bloc/screens/login_screen.dart';
import 'package:med_b/presentation/bloc/screens/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> splashing() async {
  await Future.delayed(const Duration(seconds: 2));
  
  final accessToken = await FlutterSecureStorage().read(key: "accessToken");
  log('Access Token after logout: ${accessToken ?? "No token found"}');

  if (!mounted) return;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => accessToken != null
          ? const HomeScreen()
          :  LoginScreen(),
    ),
  );
}

  @override
  void initState() {
    super.initState();
    splashing();
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      body: Center(
        child: Container(
          width: ResponsiveHelper.scaleWidth(context, 200), 
          height: ResponsiveHelper.scaleHeight(context, 200),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/medb_logo.png",
            width: ResponsiveHelper.scaleWidth(context, 150),
            height: ResponsiveHelper.scaleHeight(context, 150),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
