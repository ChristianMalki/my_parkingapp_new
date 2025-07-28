import 'package:flutter_bloc/flutter_bloc.dart';

sealed class AuthEvent {}

class AuthLogin extends AuthEvent{
  final String name;

  AuthLogin({required this.name});
  
}

class AuthLogout extends AuthEvent {
  
}

sealed class AuthState {}

final class AuthInitial extends AuthState {
  AuthInitial();
}
final class AuthPending extends AuthState {}

final class AuthSuccess extends AuthState{
  final String name;

  AuthSuccess({required this.name});
}

final class AuthSignedOut extends AuthState{

  AuthSignedOut();
}

final class AutFail extends AuthState{
  final String error;

  AutFail({required this.error});
}


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
on<AuthEvent>((event, emit) async{
  switch (event) {
    case AuthLogin():
    emit(AuthPending());
    await Future.delayed(const Duration(
     microseconds: 500));
     emit(AuthSuccess(name: event.name));
     case AuthLogin():
     emit (AuthSignedOut());
    case AuthLogout():
      // TODO: Handle this case.
      throw UnimplementedError();

}  
  });
  }


   

   login(String name) {
    emit(AuthSuccess(name: name));
   }

   logout() {
    emit(AuthSignedOut());
   }
}