import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthDataLoading()) {
    on<AuthLogin>((event, emit) async {
      try {
        emit(AuthSigningIn());
        await authRepository.loginUser(event.user);
        emit(AuthLoginSuccess());
      } catch (e) {
        emit(AuthOperationFailure(reason: e.toString()));
      }
    });
  }
}
