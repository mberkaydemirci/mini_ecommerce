import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double? height;
  final Widget? buttonIcon;
  final VoidCallback onPressed;

  const LoginButton(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.textColor,
      required this.radius,
      this.height: 40,
      this.buttonIcon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //buttonIcon!, //spreads
              if (buttonIcon != null) ...[
                buttonIcon!,
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
                Opacity(
                  opacity: 0,
                  child: buttonIcon,
                )
              ],
              if (buttonIcon == null) ...[
                Container(),
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container()
              ],
              /* Text(
                buttonText,
                style: TextStyle(color: textColor),
              ),
              Opacity(opacity: 0, child: buttonIcon),*/
            ],
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
