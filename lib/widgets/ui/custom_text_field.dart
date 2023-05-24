import 'package:flutter/material.dart';
import 'package:from_scratch/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.obscure = false,
    this.inputType = TextInputType.none,
    this.disableField = false,
    required this.handleValidator,
    required this.handleChange,
    required this.label,
    required this.fieldController,
    super.key,
  });

  final bool obscure;
  final bool disableField;
  final String label;
  final TextInputType inputType;
  final TextEditingController fieldController;
  final void Function(String) handleChange;
  final String? Function(String?) handleValidator;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.handleValidator,
      onChanged: widget.handleChange,
      controller: widget.fieldController,
      keyboardType: widget.inputType,
      obscureText: widget.obscure,
      enabled: !widget.disableField,
      decoration: InputDecoration(
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
