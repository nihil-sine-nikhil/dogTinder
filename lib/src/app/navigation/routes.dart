import 'package:fluro/fluro.dart';

import '../../presentation/auth/enter_name/enter_name_screen.dart';
import '../../presentation/auth/enter_phone/enter_phone_number_screen.dart';
import '../../presentation/auth/verify_otp/verify_otp_screen.dart';
import '../../presentation/home/pages/home_screen.dart';
import '../../presentation/page_not_found/route_not_found_screen.dart';
import '../../presentation/splash/splash_screen.dart';

mixin AppRoutes {
  static final splashRoute = AppRoute(
    '/',
    Handler(
      handlerFunc: (context, parameters) => const SplashScreen(),
    ),
  );
  static final verifyOTPScreenRoute = AppRoute(
    '/verify-phone/:code/:phone',
    Handler(
      handlerFunc: (context, parameters) => VerifyOTPScreen(
        verificationCode: parameters['code']?[0],
        phone: parameters['phone']?[0],
      ),
    ),
  );
  static final enterNameScreenRoute = AppRoute(
    '/enter-name',
    Handler(
      handlerFunc: (context, parameters) => EnterNameScreen(),
    ),
  );
  static final enterPhoneNumberScreenRoute = AppRoute(
    '/enter-phone',
    Handler(
      handlerFunc: (context, parameters) => EnterPhoneNumberScreen(),
    ),
  );
  static final homeRoute = AppRoute(
    '/home',
    Handler(
      handlerFunc: (context, parameters) => const HomeScreen(),
    ),
  );

  // Not Found Route
  static final routeNotFoundHandler = Handler(
    handlerFunc: (context, params) => const RouteNotFoundScreen(),
  );

  /// Primitive function to get one param detail route (i.e. id).
  static String getRoute(String route, Map<String, String> slugParameters) {
    String newRoute = route;
    slugParameters.forEach(
      (key, value) {
        newRoute = newRoute.replaceAll(':$key', value);
      },
    );
    return newRoute;
  }

  // Routes
  static final List<AppRoute> routes = [
    splashRoute,
    enterPhoneNumberScreenRoute,
    enterNameScreenRoute,
    verifyOTPScreenRoute,
    homeRoute,
  ];
}
