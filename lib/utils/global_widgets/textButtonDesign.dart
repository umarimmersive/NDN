import 'package:flutter/material.dart';

class TextButtonDesign extends StatelessWidget {
  final IconButton? suffixIcon;
  final String text;
  final double height, textSize;
  final bool readOnly;
  final bool loading;
  final MaterialStateProperty<Color>? backgroundColor;
  final Color fontColor;
  final Function()? onSubmit;

  TextButtonDesign({
    required this.onSubmit,
    this.fontColor = Colors.white,
    this.backgroundColor,
    this.suffixIcon,
    required this.text,
    this.textSize = 20.0,
    this.height = 50.0,
    this.readOnly=false,
    this.loading = false,
  });

  Widget get progressBar => const Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white), //done
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: backgroundColor,
        ),
        onPressed: onSubmit,
        child: loading
            ? progressBar
            : Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textSize,
                  color: fontColor,
                ),
              ),
      ),
    );
  }
}
