import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:med_b/data/services/dio_client.dart';
import 'package:med_b/domain/models/login_model/login_request_model.dart';
import 'package:med_b/domain/models/login_model/login_response_model.dart';
import 'package:med_b/domain/models/register_model/register_request_model.dart';
import 'package:med_b/domain/models/register_model/register_response_model.dart';
import 'package:med_b/data/services/storage_service.dart';
import 'package:med_b/domain/models/user_menu_model/modeule_model.dart';
import 'package:med_b/domain/models/user_menu_model/user_model.dart';

class AuthServices {
  final DioClient _dioClient = DioClient();

  // ---------------- REGISTER ----------------
  Future<RegisterResponse> register({required RegisterRequest request}) async {
    try {
      final response = await _dioClient.dio.post(
        "auth/register",
        data: request.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponse.fromJson(response.data);
      }
      throw Exception("Registration failed");
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Registration failed");
    }
  }

  // ---------------- LOGIN ----------------
  Future<LoginResponse> login({required LoginRequest loginRequest}) async {
    try {
      final response = await _dioClient.dio.post(
        "auth/login",
        data: loginRequest.toJson(),
        options: Options(extra: {"withCredentials": true, "isLogin": true}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final accessToken = response.data["accessToken"];
        final refreshToken = response.data["refreshToken"];
        final userDetails = response.data["userDetails"];
        final menuData = response.data["menuData"];

        if (accessToken != null) {
          await SecureStorageService.saveAccessToken(accessToken);
          if (refreshToken != null) {
            await SecureStorageService.saveRefreshToken(refreshToken);
          }
          if (userDetails != null) {
            await SecureStorageService.saveUserDetails(UserModel.fromJson(userDetails));
          }
          if (menuData != null) {
            await SecureStorageService.saveMenuData(
              (menuData as List<dynamic>).map((e) => ModuleModel.fromJson(e)).toList()
            );
          }
          return LoginResponse.fromJson(response.data);
        }
      }
     
    throw Exception("Login failed: Invalid response from server.");
    
  } on DioException catch (e) {
    String errorMessage = "Login failed. Please check your credentials.";
    if (e.response != null && e.response!.data != null) {
      if (e.response!.data is Map && e.response!.data["message"] != null) {
        errorMessage = e.response!.data["message"];
      } else {
        errorMessage = e.response!.data.toString();
      }
    }
    throw Exception(errorMessage);
  } catch (_) {
    throw Exception("Login failed. Please try again.");
  }
}

  // ---------------- LOGOUT ----------------
  Future<bool> logout() async {
    try {
      final response = await _dioClient.dio.post(
        "auth/logout",
        options: Options(extra: {"withCredentials": true}),
      );

      if (response.statusCode == 200) {
        await SecureStorageService.clearAll();
        await _dioClient.cookieJar.deleteAll();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
