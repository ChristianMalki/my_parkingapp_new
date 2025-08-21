import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:continue_parkingapp_flutter/repositories/Person_Repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String password;
  final String email;

  AuthLogin({required this.password, required this.email, required String name});
}

final class AuthLogout extends AuthEvent {}

final class AuthSubscribe extends AuthEvent {}

final class AuthRegister extends AuthEvent {
  final String password;
  final String email;
  final String username;
  final String personnummer;
  final String? id;

  AuthRegister(
      {required this.password, required this.email, required this.username,required this.personnummer, this.id}) ;
}

sealed class AuthState {}

final class AuthInitial extends AuthState {
  AuthInitial();
}

final class AuthSignedIn extends AuthState {
  AuthSignedIn();
}
final class AuthSignedOut extends AuthState {
  AuthSignedOut();
}

final class AuthSuccess extends AuthState {
  final String uid;
  AuthSuccess(this.uid);
}

final class AuthPending extends AuthState {
  AuthPending();
}

final class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        switch (event) {
          case AuthLogin(:var email, :var password):
            emit(AuthPending());

            try {
              final credential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);

              final user = credential.user;

              if (user == null) {
                throw Exception("No user found");
              }
              emit (AuthSuccess(user.uid));
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                emit(AuthFailure('No user found for that email.'));
              } else if (e.code == 'wrong-password') {
                emit(AuthFailure('Wrong password provided for that user.'));
              } else {
                emit(AuthFailure(e.code));
              } 
            } catch (e) {
              emit(AuthFailure(e.toString()));
            }
            

          case AuthRegister(:var username, :var password, :var email, :var personnummer, :var id):
            emit(AuthPending());

            try {
              final credential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );

              final user = credential.user;

              if (user == null) {
                throw Exception("No user found");
              }
               await PersonRepository().create(
                Person(
                  id: user.uid,
                  email: email,
                  name: username,
                  personnummer: personnummer,

                ),
              );

             
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                emit(AuthFailure('The password provided is too weak.'));
              } else if (e.code == 'email-already-in-use') {
                emit(AuthFailure('The account already exists for that email.'));
              } else {
                emit(AuthFailure(e.code));
              }
            } catch (e) {
              emit(AuthFailure(e.toString()));
            }

          case AuthLogout():
            await FirebaseAuth.instance.signOut();
          case AuthSubscribe():
            await emit.forEach(FirebaseAuth.instance.authStateChanges(),
                onData: (user) {
              if (user != null) {
                return AuthSuccess(user.uid);
              } else {
                return AuthSignedOut();
              }
            });
        }
      },
    );
  }

  login({required String email, required String password}) {
    add(AuthLogin(email: email, password: password, name: ''));
  }

  register(
      {required String username,
      required String password,
      required String email}) {
    add(AuthRegister(password: password, username: username, email: email, personnummer: '', id: null));
  }

  logout() {
    add(AuthLogout());
  }
}