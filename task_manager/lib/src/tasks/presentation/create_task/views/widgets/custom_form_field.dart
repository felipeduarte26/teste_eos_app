import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  const CustomFormField({
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          // border: const OutlineInputBorder(),
        ),
      );
}
