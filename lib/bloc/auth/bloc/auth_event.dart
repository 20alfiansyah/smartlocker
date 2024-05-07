part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class SignUpUser extends AuthEvent {
  final String email;
  final String password;
  final String username;

  SignUpUser({required this.email, required this.password,required this.username});
}
class SignInUser extends AuthEvent {
  final String email;
  final String password;
  
  SignInUser({required this.email, required this.password});
}
class SignOutUser extends AuthEvent {}