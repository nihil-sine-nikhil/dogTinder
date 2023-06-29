part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserAboutYouSubmittedEvent extends UserEvent {
  final UserModel userModel;
  File? profilePic;
  UserAboutYouSubmittedEvent(this.userModel, {this.profilePic});
  @override
  List<Object?> get props => [userModel, profilePic];
}

class EditProfileSubmittedEvent extends UserEvent {
  final UserModel userModel;
  EditProfileSubmittedEvent(
    this.userModel,
  );
  @override
  List<Object?> get props => [
        userModel,
      ];
}

class UserAboutYouChangedEvent extends UserEvent {
  final String name;
  UserAboutYouChangedEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class UpdateUserProfile extends UserEvent {
  final UserModel userProfile;

  UpdateUserProfile(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class LoadUserProfile extends UserEvent {
  @override
  List<Object> get props => [];
}
