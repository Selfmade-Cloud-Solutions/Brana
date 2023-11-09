import 'dart:async';
import 'package:brana_mobile/pages/profile/edit_profile.dart';
import 'package:flutter/material.dart';
// import 'package:brana_mobile/pages/profile/pages/edit_description.dart';
// import 'package:brana_mobile/pages/profile/pages/edit_email.dart';
import 'package:brana_mobile/pages/profile/pages/edit_image.dart';
import 'package:brana_mobile/pages/profile/pages/edit_name.dart';
// import 'package:brana_mobile/pages/profile/pages/edit_phone.dart';
// import 'package:brana_mobile/user/user.dart';
import 'package:brana_mobile/widgets/display_image_widget.dart';
import 'package:brana_mobile/user/user_data.dart';
import 'package:brana_mobile/pages/settings.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;
    const color = Color.fromRGBO(255, 255, 255, 1);
    mediaSize = MediaQuery.of(context).size;
    double toppadding = mediaSize.height;
    double bottompadding = mediaSize.height;
    double leftpadding = mediaSize.width;
    double rightpadding = mediaSize.width;
    double screenHeight = mediaSize.height;
    double screenWidth = mediaSize.width;

    double fontSize = screenWidth;
    return Scaffold(
      backgroundColor: branaDeepBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: branaDeepBlack,
        flexibleSpace: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Profile",
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w600,
                fontSize: fontSize / 20,
                height: screenHeight / 200,
                color: branaWhite,
              ),
            ),
          ],
        )),
        actions: [
          InkWell(
            onTap: () {
              navigateSecondPage(const SettingsPage());
            },
            child: buildSettingsIcon(color),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: branaDeepBlack,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: toppadding / 30),
                child: Container(
                  width: screenWidth / 1.3,
                  height: screenHeight / 2.7,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 16, 27),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight / 30,
                      ),
                      imdisplay(),
                      SizedBox(
                        height: screenHeight / 80,
                      ),
                      buildUserInfoDisplay(user.firstName, user.lastName),
                      SizedBox(
                        height: screenHeight / 250,
                      ),
                      emailDisplay(user.email),
                      SizedBox(
                        height: screenHeight / 20,
                      ),
                      buildEditButton(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 50,
              ),
              Container(
                width: screenWidth / 0.5,
                height: screenHeight / 3,
                color: branaDeepBlack,
                child: Center(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: leftpadding / 30),
                            child: label("Total time spent"),
                          ),
                        ],
                      ),
                      total(),
                      SizedBox(height: screenHeight / 30),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: leftpadding / 30),
                            child: label("Total Books"),
                          ),
                        ],
                      ),
                      cardd(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget imdisplay() {
    mediaSize = MediaQuery.of(context).size;
    double toppadding = mediaSize.height;

    return Padding(
      padding: EdgeInsets.only(top: toppadding * 0),
      child: InkWell(
          onTap: () {
            // navigateSecondPage(const EditImagePage());
          },
          child: CircleAvatar(
            radius: 50,
            child: DisplayImage(
              imagePath: user.image,
              onPressed: () {},
            ),
          )
          // child: Container(
          //   width: 80.0,
          //   height: 80.0,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: NetworkImage(user.image),
          //         fit: BoxFit.cover,
          //       ),
          //       shape: BoxShape.rectangle,
          //       borderRadius: BorderRadius.circular(10.0)),
          // ),
          ),
    );
  }

  Widget buildSettingsIcon(Color color) {
    mediaSize = MediaQuery.of(context).size;
    double toppadding = mediaSize.height;
    double rightpadding = mediaSize.width;
    double screenWidth = mediaSize.width;
    double fontSize = screenWidth;

    return Container(
      padding: EdgeInsets.only(right: rightpadding / 40, top: toppadding / 250),
      child: Icon(
        Icons.settings,
        color: branaWhite,
        size: fontSize / 13,
      ),
    );
  }

  Widget buildUserInfoDisplay(String finame, String laname) {
    mediaSize = MediaQuery.of(context).size;

    double bottompadding = mediaSize.height;

    double screenWidth = mediaSize.width;

    double fontSize = screenWidth;
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(bottom: bottompadding / 350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   title,
                //   style: GoogleFonts.jost(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w500,
                //     color: branaWhite,
                //   ),
                // ),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          finame,
                          style: GoogleFonts.jost(
                              fontSize: fontSize / 25,
                              height: 1.4,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        child: Text(
                          laname,
                          style: GoogleFonts.jost(
                              fontSize: fontSize / 25,
                              height: 1.4,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  Widget emailDisplay(String mail) {
    mediaSize = MediaQuery.of(context).size;

    double bottompadding = mediaSize.height;

    double screenWidth = mediaSize.width;

    double fontSize = screenWidth;
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(bottom: bottompadding / 350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   title,
                //   style: GoogleFonts.jost(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w500,
                //     color: branaWhite,
                //   ),
                // ),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          mail,
                          style: GoogleFonts.jost(
                              fontSize: fontSize / 30,
                              height: 1.4,
                              color: Color.fromARGB(255, 158, 155, 155)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  Widget buildEditButton() {
    mediaSize = MediaQuery.of(context).size;

    double screenWidth = mediaSize.width;
    double screenHeight = mediaSize.height;

    double fontSize = screenWidth;
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenWidth / 3 - 10,
                height: screenHeight / 10 - 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditNameFormPage()));
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  child: Text(
                    'View Profile',
                    style: GoogleFonts.jost(
                        fontSize: fontSize / 30,
                        color: const Color.fromARGB(255, 2, 16, 27),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            )));
  }

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

// Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }

  Widget cardd() {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double screenHeight = mediaSize.height;
    double leftpadding = mediaSize.width;
    double fontSize = screenWidth;

    return Container(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: leftpadding / 10),
            child: Container(
              width: screenWidth / 2 + 100,
              height: screenHeight / 12,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: branaDark,
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth / 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Icon(
                        Icons.book_outlined,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 10,
                    ),
                    Text(
                      "18 Books ",
                      style: GoogleFonts.jost(
                          fontSize: fontSize / 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget total() {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double screenHeight = mediaSize.height;
    double leftpadding = mediaSize.width;
    double fontSize = screenWidth;
    return Container(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: leftpadding / 10),
            child: Container(
              width: screenWidth / 2 + 100,
              height: screenHeight / 12,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: branaDark,
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth / 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Icon(
                        Icons.timer_outlined,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 10,
                    ),
                    Text(
                      "390 Minutes ",
                      style: GoogleFonts.jost(
                          fontSize: fontSize / 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget label(String label) {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double leftpadding = mediaSize.width;
    double fontSize = screenWidth;
    return Padding(
      padding: EdgeInsets.only(left: leftpadding / 15),
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          label,
          style: GoogleFonts.jost(
              color: const Color.fromARGB(255, 190, 188, 188),
              fontWeight: FontWeight.w300,
              letterSpacing: 0.2,
              fontSize: fontSize / 25),
        ),
      ),
    );
  }

  buildProfileCard() {}
}
