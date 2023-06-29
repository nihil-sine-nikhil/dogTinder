import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../auth/auth_services.dart';
import '../model/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late final AuthenticationServices _authServices;

  UserBloc({required AuthenticationServices authServices})
      : _authServices = authServices,
        super(UserInitial()) {
    on<UserAboutYouChangedEvent>((event, emit) {
      if (event.name.isEmpty) {
        emit(UserAboutYouInvalidState());
      } else {
        emit(UserAboutYouValidState());
      }
    });
    on<UserAboutYouSubmittedEvent>((event, emit) async {
      emit(UserAboutYouLoadingState());
      final _response =
          await _authServices.createUser(event.userModel, event.profilePic);
      if (_response.status) {
        emit(UserCreateUserSuccessfulState(_response.msg ?? "NA"));

        add(LoadUserProfile());
      } else {
        emit(UserCreateUserFailedState(_response.msg ?? "NA"));
      }
    });

    on<LoadUserProfile>((event, emit) async {
      final _authSubscription = await _authServices.loadUserProfile();
      print('kErrorNot2 346   ${_authSubscription.name.toString()}');
      add(UpdateUserProfile(_authSubscription));
    });

    on<UpdateUserProfile>((event, emit) {
      emit(UserProfileLoaded(event.userProfile));
    });

    on<EditProfileSubmittedEvent>((event, emit) async {
      emit(EditProfileLoadingState());
      final _response = await _authServices.editProfile(event.userModel);
      if (_response.status) {
        emit(EditProfileSuccessfulState(_response.msg ?? "NA"));
      } else {
        emit(EditProfileFailedState(_response.msg ?? "NA"));
      }
    });
  }
}
