import 'package:flutter/material.dart';

class BottomBarWithButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const BottomBarWithButton({Key? key, required this.buttonText, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 0.0,bottom: 0.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0,right: 0.0),
            child: Text(buttonText),
          ),
        ),
      ),
    );
  }
}
