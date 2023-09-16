// import 'package:flutter/material.dart';

// class contoller extends StatefulWidget {
//   const contoller({super.key});

//   @override
//   State<contoller> createState() => _contollerState();
// }

// class _contollerState extends State<contoller> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _isExpanded = true;
//                           appBarColor = kDarkBlue;
//                           iconview = const Icon(Icons.view_list);
//                         });
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 600),
//                         // curve: Curves.linear,
//                         width: double.infinity,
//                         height: 100,
//                         child: Container(
//                           color: kDarkBlue,
//                           padding: const EdgeInsets.all(0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               if (_isExpanded)
//                                 (Expanded(
//                                     child: CircleAvatar(
//                                   radius: 100,
//                                   backgroundImage: AssetImage(
//                                       _currentSong?.albumCover ??
//                                           "assets/books/ላስብበት.jpg"),
//                                 )
//                                 )
//                                 ),
//                               Expanded(
//                                   child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       if (_isExpanded)
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 25),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       (Text(
//                                                         _currentSong?.title ??
//                                                             'Chapter 1',
//                                                         style:
//                                                             const TextStyle(
//                                                           fontSize: 14.0,
//                                                           color: Colors.white,
//                                                         ),
//                                                       )),
//                                                       Text(
//                                                         _currentSong
//                                                                 ?.artist ??
//                                                             'Chapter 1',
//                                                         style:
//                                                             const TextStyle(
//                                                           fontSize: 14.0,
//                                                           color: Colors.white,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   IconButton(
//                                                       onPressed: () {},
//                                                       color: Colors.white,
//                                                       icon: const Icon(Icons
//                                                           .favorite_border))
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                     ],
//                                   ),
                                  
//                                   Expanded(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         IconButton(
//                                           icon: const Icon(
//                                               CupertinoIcons.gobackward_15),
//                                           onPressed: () {},
//                                           color: Colors.white,
//                                         ),
//                                         if (_isExpanded)
//                                           (IconButton(
//                                             icon: const Icon(
//                                                 Icons.skip_previous),
//                                             onPressed: () {},
//                                             color: Colors.white,
//                                           )),
//                                         IconButton(
//                                           icon: Icon(
//                                             _isPlaying
//                                                 ? Icons.play_arrow
//                                                 : Icons.pause,
//                                           ),
//                                           onPressed: () => _isPlaying
//                                               ? playAudio()
//                                               : pauseAudio(),
//                                           color: Colors.white,
//                                         ),
//                                         if (_isExpanded)
//                                           (IconButton(
//                                             icon: const Icon(Icons.skip_next),
//                                             onPressed: () {},
//                                             color: Colors.white,
//                                           )),
//                                         IconButton(
//                                           icon: const Icon(
//                                               CupertinoIcons.goforward_15),
//                                           onPressed: () {
//                                             seekAudio();
//                                           },
//                                           color: Colors.white,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),,
//     );
//   }
// }