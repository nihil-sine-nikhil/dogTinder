part of 'dog_bloc.dart';

@immutable
abstract class DogState {}

class DogInitial extends DogState {}

class DogImageLoaded extends DogState {
  final DogModel? dog;
  DogImageLoaded(
    this.dog,
  );
}
