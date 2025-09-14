import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_b/core/utils/responsive_utils.dart';
import 'package:med_b/presentation/bloc/bloc/auth_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoginLoadedState) {
          final user = state.user;
          final menuData = state.menu; // menuData list

          return Drawer(
            backgroundColor: const Color(0xFFEAF4F4),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: ResponsiveHelper.scalePadding(context, horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/medb-logo-2.png',
                              height: ResponsiveHelper.scaleHeight(context, 60),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                size: ResponsiveHelper.scaleWidth(context, 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveHelper.scaleGap(context, 16)),

                      // User info
                      ListTile(
                        leading: user.profilePicture != null
                            ? Image.network(
                                user.profilePicture!,
                                width: ResponsiveHelper.scaleWidth(context, 40),
                                height: ResponsiveHelper.scaleHeight(context, 40),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.person);
                                },
                              )
                            : Icon(Icons.person,
                                size: ResponsiveHelper.scaleWidth(context, 40),
                                color: Colors.blue),
                        title: Text(
                          "${user.firstName}${user.middleName ?? ''}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveHelper.getTextSize(context, scale: 0.045),
                          ),
                        ),
                      ),
                      SizedBox(height: ResponsiveHelper.scaleGap(context, 10)),

                      // Dynamic menu
                      ...menuData.map((module) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: ResponsiveHelper.scaleGap(context, 5)),
                            ...module.menus.map((menu) {
                              return ListTile(
                                leading: menu.menuIcon != null
                                    ? Image.network(
                                        menu.menuIcon!,
                                        width: ResponsiveHelper.scaleWidth(context, 30),
                                        height: ResponsiveHelper.scaleHeight(context, 30),
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.broken_image);
                                        },
                                      )
                                    : null,
                                title: Text(
                                  menu.menuName,
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.getTextSize(context, scale: 0.04),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, menu.menuName);
                                },
                              );
                            }),
                            SizedBox(height: ResponsiveHelper.scaleGap(context, 10)),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Drawer();
        }
      },
    );
  }
}
