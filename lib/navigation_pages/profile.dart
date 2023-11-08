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
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;
    const color = Color.fromRGBO(255, 255, 255, 1);
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
                fontSize: 25,
                height: 1,
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: branaDeepBlack,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2 + 100,
                  height: MediaQuery.of(context).size.height / 2 - 92,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 16, 27),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      imdisplay(),
                      SizedBox(
                        height: 5,
                      ),
                      buildUserInfoDisplay(user.firstName, user.lastName),
                      SizedBox(
                        height: 1,
                      ),
                      emailDisplay(user.email),
                      SizedBox(
                        height: 20,
                      ),
                      buildEditButton(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: label("Total time njnspent"),
                        ),
                      ],
                    ),
                    total(),
                    SizedBox(height: 30),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: label("Total Books"),
                        ),
                      ],
                    ),
                    cardd(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget imdisplay() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
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
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: const Icon(
        Icons.settings,
        color: branaWhite,
        size: 35,
      ),
    );
  }

  Widget buildUserInfoDisplay(String finame, String laname) =>
      SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(bottom: 1),
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
                  const SizedBox(
                    height: 1,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            finame,
                            style: GoogleFonts.jost(
                                fontSize: 20, height: 1.4, color: Colors.white),
                          ),
                        ),
                        Container(
                          child: Text(
                            laname,
                            style: GoogleFonts.jost(
                                fontSize: 20, height: 1.4, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )));

  Widget emailDisplay(String mail) => SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 1),
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
              const SizedBox(
                height: 1,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        mail,
                        style: GoogleFonts.jost(
                            fontSize: 15,
                            height: 1.4,
                            color: Color.fromARGB(255, 158, 155, 155)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )));
  Widget buildEditButton() {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth / 30;
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width / 3 - 10,
                height: MediaQuery.of(context).size.width / 10 - 5,
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
                        fontSize: fontSize,
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 2 + 100,
              height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                color: branaDark,

                // Text(
                //   "Total time spent",
                //   style: GoogleFonts.jost(
                //       fontSize: 20,
                //       letterSpacing: 1,
                //       fontWeight: FontWeight.w500,
                //       color: Colors.white),
                // ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                        height: 150,
                        width: 10,
                        child: Icon(
                          Icons.timer,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "18 Books ",
                      style: GoogleFonts.jost(
                          fontSize: 20,
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 2 + 100,
              height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                color: branaDark,

                // Text(
                //   "Total time spent",
                //   style: GoogleFonts.jost(
                //       fontSize: 20,
                //       letterSpacing: 1,
                //       fontWeight: FontWeight.w500,
                //       color: Colors.white),
                // ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                        height: 150,
                        width: 10,
                        child: Icon(
                          Icons.timer,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "390 Minutes ",
                      style: GoogleFonts.jost(
                          fontSize: 20,
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
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          label,
          style: GoogleFonts.jost(
              color: const Color.fromARGB(255, 190, 188, 188),
              fontWeight: FontWeight.w300,
              letterSpacing: 0.2,
              fontSize: 16.5),
        ),
      ),
    );
  }

  buildProfileCard() {}
}
