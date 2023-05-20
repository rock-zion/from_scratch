import 'package:flutter/material.dart';
import 'package:from_scratch/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.obscure = false,
    this.inputType = TextInputType.none,
    required this.label,
    required this.fieldController,
    super.key,
  });

  final bool obscure;
  final String label;
  final TextInputType inputType;
  final TextEditingController fieldController;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.fieldController,
      keyboardType: widget.inputType,
      obscureText: widget.obscure,
      decoration: InputDecoration(
          // focusedBorder: const InputBorder(borderSide: BorderSide()),
          // border: const InputBorder(),
          label: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: kGreen, width: 1)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kGreen, width: 1))),
    );
  }
}
