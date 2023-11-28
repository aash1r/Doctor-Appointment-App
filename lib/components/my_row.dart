import 'package:flutter/material.dart';

import '../services/helpers.dart';

class MyRow extends StatelessWidget {
  const MyRow({super.key, required this.labelText});
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          labelText ?? "",
          style: Helpers.colour,
        ),
      ],
    );
  }
}
