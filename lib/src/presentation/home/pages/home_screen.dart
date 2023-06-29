import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/src/data/dog/bloc/dog_bloc.dart';
import 'package:task/src/presentation/widgets/dancing_dots.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DogBloc, DogState>(
      builder: (context, state) {
        return Scaffold(
            body: (state is DogImageLoaded)
                ? Column(children: [
                    Image.network(state.dog!.pic!),
                    Row(
                      children: [],
                    )
                  ])
                : Center(
                    child: JumpingDots(),
                  ));
      },
    );
  }
}
