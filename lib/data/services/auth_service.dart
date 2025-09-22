import 'package:dio/dio.dart';
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

    // Debug prints
    print("Status Code: ${response.statusCode}");
    print("Response Data: ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterResponse.fromJson(response.data);
    }

    throw Exception("Registration failed");
  } on DioException catch (e) {
    // Print full Dio exception for debugging
    print("DioException: $e");
    print("Request URL: ${e.requestOptions.uri}");
    print("Request Data: ${e.requestOptions.data}");
    print("Response: ${e.response}");

    String errorMessage = "Registration failed";

    if (e.response != null && e.response!.data != null) {
      final data = e.response!.data;
      
      if (data is Map<String, dynamic>) {
        // Single message from server
        if (data.containsKey('message')) {
          errorMessage = data['message'].toString();
        }
        // Field validation errors from server
        else if (data.containsKey('errors')) {
          final errors = data['errors'];
          if (errors is Map<String, dynamic>) {
            errorMessage = errors.entries
                .map((e) => "${e.key}: ${(e.value as List).join(', ')}")
                .join("\n");
          }
        }
      } else {
        errorMessage = data.toString();
      }
    } else if (e.message != null) {
      errorMessage = e.message!;
    }

    throw Exception(errorMessage);
  } catch (e) {
    print("General Exception: $e");
    throw Exception("Registration failed. Please try again.");
  }
}

// ---------------- LOGIN ----------------
Future<LoginResponse> login({required LoginRequest loginRequest}) async {
  try {
    final response = await _dioClient.dio.post(
      "auth/login",
      data: loginRequest.toJson(),
      options: Options(extra: {"withCredentials": true}),
    );

    // Debug prints
    print("Status Code: ${response.statusCode}");
    print("Response Data: ${response.data}");

    if (response.statusCode == 200 && response.data != null) {
      final accessToken = response.data["accessToken"];
    //  final refreshToken = response.data["refreshToken"];
      final userDetails = response.data["userDetails"];
      final menuData = response.data["menuData"];

      if (accessToken != null) {
        await SecureStorageService.saveAccessToken(accessToken);
       
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
    print("DioException Response: ${e.response?.data}");

    String errorMessage = "Login failed. Please check your credentials.";
    if (e.response != null && e.response!.data != null) {
      if (e.response!.data is Map && e.response!.data["message"] != null) {
        errorMessage = e.response!.data["message"];
      } else {
        errorMessage = e.response!.data.toString();
      }
    }
    throw Exception(errorMessage);
  } catch (e) {
    print("General Exception: $e");
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
