import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:from_scratch/constants.dart';
import 'package:from_scratch/widgets/ui/custom_text_field.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  late Stream<QuerySnapshot> _userStream;
  bool _loadingUpdate = false;
  final _formKey = GlobalKey<FormState>();
  var userDocument;
  final db = FirebaseFirestore.instance;

  TextEditingController bioController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userStream = db
        .collection("users")
        .where("uuid", isEqualTo: currentUser?.uid)
        .snapshots();
  }

  void handleUpdateUserData(BuildContext context) async {
    setState(() {
      _loadingUpdate = true;
    });
    try {
      await db
          .collection("users")
          .doc(currentUser?.uid)
          .update({"bio": bioController.text, "phone": phoneController.text});

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have successfully updated your profile"),
      ));

      setState(() {
        _loadingUpdate = false;
      });
    } catch (e) {
      setState(() {
        _loadingUpdate = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return StreamBuilder(
      stream: _userStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        final snapshotData = snapshot.data!.docs[0];

        snapshotData.data().toString().contains('fullName')
            ? fullNameController.text = snapshotData['fullName']
            : fullNameController.text = "";

        snapshotData.data().toString().contains('bio')
            ? bioController.text = snapshotData['bio'] ?? ""
            : bioController.text = "";

        snapshotData.data().toString().contains('email')
            ? emailController.text = snapshotData['email'] ?? ""
            : emailController.text = "";

        snapshotData.data().toString().contains('phone')
            ? phoneController.text = snapshotData['phone'] ?? ""
            : phoneController.text = "";

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 121,
                        child: TextButton.icon(
                          icon: SvgPicture.asset(
                            "assets/images/icons/ArrowLeft.svg",
                            width: 12,
                            height: 12,
                          ),
                          onPressed: () {
                            context.go("/home");
                          },
                          label: Text(
                            "Back to Profile",
                            style: textTheme.bodySmall?.copyWith(color: kDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("Edit Profile", style: textTheme.displayLarge),
                  const SizedBox(height: 22),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: kGreen,
                        radius: 50,
                        child: Text(
                          "${snapshotData['fullName'].substring(0, 1)}",
                          style:
                              textTheme.displayLarge?.copyWith(color: kWhite),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            
                          },
                          child: const Text("Edit Profile Picture")),
                      Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                handleValidator: (p0) {
                                  return null;
                                },
                                handleChange: (p0) {},
                                label: "Full Name",
                                fieldController: fullNameController,
                              ),
                              CustomTextField(
                                handleValidator: (p0) {
                                  return p0 != null && p0.isEmpty
                                      ? "Bio cannot be empty cannot be empty"
                                      : null;
                                },
                                handleChange: (p0) {},
                                label: "Bio",
                                fieldController: bioController,
                              ),
                              const SizedBox(height: 44),
                              Text("Edit Profile",
                                  style: textTheme.displayMedium),
                              const SizedBox(height: 11),
                              CustomTextField(
                                disableField: true,
                                handleValidator: (p0) {
                                  return null;
                                },
                                handleChange: (p0) {},
                                label: "Email",
                                fieldController: emailController,
                              ),
                              CustomTextField(
                                handleValidator: (p0) {
                                  return p0 != null && p0.isEmpty
                                      ? "Phone number cannot be empty cannot be empty"
                                      : null;
                                },
                                handleChange: (p0) {},
                                label: "Phone",
                                fieldController: phoneController,
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      handleUpdateUserData(context);
                                    }
                                  },
                                  child: !_loadingUpdate
                                      ? const Text("Save Profile")
                                      : const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        ))
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
