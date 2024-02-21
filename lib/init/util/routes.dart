
import './export_pages.dart';

class PageRoutes {
static  Map<String, WidgetBuilder> routes = {
    "/homepage": (context) => const HomePage(),
    "/login": (context) => const LoginPageWithEmail(),
    "/splash": (context) => const SplashPage(),
    "/register": (context) => const Registerpage(),
    "/password_reset": (context) => const PasswordResetPage(),
  };

  static const String login = "/login";
  static const String splash = "/splash";
  static const String register = "/register";
  static const String passwordReset = "/password_reset";
  static const String homepage = "/homepage";
}
