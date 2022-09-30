import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '/blocs/blocs.dart';
import '/models/models.dart';
import '/repositories/repositories.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;
  StreamSubscription? _authSubscription;

  UserBloc({
    required AuthBloc authBloc,
    required UserRepository userRepository,
  })  : _authBloc = authBloc,
        _userRepository = userRepository,
        super(UserLoading()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user is AuthUserChanged) {
        if (state.user != null) {
          add(LoadUser(state.authUser));
        }
      }
    });
  }

  void _onLoadUser(
      LoadUser event,
      Emitter<UserState> emit,
      ) {
    if (event.authUser != null) {
      _userRepository.getUser(event.authUser!.uid).listen((user) {
        add(
          UpdateUser(user: user),
        );
      });
    } else {
      emit(UserUnauthenticated());
    }
  }

  void _onUpdateUser(
      UpdateUser event,
      Emitter<UserState> emit,
      ) {
    _userRepository.updateUser(event.user);
    emit(UserLoaded(user: event.user));
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}