import 'package:flutter/material.dart';

import 'package:zero/styles/textType.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String mainText;
  final String subText;
  final Color iconColor;
  final TextType mainTextType; // Add TextType parameters
  final TextType subTextType;

  const IconText({
    Key? key,
    required this.icon,
    required this.mainText,
    required this.subText,
    required this.iconColor,
    this.mainTextType = TextType.small, // Default to small text
    this.subTextType = TextType.small, // Default to small text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget( // Use TextWidget for main text
              text: mainText,
              textType: mainTextType, // Pass the mainTextType parameter
            ),
            TextWidget( // Use TextWidget for sub text
              text: subText,
              textType: subTextType, // Pass the subTextType parameter
            ),
          ],
        ),
      ],
    );
  }
}
