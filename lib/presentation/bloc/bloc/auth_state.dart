part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class RegisterLoadedState extends AuthState {
  final String message;
  RegisterLoadedState({required this.message});
}

// For Login success
class LoginLoadedState extends AuthState {
  final UserModel user;
  final List<ModuleModel> menu;
  LoginLoadedState({required this.user, required this.menu});
}

class LogoutLoadedState extends AuthState {
  final String message;
  LogoutLoadedState({required this.message});
}

class AuthErrorState extends AuthState{
  final String errorMessage;

  AuthErrorState({required this.errorMessage});
  
}