import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;

  const AppButton({super.key, required this.onPressed, required this.label});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15
        ),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: Color.fromARGB(15, 0, 0, 0)
          ),
        ),
      ),
      child: Text(widget.label),
    );
  }
}
