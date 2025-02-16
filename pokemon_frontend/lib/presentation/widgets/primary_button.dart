
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 50.0, // Altura por defecto
    this.width,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: width ?? double.infinity,

      height: height,

      child: ElevatedButton(

        onPressed: onPressed,
        
        style: ElevatedButton.styleFrom(

          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),

          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
          
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}