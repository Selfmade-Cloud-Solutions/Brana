import 'dart:async';
// import 'package:brana_mobile/models/user.dart';
import 'package:brana_mobile/pages/profile/edit_profile.dart';
import 'package:flutter/material.dart';
// import 'package:brana_mobile/pages/profile/pages/edit_description.dart';
// import 'package:brana_mobile/pages/profile/pages/edit_email.dart';
import 'package:brana_mobile/pages/profile/pages/edit_image.dart';
import 'package:brana_mobile/pages/profile/pages/edit_name.dart';
// import 'package:brana_mobile/pages/profile/pages/edit_phone.dart';
import 'package:brana_mobile/user/user.dart';
import 'package:brana_mobile/widgets/display_image_widget.dart';
import 'package:brana_mobile/user/user_data.dart';
import 'package:brana_mobile/pages/settings.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Size mediaSize;
  // late UserData user;

  void initstate() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      await UserData.init(); // Initialize SharedPreferences

      final apiUrl =
          'https://app.berana.app/api/method/brana_audiobook.api.user_profile_api.retrieve_profile';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = json.decode(response.body);

        if (responseJson.containsKey('message') &&
            responseJson['message'] != null) {
          final loggedUser = responseJson['message'];
          UserData.setUser(
              User.fromJson(loggedUser())); // Set user data in UserData
          setState(() {
            user = UserData
                .getUser(); // Update the user variable with fetched data
          });
        }
      } else {
        print('Failed to fetch user data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

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
            child: Padding(
          padding: EdgeInsets.only(bottom: bottompadding / 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "My Profile",
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  // height: screenHeight / 200,
                  color: branaWhite,
                ),
              ),
            ],
          ),
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
                padding: EdgeInsets.only(
                    top: toppadding / 30, bottom: bottompadding / 15),
                child: Container(
                  width: screenWidth / 1.3,
                  height: screenHeight / 2.7,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 16, 27),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottompadding / 190),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight / 30,
                        ),
                        imdisplay(),
                        SizedBox(
                          height: screenHeight / 80,
                        ),
                        buildUserInfoDisplay(),
                        SizedBox(
                          height: screenHeight / 250,
                        ),
                        emailDisplay(),
                        SizedBox(
                          height: screenHeight / 25,
                        ),
                        buildEditButton(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight / 100,
              ),
              Padding(
                padding: EdgeInsets.only(left: leftpadding / 15),
                child: Container(
                  // width: screenWidth / 0.5,
                  // height: screenHeight / 3,
                  color: branaDeepBlack,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
    // double toppadding = mediaSize.height;
    double rightpadding = mediaSize.width;
    double screenWidth = mediaSize.width;
    double fontSize = screenWidth;

    return Container(
      padding: EdgeInsets.only(
        right: rightpadding / 10,
      ),
      child: Icon(
        Icons.settings,
        color: branaWhite,
        size: 25,
      ),
    );
  }

  Widget buildUserInfoDisplay() {
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
                          user.firstName,
                          style: GoogleFonts.jost(
                              fontSize: 25, height: 1.4, color: Colors.white),
                        ),
                      ),
                      Container(
                        child: Text(
                          user.lastName,
                          style: GoogleFonts.jost(
                              fontSize: 25, height: 1.4, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  Widget emailDisplay() {
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
                          user.email,
                          style: GoogleFonts.jost(
                              fontSize: 15,
                              height: 1.4,
                              color: const Color.fromARGB(255, 158, 155, 155)),
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
    return SizedBox(
      width: screenWidth / 3,
      height: screenHeight / 10 - 40,
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
          overflow: TextOverflow.visible,
          style: GoogleFonts.jost(
              fontSize: 20,
              color: const Color.fromARGB(255, 2, 16, 27),
              fontWeight: FontWeight.w400),
        ),
      ),
    );
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

    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: leftpadding / 10, right: leftpadding / 10),
            child: SizedBox(
              width: screenWidth / 1.5,
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
                    const Padding(
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
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double screenHeight = mediaSize.height;
    double leftpadding = mediaSize.width;
    double fontSize = screenWidth;
    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: leftpadding / 10),
            child: SizedBox(
              width: screenWidth / 1.5,
              height: screenHeight / 12,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: branaDark,
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth / 25,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Icon(
                        Icons.timer_outlined,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 10,
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
              fontSize: 25),
        ),
      ),
    );
  }
}
