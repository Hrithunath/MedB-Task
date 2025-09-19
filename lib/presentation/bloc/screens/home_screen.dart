import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_b/presentation/bloc/bloc/auth_bloc.dart';
import 'package:med_b/presentation/bloc/screens/login_screen.dart';
import 'package:med_b/presentation/bloc/screens/widgets/drawable.dart';
import 'package:med_b/presentation/bloc/screens/widgets/showdialog.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is LogoutLoadedState) {
         

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) =>  LoginScreen()),
            (route) => false,
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 4,
            foregroundColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: screenWidth * 0.12),
                Image.asset(
                  'assets/images/medb-logo-2.png',
                  height: screenHeight * 0.04,
                  fit: BoxFit.contain,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/notify.png',
                      height: screenHeight * 0.03,
                      width: screenHeight * 0.03,
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    InkWell(
                      onTap: () {
                        showDialogBox(
                          context: context,
                          title: "Logout",
                          content: "Are you sure you want to logout?",
                          confirmTap: () {
                            // Trigger Bloc logout
                            context.read<AuthBloc>().add(LogoutEvent());
                            Navigator.pop(context);
                          },
                          cancelTap: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/logout.png',
                            height: screenHeight * 0.03,
                            width: screenHeight * 0.03,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          drawer: const MyDrawer(),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.12,
                  width: screenWidth * 0.25,
                  child: Image.asset("assets/images/medb_logo.png"),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Welcome to MedB!',
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "We're glad to have you here. MedB is your trusted platform for healthcare needs — all in one place.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.055,
                  ),
                  maxLines: 10,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Use the menu on the left to get started.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.045,
                  ),
                  maxLines: 10,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
