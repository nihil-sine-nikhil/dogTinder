import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/src/data/dog/model/dog_model.dart';

import '../services/dog_services.dart';

part 'dog_event.dart';
part 'dog_state.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  final DogServices _services = DogServices();

  DogBloc() : super(DogInitial()) {
    on<LoadDogImage>((event, emit) async {
      final response = await _services.loadDog();
      emit(DogImageLoaded(response));
    });
  }
}
