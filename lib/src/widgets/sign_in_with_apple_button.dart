import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Style according to
/// https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/
class SignInWithAppleButton extends StatelessWidget {
  const SignInWithAppleButton({
    Key key,
    @required this.onPressed,
    this.text = 'Sign in with Apple',
    this.height = 44,
    this.style = SignInWithAppleButtonStyle.dark,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.iconAlignment = IconAlignment.center,
  })  : assert(text != null),
        assert(height != null),
        assert(style != null),
        assert(borderRadius != null),
        assert(iconAlignment != null),
        super(key: key);

  final VoidCallback onPressed;

  final String text;

  final double height;

  final SignInWithAppleButtonStyle style;

  final BorderRadius borderRadius;

  final IconAlignment iconAlignment;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        style == SignInWithAppleButtonStyle.dark ? Colors.black : Colors.white;
    final contrastColor =
        style == SignInWithAppleButtonStyle.dark ? Colors.white : Colors.black;

    return Container(
      height: height,
      child: SizedBox.expand(
        child: CupertinoButton(
          borderRadius: borderRadius,
          padding: EdgeInsets.zero,
          color: backgroundColor,
          child: Container(
            decoration: style == SignInWithAppleButtonStyle.white
                ? BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: borderRadius,
                  )
                : null,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            height: height,
            child: Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: height * 0.52,
                        color: contrastColor,
                      ),
                    ),
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: height * 0.43 /* per Apple's guidelines */,
                    color: contrastColor,
                  ),
                ),
                if (iconAlignment == IconAlignment.left)
                  // so text gets center aligned
                  Container(
                    width: 28,
                  )
              ],
              mainAxisAlignment: iconAlignment == IconAlignment.left
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

enum SignInWithAppleButtonStyle {
  dark,
  white,
}

enum IconAlignment {
  center,
  left,
}
