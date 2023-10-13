import 'dart:async';
import 'package:flutter/material.dart';
import 'package:brana_mobile/pages/profile/edit_description.dart';
import 'package:brana_mobile/pages/profile/edit_email.dart';
import 'package:brana_mobile/pages/profile/edit_image.dart';
import 'package:brana_mobile/pages/profile/edit_name.dart';
import 'package:brana_mobile/pages/profile/edit_phone.dart';
import 'package:brana_mobile/user/user.dart';
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
    const color = Color.fromRGBO(64, 105, 225, 1);
    return Scaffold(
      appBar:AppBar(
  automaticallyImplyLeading: false,
  backgroundColor: branaDeepBlack,
  flexibleSpace: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Edit Profile",
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  height: 1,
                  color: Colors.white,
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
      body: Container(
        color: branaDeepBlack,
        child: Column(
        children: [
          InkWell(
              onTap: () {
                navigateSecondPage(const EditImagePage());
              },
              child: DisplayImage(
                imagePath: user.image,
                onPressed: () {},
              )),
          buildUserInfoDisplay(user.name, 'Name', const EditNameFormPage()),
          buildUserInfoDisplay(user.phone, 'Phone', const EditPhoneFormPage()),
          buildUserInfoDisplay(user.email, 'Email', const EditEmailFormPage()),
          Expanded(
            flex: 4,
            child: buildAbout(user),
          )
        ],
      )),
    );
  }

  Widget buildSettingsIcon(Color color) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: const Icon(
        Icons.settings,
        color: Colors.white,
        size: 35,
      ),
    );
  }

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        child: child,
      ));
  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: branaWhite,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: branaWhite,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: const TextStyle(fontSize: 16, height: 1.4),
                            ))),
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(User user) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Date of birth',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: branaWhite,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 50,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: branaWhite,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          navigateSecondPage(const EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  user.aboutMeDescription,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.80,
                                  ),
                                ))))),
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }

  buildProfileCard() {}
}
