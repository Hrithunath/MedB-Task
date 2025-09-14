part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// Register event
final class RegisterEvent extends AuthEvent {
  final RegisterRequest registerRequest;
   RegisterEvent({required this.registerRequest});
}

// Login event
final class LoginEvent extends AuthEvent {
  final LoginRequest loginRequest;
   LoginEvent({required this.loginRequest});
}

// Logout event
final class LogoutEvent extends AuthEvent {
   LogoutEvent();
}
