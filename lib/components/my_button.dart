import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      this.ontap,
      required this.text,
      required this.width,
      this.height,
      required this.font});
  final void Function()? ontap;
  final String? text;
  final double? width;
  final double? height;
  final double? font;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.blue, offset: Offset(0, 8), blurRadius: 5)
            ],
            color: const Color(0xFFB28CFF),
            borderRadius: BorderRadius.circular(10)),
        width: width ?? 200,
        height: height ?? 100,
        child: Center(
          child: Text(
            text ?? "",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: font ?? 15),
          ),
        ),
      ),
    );
  }
}
