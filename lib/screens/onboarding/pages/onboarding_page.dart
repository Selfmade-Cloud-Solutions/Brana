import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../widgets/cards_stack.dart';

class OnboardingPage extends StatelessWidget {
  final int number;
  // final Widget lightCardChild;
  final Widget darkCardChild;
  final Animation<Offset> lightCardOffsetAnimation;
  final Animation<Offset> darkCardOffsetAnimation;
  final Widget textColumn;

  const OnboardingPage({
    super.key,
    required this.number,
    // required this.lightCardChild,
    required this.darkCardChild,
    required this.lightCardOffsetAnimation,
    required this.darkCardOffsetAnimation,
    required this.textColumn,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        CardsStack(
          pageNumber: number,
          darkCardChild: darkCardChild,
          lightCardOffsetAnimation: lightCardOffsetAnimation,
          darkCardOffsetAnimation: darkCardOffsetAnimation,
        ),
        SizedBox(
        height: number % 2 == 1 ? screenHeight * 0.05 : screenHeight * 0.025  
      ),
        AnimatedSwitcher(
          duration: branaCardAnimationDuration,
          child: textColumn,
        ),
      ],
    );
  }
}
