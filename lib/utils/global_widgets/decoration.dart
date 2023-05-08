import 'dart:ui';

import 'package:flutter/material.dart';


class DecorationLocal {
  static InputDecoration textInput(
    String label,
    String hint, {
    EdgeInsetsGeometry? contentPad,
  }) =>
      InputDecoration(
        //hoverColor: greenC,
        //prefixStyle: TextStyle(color:Colors.black,fontSize:14),
        //errorText: errorText,
        counterText: "",
        contentPadding: contentPad ?? const EdgeInsets.fromLTRB(10, 20, 10, 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.amber),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: label,
        //labelStyle: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400,color:greenC ),
        //errorText: errorText,
      );

  static Padding title(
    String label, {
    double? fs,
    Color? color,
    FontWeight? fW,
    double? vPad,
    double? hPad,
    TextAlign? textAlign,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: vPad ?? 15.0, horizontal: hPad ?? 10),
        child: Text(
          label,
          textAlign: textAlign ?? TextAlign.left,
          style: TextStyle(
            color: color ?? Colors.amber,
            fontSize: fs ?? 14,
            fontWeight: fW ?? FontWeight.w700,
          ),
        ),
      );

  static Padding rowTwoTextSB({
    required String label1,
    required String label2,
    Color? label1color,
    Color? label2color,
    FontWeight? label1FW,
    FontWeight? label2FW,
    Widget? label1W,
    Widget? label2W,
    double? label1FS,
    double? label2FS,
    EdgeInsetsGeometry? padding,
  }) =>
      Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            label1W ??
                Text(
                  label1,
                  style: TextStyle(
                      color: label1color ?? const Color(0xff848484),
                      fontSize: label1FS ?? 12,
                      fontWeight: label1FW ?? FontWeight.normal),
                ),
            label2W ??
                Text(
                  label2,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: label2color ?? const Color(0xff848484),
                      fontSize: label2FS ?? 12,
                      fontWeight: label2FW ?? FontWeight.normal),
                ),
          ],
        ),
      );
}
