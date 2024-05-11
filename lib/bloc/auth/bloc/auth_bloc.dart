import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:smartlocker/models/User.dart';
import 'package:smartlocker/services/auth_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {

    });
    on<SignUpUser>((event, emit) async {
      emit(AuthLoading());
      try {
        final UserModel? user = await authService.signUpUser(event.email, event.password, event.username);
        if (user != null) {
          emit(AuthSuccess(user: user));
        } else {
          emit(const AuthError(message: 'create user failed'));
        }
      } catch (e) {
        emit(const AuthError(message: 'An error occurred'));
      }
    });


    on<SignInUser>((event, emit) async {
      emit (AuthLoading());
      try {
        final UserModel? user = await authService.signInUser(event.email, event.password);
        if (user!=null) {
          emit(AuthSuccess(user: user));
        }
        else {
          emit(const AuthError(message: 'cant sign in'));
        }
      } catch (e) {
         emit(const AuthError(message: 'An error occurred'));
      }
    });

    on<SignOutUser>((event, emit) async {
      emit (AuthLoading());
      try {
        await FirebaseAuth.instance.signOut();
        emit(AuthInitial());
      } catch (e) {
         emit(const AuthError(message: 'An error occurred'));
      }
    });
  }
}
