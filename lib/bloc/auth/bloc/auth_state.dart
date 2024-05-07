part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object>get props => [];
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
final class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}
final class AuthSuccess extends AuthState {
  final UserModel user;
  const AuthSuccess({required this.user});
  @override
  List<Object> get props => [user];
}
final class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
  @override
  List<Object> get props => [message];
}
