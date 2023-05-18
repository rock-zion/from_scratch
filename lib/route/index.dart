import 'package:from_scratch/screens/login_screen.dart';
import 'package:from_scratch/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
  GoRoute(path: "/", builder: (context, state) => const SignupScreen())
]);
