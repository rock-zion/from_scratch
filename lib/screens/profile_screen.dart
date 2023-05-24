import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:from_scratch/constants.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _progressController = true;
        _progressController = false;
      });
    } catch (e) {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
        child: _progressController
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("My Kitchen",
                            style:
                                textTheme.displayLarge?.copyWith(color: kDark)),
                        SizedBox(
                          width: 96,
                          // constraints: const BoxConstraints(minWidth: 77),
                          child: TextButton.icon(
                            icon: SvgPicture.asset(
                              "assets/images/icons/Settings.svg",
                              width: 20,
                              height: 20,
                            ),
                            onPressed: () {
                              context.go("/settings");
                            },
                            label: Text(
                              "Settings",
                              style:
                                  textTheme.bodySmall?.copyWith(color: kDark),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: kGreen,
                                  radius: 41,
                                  child: Text(
                                    "${userData["fullName"]?.substring(0, 1)}",
                                    style: textTheme.displayLarge
                                        ?.copyWith(color: kWhite),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text("${userData["fullName"]}",
                                        style: textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700)),
                                    Text("Bio", style: textTheme.bodySmall),
                                    const SizedBox(height: 11),
                                    Row(
                                      children: [
                                        Text("584 followers",
                                            style: textTheme.bodySmall),
                                        const SizedBox(width: 10),
                                        SvgPicture.asset(
                                            "assets/images/icons/dot.svg"),
                                        const SizedBox(width: 10),
                                        Text("584 likes",
                                            style: textTheme.bodySmall)
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () => context.go("/editprofile"),
                                icon: SvgPicture.asset(
                                    "assets/images/icons/Edit.svg"))
                          ],
                        ),
                        const SizedBox(height: 26),
                        const Divider()
                      ],
                    )
                  ],
                ),
              )
              ));
  }
}
