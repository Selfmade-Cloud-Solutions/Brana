import 'dart:io';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  // Constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Color.fromRGBO(255, 255, 255, 1);

    return Center(
        child: Stack(children: [
      buildImage(color),
      // Positioned(
      //   right: 10,
      //   top: 85,
      //   child: buildEditIcon(color),
      // )
    ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return CircleAvatar(
      radius: 50,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 48,
      ),
    );
  }

  // // Builds Edit Icon on Profile Picture
  // Widget buildEditIcon(Color color) => buildCircle(
  //     all: 8,
  //     child: Icon(
  //       Icons.edit,
  //       color: color,
  //       size: 20,
  //     ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        // padding: EdgeInsets.all(all),
        color: const Color.fromARGB(255, 184, 208, 211),
        child: child,
      ));
}
