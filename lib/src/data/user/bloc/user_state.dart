part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserAboutYouInvalidState extends UserState {
  @override
  List<Object> get props => [];
}

class UserAboutYouValidState extends UserState {
  @override
  List<Object> get props => [];
}

class UserAboutYouLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class EditProfileLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserCreateUserSuccessfulState extends UserState {
  UserCreateUserSuccessfulState(this.msg);
  String msg;
  @override
  List<Object> get props => [msg];
}

class EditProfileSuccessfulState extends UserState {
  EditProfileSuccessfulState(this.msg);
  String msg;
  @override
  List<Object> get props => [msg];
}

class UserCreateUserFailedState extends UserState {
  UserCreateUserFailedState(this.msg);
  String msg;

  @override
  List<Object> get props => [msg];
}

class EditProfileFailedState extends UserState {
  EditProfileFailedState(this.msg);
  String msg;

  @override
  List<Object> get props => [msg];
}

class UserProfileLoaded extends UserState {
  final UserModel userProfile;
  UserProfileLoaded(
    this.userProfile,
  );
  @override
  List<Object> get props => [userProfile];
}
