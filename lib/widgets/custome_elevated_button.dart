import 'package:flutter/material.dart';

class CustomeElevatedButton extends StatelessWidget {
  const CustomeElevatedButton(
      {super.key, required this.label, required this.onPressed});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(fixedSize: Size(screenWidth, 56)),
        child: Text(label,style: Theme.of(context).textTheme.titleLarge,));
  }
}
