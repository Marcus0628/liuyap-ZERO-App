import 'package:flutter/material.dart';

enum TextType { big, medium, small }

class TextWidget extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextType textType;

  TextWidget({
    Key? key,
    this.color,
    required this.text,
    this.height = 1.0,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w400,
    this.fontFamily = 'FjallaOne',
    this.textType = TextType.big,
  }) : size = _getSizeForTextType(textType),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: _getMaxLines(),
      overflow: overflow,
      style: TextStyle(
        color: color ?? _getDefaultColor(),
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontSize: size,
        height: height,
      ),
    );
  }

  int? _getMaxLines() {
    return textType == TextType.big ? 1 : null;
  }

  Color _getDefaultColor() {
    switch (textType) {
      case TextType.big:
        return const Color(0xff414141);
      case TextType.medium:
        return const Color(0xff6e6e6e);
      case TextType.small:
        return const Color(0xff919191);
    }
  }

  static double _getSizeForTextType(TextType type) {
    switch (type) {
      case TextType.big:
        return 20;
      case TextType.medium:
        return 15;
      case TextType.small:
        return 12;
    }
  }
}

