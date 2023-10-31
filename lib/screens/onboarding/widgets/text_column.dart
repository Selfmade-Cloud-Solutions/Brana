import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';

class TextColumn extends StatelessWidget {
  final String title;
  final String text;

  const TextColumn({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
     double fontSize = MediaQuery.of(context).size.width * 0.05;
fontSize = fontSize.clamp(12, 20); 
    return Column(
      children: <Widget>[
Text(
  title,
  textAlign: TextAlign.center,
  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: fontSize  
  ),
),
        const SizedBox(height: kSpaceS),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: branaWhite,
          fontSize: fontSize/1.5 ),
        ),
      ],
    );
  }
}
