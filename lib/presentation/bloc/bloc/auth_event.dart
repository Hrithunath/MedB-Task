part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class RegisterEvent extends AuthEvent {
  final RegisterRequest registerRequest;
   RegisterEvent({required this.registerRequest});
}

final class LoginEvent extends AuthEvent {
  final LoginRequest loginRequest;
   LoginEvent({required this.loginRequest});
}

final class LogoutEvent extends AuthEvent {
   LogoutEvent();
}
