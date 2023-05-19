import 'package:flutter/material.dart';
import 'package:from_scratch/constants.dart';
import 'package:from_scratch/widgets/ui/auth_page_header.dart';
import 'package:from_scratch/widgets/ui/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
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
                const CustomTextField(label: "Full Name"),
                const CustomTextField(
                    label: "Email", inputType: TextInputType.emailAddress),
                const CustomTextField(label: "Password", obscure: true),
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
                TextButton(onPressed: () {}, child: const Text("Login Here")),
                const SizedBox(height: 45)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
