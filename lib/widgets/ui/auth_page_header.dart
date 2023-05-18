import 'package:flutter/material.dart';

class AuthPageHeader extends StatelessWidget {
  const AuthPageHeader(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
          image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              image: AssetImage(
                  "assets/images/photo-1520981825232-ece5fae45120.jpeg"))),
      height: 285,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset(
            "assets/images/Logo.png",
            height: 28,
          ),
          const SizedBox(height: 45),
          Text(text, style: Theme.of(context).textTheme.displayLarge),
        ]),
      ),
    );
  }
}
