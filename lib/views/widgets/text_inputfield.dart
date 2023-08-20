// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:tiktok_clone/constant.dart';

class TextInputField extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final bool? isObscured;
  final IconData icon;
  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
     this.isObscured,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const  TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: borderColor)
        ),
             focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: borderColor)
        ),
      ),

      obscureText: isObscured!,
    );
  }
}
