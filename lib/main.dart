import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/src/app.dart';
import 'package:task/src/data/auth/auth_services.dart';
import 'package:task/src/data/auth/bloc/auth_bloc.dart';
import 'package:task/src/data/dog/bloc/dog_bloc.dart';
import 'package:task/src/data/user/bloc/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthenticationBloc(
          authServices: AuthenticationServices(),
        )..add(
            AuthenticationStatusChangedEvent(),
          ),
      ),
      BlocProvider(
        create: (context) => UserBloc(
          authServices: AuthenticationServices(),
        )..add(LoadUserProfile()),
      ),
      BlocProvider(
        create: (context) => DogBloc()..add(LoadDogImage()),
      ),
    ], child: const MyApp()),
  );
}
