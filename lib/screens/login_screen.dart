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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginModel>(context);

    return Scaffold(
      body: ListView(
        children: [
          const AuthPageHeader("Start from Scratch"),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                    fieldController: emailController,
                    label: "Email",
                    inputType: TextInputType.emailAddress),
                CustomTextField(
                    fieldController: passwordController,
                    label: "Password",
                    obscure: true),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: const Text("Create Account"),
                  onPressed: () {},
                ),
                const SizedBox(height: 30),
                const Center(
                    child: Text(
                  "Already have an account?",
                  textAlign: TextAlign.center,
                )),
                TextButton(
                    onPressed: () {
                      context.go("/login");
                    },
                    child: const Text("Create Account Here")),
                const SizedBox(height: 45)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
