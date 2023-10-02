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
    return RawMaterialButton(
      padding: const EdgeInsets.all(kPaddingM),
      elevation: 0.0,
      shape: const CircleBorder(),
      fillColor: branaWhite,
      onPressed: onPressed,
      
      child: const Icon(
        Icons.arrow_forward,
        color: branaDeepBlack,
        size: 32.0,
      ),
    );
  }
}
