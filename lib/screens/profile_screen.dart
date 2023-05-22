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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("My Kitchen",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: kDark)),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: kDark),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: const [Divider()],
          )
        ],
      ),
    ));
  }
}
