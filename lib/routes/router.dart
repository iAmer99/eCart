import 'package:ecart/features/auth/login/binding/login_binding.dart';
import 'package:ecart/features/auth/login/login_screen.dart';
import 'package:ecart/features/auth/register/binding/register_binding.dart';
import 'package:ecart/features/auth/register/register_screen.dart';
import 'package:ecart/features/splash/splash_screen.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:get/get.dart';

class AppRouter {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutesNames.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutesNames.registerScreen,
      binding: RegisterBinding(),
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: AppRoutesNames.loginScreen,
      binding: LoginBinding(),
      page: () => LoginScreen(),
      transition: Transition.fadeIn
    ),
  ];
}
