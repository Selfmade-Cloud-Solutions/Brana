import 'package:flutter/material.dart';

import '../../../constants.dart';


class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({super.key, 
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: kWhite,
                ),
          ),
        ),
      ],
    );
  }
}
