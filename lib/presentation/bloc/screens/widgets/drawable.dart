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
          final menuData = state.menu;

          final sortedModules = List.from(menuData)
            ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

          return Drawer(
            backgroundColor: const Color(0xFFEAF4F4),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: ResponsiveHelper.scalePadding(
                      context, horizontal: 16, vertical: 16),
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

                      ListTile(
                        leading: user.profilePicture != null
                            ? Image.network(
                                user.profilePicture!,
                                width: ResponsiveHelper.scaleWidth(context, 40),
                                height:
                                    ResponsiveHelper.scaleHeight(context, 40),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.person),
                              )
                            : Icon(
                                Icons.person,
                                size: ResponsiveHelper.scaleWidth(context, 40),
                                color: Colors.blue,
                              ),
                        title: Text(
                          "${user.firstName} ${user.middleName ?? ''} ${user.lastName ?? ''}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveHelper.getTextSize(
                              context,
                              scale: 0.045,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ResponsiveHelper.scaleGap(context, 10)),

                      // ---- Dynamic Modules ----
                      ...sortedModules.map((module) {
                        // Sort menus
                        final sortedMenus = List.from(module.menus)
                          ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

                        return ExpansionTile(
                          leading: module.moduleIcon != null
                              ? Image.network(
                                  module.moduleIcon!,
                                  width: ResponsiveHelper.scaleWidth(context, 24),
                                  height: ResponsiveHelper.scaleHeight(context, 24),
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.broken_image),
                                )
                              : const Icon(Icons.folder),
                          title: Text(
                            module.moduleName == "Patient"
                                ? "${user.firstName} ${user.middleName ?? ''} ${user.lastName ?? ''}"
                                : module.moduleName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ResponsiveHelper.getTextSize(
                                context,
                                scale: 0.043,
                              ),
                            ),
                          ),
                          children: sortedMenus.map<Widget>((menu) {
                            return ListTile(
                              leading: menu.menuIcon != null
                                  ? Image.network(
                                      menu.menuIcon!,
                                      width: ResponsiveHelper.scaleWidth(context, 28),
                                      height:
                                          ResponsiveHelper.scaleHeight(context, 28),
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.broken_image),
                                    )
                                  : const Icon(Icons.circle),
                              title: Text(
                                menu.menuName,
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.getTextSize(
                                    context,
                                    scale: 0.04,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Future.microtask(() {
                                  Navigator.pushNamed(
                                      context, "/${menu.controllerName}");
                                });
                              },
                            );
                          }).toList(),
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
