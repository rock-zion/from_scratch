import 'package:from_scratch/screens/edit_profile_screen.dart';
import 'package:from_scratch/screens/home_screen.dart';
import 'package:from_scratch/screens/login_screen.dart';
import 'package:from_scratch/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const SignupScreen()),
  GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
  GoRoute(path: "/home", builder: (context, state) => const HomeScreen()),
  GoRoute(
      path: "/editprofile",
      builder: (context, state) => const EditProfileScreen()),
]);
