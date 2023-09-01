import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
// import 'package:brana_mobile/app_export.dart';
// import 'package:brana/presentation/light_albums_screen/light_albums_screen.dart';
// import 'package:brana/presentation/light_artists_singers_screen/light_artists_singers_screen.dart';
// import 'package:brana/presentation/light_downloads_screen/light_downloads_screen.dart';
// import 'package:brana/presentation/light_history_music_screen/light_history_music_screen.dart';
// import 'package:brana/presentation/light_playlists_screen/light_playlists_screen.dart';
// import 'package:brana/presentation/light_podcasts_your_likes_screen/light_podcasts_your_likes_screen.dart';
// import 'package:brana/widgets/my_divider.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});
double getFontSize(double px) {
  var height = getVerticalSize(px);
  var width = getHorizontalSize(px);
  if (height < width) {
    return height.toInt().toDouble();
  } else {
    return width.toInt().toDouble();
  }
}
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: size.width,
              margin: getMargin(right: 20, left: 20, top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            16.00,
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.book,
                          color: isDark
                                            ? Colors.white
                                            : Colors.black,


                        )
                        ),

                      Padding(
                        padding: getPadding(
                          left: 16,
                          top: 1,
                          bottom: 1,
                        ),
                        child: Text(
                          "My Library",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              24,
                            ),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: getPadding(
                      top: 5,
                      right: 3,
                      bottom: 4,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.search,
                          color: isDark ? Colors.white : Colors.black,
                          size: getVerticalSize(30),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 26,
                          ),
                          child: const Icon(
                      CupertinoIcons.bars,

                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                  child: Container(
                    margin: getMargin(
                      top: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: getMargin(
                            left: 0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    getPadding(top: 24, right: 20, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Listening History",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: getFontSize(
                                          24,
                                        ),
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        left: 0,
                                        bottom: 6,
                                      ),
                                      child: InkWell(
                                        // onTap: () {
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             LightHistoryMusicScreen()),
                                        //   );
                                        // },
                                        child: Text(
                                          "See All",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: getFontSize(
                                              16,
                                            ),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getVerticalSize(
                                  270.00,
                                ),
                                child: FadeInLeft(
                                  child: ListView.builder(
                                    padding: getPadding(
                                        top: 32,
                                        right: 20,
                                        left: 20,
                                        bottom: 20),
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(
                                              getHorizontalSize(
                                                24.00,
                                              ),
                                            ),
                                            // child: CommonImageView(
                                            //   imagePath:
                                            //       ImageConstant.gugut,
                                            //   height: getSize(
                                            //     160.00,
                                            //   ),
                                            //   width: getSize(
                                            //     160.00,
                                            //   ),
                                            // ),
                                          ),
                                          Container(
                                            width: getHorizontalSize(
                                              80.00,
                                            ),
                                            margin: getMargin(
                                              top: 8,
                                            ),
                                            child: Text(
                                              "Gugut | Podcast",
                                              maxLines: null,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: getFontSize(
                                                  18,
                                                ),
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Container(
                              //   margin: getMargin(top: 32, right: 20, left: 20),
                              //   child: MyDivider(isDark: isDark),
                              // ),
                              FadeInLeft(
                                child: Column(
                                  children: [
                                    InkWell(
                                      // onTap: () {
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             LightPlaylistsScreen()),
                                      //   );
                                      // },
                                      child: Padding(
                                        padding: getPadding(
                                          left: 20,
                                          top: 16,
                                          bottom: 16,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: getPadding(
                                                    top: 3,
                                                    bottom: 2,
                                                  ),
                                                  child:
                                                  Icon(
                                                    CupertinoIcons.wand_stars_inverse,
                                                    color: isDark ? Colors.white : Colors.black,
                                                    size: getVerticalSize(22.00),
                                                  )

                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 23,
                                                    right: 23,
                                                  ),
                                                  child: Text(
                                                    "Wishlist",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: getFontSize(
                                                        24,
                                                      ),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 0,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child:
                                              Icon(
                                                  CupertinoIcons.greaterthan_square,
                                                    color: isDark ? Colors.white : Colors.black,
                                                      size: getVerticalSize(22.00),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               LightDownloadsScreen(
                                      //                 title: "Liked",
                                      //               )));
                                      // },
                                      child: Padding(
                                        padding: getPadding(
                                          left: 20,
                                          top: 16,
                                          bottom: 16,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: getPadding(
                                                    top: 3,
                                                    bottom: 3,
                                                  ),
                                                  child:
                                                      Icon(
                                                    CupertinoIcons.heart,
                                                    color: isDark ? Colors.white : Colors.black,
                                                    size: getVerticalSize(22.00),
                                                  )
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                      left: 23, right: 23),
                                                  child: Text(
                                                    "Liked",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: getFontSize(
                                                        24,
                                                      ),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 0,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child:
                                              Icon(
                                                  CupertinoIcons.greaterthan_square,
                                                    color: isDark ? Colors.white : Colors.black,
                                                      size: getVerticalSize(22.00),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      // onTap: () {
                                        // Navigator.push(
                                            // context,
                                            // MaterialPageRoute(
                                            //     builder: (context) =>
                                            //          LightPodcastsYourLikesScreen()
                                            //         ));
                                      // },
                                      child: Padding(
                                        padding: getPadding(
                                          left: 20,
                                          top: 16,
                                          bottom: 16,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: getPadding(
                                                    top: 2,
                                                    bottom: 2,
                                                  ),
                                                  child:
                                                     Icon(
                                                    CupertinoIcons.antenna_radiowaves_left_right,
                                                    color: isDark ? Colors.white : Colors.black,
                                                    size: getVerticalSize(22.00),
                                                  )
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 22,
                                                    right: 22,
                                                  ),
                                                  child: Text(
                                                    "Podcasts",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: getFontSize(
                                                        24,
                                                      ),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 0,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child:
                                              Icon(
                                                  CupertinoIcons.greaterthan_square,
                                                    color: isDark ? Colors.white : Colors.black,
                                                      size: getVerticalSize(22.00),),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               LightAlbumsScreen()));
                                      // },
                                      child: Padding(
                                        padding: getPadding(
                                          left: 20,
                                          top: 16,
                                          bottom: 16,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: getPadding(
                                                    top: 3,
                                                    bottom: 3,
                                                  ),
                                                  child:
                                                  Icon(
                                                    CupertinoIcons.person,
                                                    color: isDark ? Colors.white : Colors.black,
                                                    size: getVerticalSize(22.00),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 23,
                                                    right: 23,
                                                  ),
                                                  child: Text(
                                                    "Narrators",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: getFontSize(
                                                        24,
                                                      ),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 0,
                                                top: 8,
                                                bottom: 8,
                                              ),

                                              child:
                                              Icon(
                                                  CupertinoIcons.greaterthan_square,
                                                    color: isDark ? Colors.white : Colors.black,
                                                      size: getVerticalSize(22.00),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      // onTap: () {
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             LightDownloadsScreen(
                                      //               title: "Authors",
                                      //             )),
                                      //   );
                                      // },
                                      child: Padding(
                                        padding: getPadding(
                                          left: 20,
                                          top: 16,
                                          bottom: 16,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: getPadding(
                                                    top: 2,
                                                    bottom: 2,
                                                  ),
                                                  child: Icon(
                                                    CupertinoIcons.pen,
                                                    color: isDark ? Colors.white : Colors.black,
                                                    size: getVerticalSize(22.00),
                                                    ),
                                                ),

                                                Padding(
                                                  padding: getPadding(
                                                    left: 23,
                                                    right: 23,
                                                  ),
                                                  child: Text(
                                                    "Authors",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: getFontSize(
                                                        24,
                                                      ),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 0,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child:
                                              Icon(
                                                  CupertinoIcons.greaterthan_square,
                                                    color: isDark ? Colors.white : Colors.black,
                                                      size: getVerticalSize(22.00),
                                                      ),

                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               LightArtistsSingersScreen()));
                                      // },
                                      child: Padding(
                                        padding: getPadding(
                                          left: 20,
                                          top: 16,
                                          bottom: 16,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: getPadding(
                                                    top: 4,
                                                    bottom: 4,
                                                  ),
                                                  child: Icon(
                                                    CupertinoIcons.book,
                                                    color: isDark ? Colors.white : Colors.black,
                                                    size: getVerticalSize(22.00),
                                                    ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    left: 22,
                                                    right: 22,
                                                  ),
                                                  child: Text(
                                                    "Audio books",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: getFontSize(
                                                        24,
                                                      ),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 0,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child:
                                              Icon(
                                                  CupertinoIcons.greaterthan_square,
                                                    color: isDark ? Colors.white : Colors.black,
                                                      size: getVerticalSize(22.00),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
