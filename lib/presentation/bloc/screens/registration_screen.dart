import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_b/core/utils/responsive_utils.dart';
import 'package:med_b/domain/models/register_model/register_request_model.dart';
import 'package:med_b/presentation/bloc/bloc/auth_bloc.dart';
import 'package:med_b/presentation/bloc/screens/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is RegisterLoadedState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            } else if (state is AuthErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          child: Padding(
            padding: ResponsiveHelper.scalePadding(
              context,
              horizontal: 15,
              vertical: 10,
            ),
            child: Form(
              key: _formKey,
              child: Center(
                child: Card(
                  child: SizedBox(
                    width: ResponsiveHelper.scaleWidth(context, 340),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: ResponsiveHelper.scaleWidth(context, 100),
                            height: ResponsiveHelper.scaleHeight(context, 100),
                            child: Image.asset("assets/images/medb_logo.png"),
                          ),
                          SizedBox(
                            height: ResponsiveHelper.scaleHeight(context, 10),
                          ),
                          Text(
                            'Create an Account',
                            style: TextStyle(
                              fontSize: ResponsiveHelper.getTextSize(
                                context,
                                scale: 0.05,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: ResponsiveHelper.scaleHeight(context, 20),
                          ),
                          Padding(
                            padding: ResponsiveHelper.scalePadding(
                              context,
                              horizontal: 22,
                              vertical: 0,
                            ),
                            child: Column(
                              children: [
                                // First Name
                                TextFormField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    hintText: 'Enter your First Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.scaleRadius(
                                          context,
                                          8,
                                        ),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter First Name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: ResponsiveHelper.scaleHeight(
                                    context,
                                    20,
                                  ),
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _middleNameController,
                                        decoration: InputDecoration(
                                          labelText: 'Middle',
                                          hintText: 'Enter your Middle Name',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              ResponsiveHelper.scaleRadius(
                                                context,
                                                8,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter middle name';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: ResponsiveHelper.scaleWidth(
                                        context,
                                        20,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _lastNameController,
                                        decoration: InputDecoration(
                                          labelText: 'Last Name',
                                          hintText: 'Enter your Last Name',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              ResponsiveHelper.scaleRadius(
                                                context,
                                                8,
                                              ),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter last name';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ResponsiveHelper.scaleHeight(
                                    context,
                                    20,
                                  ),
                                ),

                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter your email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.scaleRadius(
                                          context,
                                          8,
                                        ),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: ResponsiveHelper.scaleHeight(
                                    context,
                                    20,
                                  ),
                                ),

                                TextFormField(
                                  controller: _contactController,
                                  decoration: InputDecoration(
                                    labelText: 'Contact Number',
                                    hintText: 'Enter your Contact Number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.scaleRadius(
                                          context,
                                          8,
                                        ),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFF6F64E7),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter contact Number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: ResponsiveHelper.scaleHeight(
                                    context,
                                    20,
                                  ),
                                ),

                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.scaleRadius(
                                          context,
                                          8,
                                        ),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFF6F64E7),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: ResponsiveHelper.scaleHeight(
                                    context,
                                    20,
                                  ),
                                ),

                                TextFormField(
                                  controller: _confirmPasswordController,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    hintText: 'Re-enter your password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        ResponsiveHelper.scaleRadius(
                                          context,
                                          8,
                                        ),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0XFF6F64E7),
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: ResponsiveHelper.scaleHeight(
                                    context,
                                    20,
                                  ),
                                ),

                                // Register Button
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final request = RegisterRequest(
                                        firstName:
                                            _firstNameController.text.trim(),
                                        middleName:
                                            _middleNameController.text.trim(),
                                        lastName:
                                            _lastNameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        contactNo:
                                            _contactController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                        confirmPassword:
                                            _confirmPasswordController.text
                                                .trim(),
                                      );

                                      context.read<AuthBloc>().add(
                                        RegisterEvent(registerRequest: request),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0XFF6F64E7),
                                    fixedSize: Size(
                                      ResponsiveHelper.scaleWidth(context, 200),
                                      ResponsiveHelper.scaleHeight(context, 50),
                                    ),
                                  ),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ResponsiveHelper.getTextSize(
                                        context,
                                        scale: 0.045,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ResponsiveHelper.scaleHeight(
                                    context,
                                    20,
                                  ),
                                ),

                                // Login RichText
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: ResponsiveHelper.getTextSize(
                                        context,
                                        scale: 0.045,
                                      ),
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: "Already have an account? ",
                                      ),
                                      TextSpan(
                                        text: "Login",
                                        style: TextStyle(
                                          color: Color(0XFF6F64E7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            LoginScreen(),
                                                  ),
                                                );
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ResponsiveHelper.scaleHeight(
                                    context,
                                    10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
