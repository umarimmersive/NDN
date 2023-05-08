import 'package:flutter/material.dart';

class RoundedFilledButton extends StatelessWidget {
  final VoidCallback? ontap;
  final String? label;
  final Color? color;
  final Color? labelColor;
  final double? height;
  final double? width;
  final Icon? icon;
  final double? fontSize;

  const RoundedFilledButton({
    Key? key,
    this.ontap,
    this.label,
    this.labelColor,
    this.height = 50,
    this.fontSize = 16,
    this.width,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
        child: Container(
          height: height,
          width: width ?? double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color ?? Theme.of(context).primaryColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon!,
                if (icon != null) const SizedBox(width: 10),
                Text(
                  label ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: labelColor ?? Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class IconBtnRounded extends StatelessWidget {
  final VoidCallback? ontap;
  final Widget? icon;
  final double? left;
  final double? right;

  const IconBtnRounded({Key? key, this.ontap, this.icon, this.left, this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.zero,
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(left ?? 0),
            topRight: Radius.circular(right ?? 0),
            bottomLeft: Radius.circular(right ?? 0),
            bottomRight: Radius.circular(left ?? 0),
          ),
          border: Border.all(
            color: const Color(0xfff0f5f9),
            width: 1,
          ),
          color: Colors.white,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
