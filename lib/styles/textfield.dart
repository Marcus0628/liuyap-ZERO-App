// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool isPassword;
  final double padding;
  final Function()? onTapSuffixIcon;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPassword,
    this.padding = 40.0, 
    this.onTapSuffixIcon,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.padding, right: widget.padding),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(11.0),
        child: TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _isObscure : false,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(11.0)),
              borderSide: BorderSide(color: Color(0xffFFFFFF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(11.0)),
              borderSide: BorderSide(color: Color(0xff414141)),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.0)),
                borderSide: BorderSide.none),
            hintText: widget.hintText,
            hintStyle: TextStyle(fontFamily: 'PathwayGothicOne', fontSize: 18),
            contentPadding: EdgeInsets.all(17.0),
            // Add suffix icon to toggle password visibility
            suffixIcon: widget.isPassword? IconButton(
              icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ):null
          ),
        ),
      ),
    );
  }
}

