import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:from_scratch/constants.dart';
import 'package:from_scratch/models/auth.dart';
import 'package:from_scratch/widgets/ui/auth_page_header.dart';
import 'package:from_scratch/widgets/ui/custom_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  handleLogin() async {
    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      setState(() {
        loading = false;
      });
      context.go("/home");
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("You have supplied a wrong password. Please try again"),
        ));
      } else if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("There appears to be no user associated with this email"),
        ));
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginModel>(context);

    return Scaffold(
      body: ListView(
        children: [
          const AuthPageHeader("Welcome Back!"),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create an account to continue",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: kGrey)),
                  // const SizedBox(height: 30),
                  CustomTextField(
                      handleValidator: (String? p0) {
                        return p0 != null && p0.isEmpty
                            ? 'Email cannot be empty'
                            : null;
                      },
                      handleChange: (p0) => provider.email = p0,
                      fieldController: emailController,
                      label: "Email",
                      inputType: TextInputType.emailAddress),
                  CustomTextField(
                      handleValidator: (String? p0) {
                        return p0 != null && p0.isEmpty
                            ? 'Password cannot be empty'
                            : p0 != null && p0.length < 5
                                ? "Password length cannot be less than 5"
                                : null;
                      },
                      handleChange: (p0) => provider.password = p0,
                      fieldController: passwordController,
                      label: "Password",
                      obscure: true),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    child: const Text("Create Account"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) handleLogin();
                    },
                  ),
                  const SizedBox(height: 30),
                  const Center(
                      child: Text(
                    "Already have an account?",
                    textAlign: TextAlign.center,
                  )),
                  TextButton(
                      onPressed: () {
                        context.go("/");
                      },
                      child: const Text("Create Account Here")),
                  const SizedBox(height: 45)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
