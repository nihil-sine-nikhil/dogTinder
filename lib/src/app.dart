import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/navigation/router.dart';
import 'app/navigation/routes.dart';
import 'data/auth/bloc/auth_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    final AppRouter appRouter = AppRouter(
      routes: AppRoutes.routes,
      notFoundHandler: AppRoutes.routeNotFoundHandler,
    );
    appRouter.setupRoutes();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Task',
                navigatorKey: navigatorKey,
                onGenerateRoute: AppRouter.router.generator,
                // home: const LandingScreen(),
                builder: (context, widget) {
                  return BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      if (state is AuthenticationLoggedInState) {
                        AppRouter.navigateTo(AppRoutes.homeRoute.route,
                            clearStack: true);
                      }
                      if (state is AuthenticationUnknownState) {
                        AppRouter.navigateTo(
                            AppRoutes.enterPhoneNumberScreenRoute.route,
                            clearStack: true);
                      }
                    },
                    builder: (context, state) {
                      return widget!;
                    },
                  );
                },
              ),
            );
          }

          return const CircularProgressIndicator();
        });
  }
}
