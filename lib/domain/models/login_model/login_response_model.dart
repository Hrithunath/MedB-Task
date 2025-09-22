import 'package:med_b/domain/models/user_menu_model/modeule_model.dart';
import 'package:med_b/domain/models/user_menu_model/user_model.dart';

class LoginResponse {
  final String accessToken;
  final String loginKey;
  final UserModel userDetails; 
  final List<ModuleModel> menuData; 

  LoginResponse({
    required this.accessToken,
    required this.loginKey,
    required this.userDetails,
    required this.menuData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] ?? '',
      loginKey: json['loginKey'] ?? '',
      userDetails: UserModel.fromJson(json['userDetails'] ?? {}),
      menuData: (json['menuData'] as List? ?? [])
          .map((e) => ModuleModel.fromJson(e))
          .toList(),
    );
  }
}
