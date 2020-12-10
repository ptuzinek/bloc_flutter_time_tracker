import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton(
      {this.color,
      this.borderRadius: 4.0,
      this.onPressed,
      this.child,
      this.height: 50.0})
      : assert(borderRadius != null);

  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
          color: color,
          disabledColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}
