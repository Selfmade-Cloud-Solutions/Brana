import 'package:flutter/material.dart';

import '../../../constants.dart';

class NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextPageButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const maxIconSize = 24.0;

    double iconSize = MediaQuery.of(context).size.width * 0.05;

    if (iconSize > maxIconSize) {
      iconSize = maxIconSize;
    }

    return RawMaterialButton(
        padding: const EdgeInsets.all(kPaddingM),
        elevation: 0.0,
        shape: const CircleBorder(),
        fillColor: branaWhite,
        onPressed: onPressed,
        child: Icon(
          Icons.arrow_forward,
          color: branaDeepBlack,
          size: iconSize,
        ));
  }
}
