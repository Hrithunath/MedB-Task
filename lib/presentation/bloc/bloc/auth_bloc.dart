import 'package:bloc/bloc.dart';
import 'package:med_b/data/services/auth_service.dart';
import 'package:med_b/domain/models/login_model/login_request_model.dart';
import 'package:med_b/domain/models/register_model/register_request_model.dart';

import 'package:med_b/data/services/storage_service.dart';
import 'package:med_b/domain/models/user_menu_model/modeule_model.dart';
import 'package:med_b/domain/models/user_menu_model/user_model.dart';
import 'package:meta/meta.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices authServices = AuthServices();

  AuthBloc() : super(AuthInitial()) {
    
    // ---------------- LOGIN ----------------
    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final response = await authServices.login(loginRequest: event.loginRequest);

        // Save tokens
       await SecureStorageService.saveAccessToken(response.accessToken);
if (response.refreshToken != null) {
  await SecureStorageService.saveRefreshToken(response.refreshToken!);
}
await SecureStorageService.saveLoginKey(response.loginKey);
await SecureStorageService.saveUserDetails(response.userDetails);
await SecureStorageService.saveMenuData(response.menuData);

        emit(LoginLoadedState(
          user: response.userDetails,
          menu: response.menuData,
        ));
      } catch (e) {
        emit(AuthErrorState(errorMessage: e.toString()));
      }
    });

    // ---------------- REGISTER ----------------
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final response = await authServices.register(request: event.registerRequest);
        emit(RegisterLoadedState(message: response.message));
      } catch (e) {
        emit(AuthErrorState(errorMessage: e.toString()));
      }
    });

    // ---------------- LOGOUT ----------------
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final success = await authServices.logout();
        if (success) {
          emit(LogoutLoadedState(message: "Logout successful"));
        } else {
          emit(AuthErrorState(errorMessage: "Logout failed"));
        }
      } catch (e) {
        emit(AuthErrorState(errorMessage: e.toString()));
      }
    });
  }
}
