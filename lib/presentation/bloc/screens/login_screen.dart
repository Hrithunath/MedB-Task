import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_b/core/utils/responsive_utils.dart';
import 'package:med_b/domain/models/login_model/login_request_model.dart';
import 'package:med_b/presentation/bloc/bloc/auth_bloc.dart';
import 'package:med_b/presentation/bloc/screens/home_screen.dart';
import 'package:med_b/presentation/bloc/screens/registration_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    final containerWidth = ResponsiveHelper.scaleWidth(context, 340);
    final logoSize = ResponsiveHelper.scaleWidth(context, 100);
    final logoHeight = ResponsiveHelper.scaleHeight(context, 100);
    final buttonWidth = ResponsiveHelper.scaleWidth(context, 200);
    final buttonHeight = ResponsiveHelper.scaleHeight(context, 50);
    final paddingAll = ResponsiveHelper.scalePadding(context, horizontal: 22, vertical: 0);
    final spacing20 = ResponsiveHelper.scaleGap(context, 20);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: Card(
              child: SizedBox(
                width: containerWidth,
                 height: ResponsiveHelper.scaleHeight(context, 500), 
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: logoSize,
                        height: logoHeight,
                        child: Image.asset("assets/images/medb_logo.png"),
                      ),
                      SizedBox(height: spacing20),
                      Text(
                        'Welcome Back !',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getTextSize(context, scale: 0.05),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: spacing20),
                      Padding(
                        padding: paddingAll,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveHelper.scaleRadius(context, 10),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: spacing20),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveHelper.scaleRadius(context, 8),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0XFF6F64E7),
                                    width: 2.0,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: spacing20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.lock_outline, color: Color(0XFF6F64E7)),
                                Text(
                                  'Forgot Password',
                                  style: TextStyle(color: Color(0XFF6F64E7)),
                                ),
                              ],
                            ),
                            SizedBox(height: spacing20),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text.trim();
                                  context.read<AuthBloc>().add(
                                        LoginEvent(
                                          loginRequest: LoginRequest(
                                            email: email,
                                            password: password,
                                          ),
                                        ),
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF6F64E7),
                                fixedSize: Size(buttonWidth, buttonHeight),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: spacing20),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.getTextSize(context, scale: 0.045),
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(text: "Don't have an account? "),
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: Color(0XFF6F64E7),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RegistrationScreen(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          } else if (state is LoginLoadedState) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => HomeScreen()),
                            );
                          }
                        },
                        child: SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
