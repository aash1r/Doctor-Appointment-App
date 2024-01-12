import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextfield extends StatefulWidget {
  const MyTextfield({
    super.key,
    required this.hintText,
    this.icon,
    this.onTap,
    required this.onChanged,
    this.value,
    this.value1,
    this.tap,
  });

  final Function()? tap;
  final Function()? onTap;
  final Function(String) onChanged;
  final IconData? icon;
  final String hintText;
  final String? Function(String?)? value;
  final String? Function(String?)? value1;

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  bool obsecureText = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.tap,
      onChanged: widget.onChanged,
      cursorColor: Colors.black38,
      obscureText: widget.icon != null ? false : obsecureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFB28CFF)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFB28CFF)),
        ),
        suffixIconColor: Colors.blue.shade600,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obsecureText = !obsecureText;
            });
          },
          child: Icon(
            widget.icon ??
                (obsecureText ? Icons.visibility : Icons.visibility_off),
          ),
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.black38, fontSize: 13),
      ),
    );
  }
}
