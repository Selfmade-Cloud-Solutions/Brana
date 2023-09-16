// import 'package:flutter/material.dart';
// import 'package:brana_mobile/models/catalog.dart';

// class GenreList extends StatelessWidget {
//   final Item item;
//   const GenreList({Key? key, required this.item}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 0,
//         color: Colors.cyan,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListTile(
//             leading: Image.network(
//               item.image,
//               height: 90,
//               width: 90,
//             ),
//             title: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Center(child: Text(item.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18))),
//             ),
//             subtitle: Center(child: Text(item.desc, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
//             trailing: Text(
//               item.price,
//               style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }