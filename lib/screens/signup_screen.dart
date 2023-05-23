import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:from_scratch/constants.dart';
import 'package:from_scratch/models/auth.dart';
import 'package:from_scratch/widgets/ui/auth_page_header.dart';
import 'package:from_scratch/widgets/ui/custom_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void handleSignup() async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Account created successfully"),
      ));
      context.go("/home");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The password provided is too weak."),
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("This email is already in use"),
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
    final provider = Provider.of<SignupModel>(context);
    return Scaffold(
      body: ListView(
        children: [
          const AuthPageHeader("Start from Scratch"),
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
                    inputType: TextInputType.emailAddress,
                  ),

                  CustomTextField(
                    handleValidator: (String? p0) {
                      return p0 != null && p0.isEmpty
                          ? 'Name cannot be empty'
                          : null;
                    },
                    handleChange: (p0) => provider.fullName = p0,
                    fieldController: fullNameController,
                    label: "Full Name",
                    inputType: TextInputType.text,
                  ),

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
                    obscure: true,
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    child: !loading
                        ? const Text("Create Account")
                        : const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                    onPressed: () {
                      // create an account with google password
                      if (_formKey.currentState!.validate()) {
                        handleSignup();
                      }
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
                        context.go("/login");
                      },
                      child: const Text("Login Here")),
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
