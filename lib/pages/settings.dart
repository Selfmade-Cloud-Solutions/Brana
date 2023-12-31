// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brana_mobile/sharedPreference.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}
Future<void> _logout(BuildContext context) async {
  const apiUrl = 'https://app.berana.app/api/method/brana_audiobook.api.auth_api.logout';

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Retrieve headers from SharedPreferences
      String? headersString = prefs.getString('authHeaders');
      if (headersString != null) {
        Map<String, dynamic> headers = jsonDecode(headersString);

        // Create a Dio instance for making HTTP requests
        Dio dio = Dio();

        // Add headers to the Dio instance
        dio.options.headers['Content-Type'] = 'application/json';
        dio.options.headers.addAll(headers);

        // Make the request using Dio
        final response = await dio.post(apiUrl);

        if (response.statusCode == 200) {
          await prefs.setBool('isLoggedIn', false);
          // Update the state to reflect the change
          await checkLoginStatus(context);
        } else {
          // Handle error...
          print('Logout failed. Status code: ${response.statusCode}');
          // Add any additional error handling as needed
        }
      } else {
        // Handle case where headers are not found in SharedPreferences
        print('Headers not found in SharedPreferences');
      }
    } else {
      // Handle case where user is not logged in
      print('User is not logged in');
    }
  } catch (e) {
    // Handle exceptions
    print('Error during logout: $e');
    // Add any additional error handling as needed
  }
}



class _SettingsPageState extends State<SettingsPage> {
  late Size mediaSize;
  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: branaDeepBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: branaDeepBlack,
          flexibleSpace: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: branaWhite,
                ),
              ),
              SizedBox(
                width: mediaSize.width / 2 - 80,
              ),
              Text(
                "Setting",
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  height: 1,
                  color: branaWhite,
                ),
              ),
              SizedBox(
                height: mediaSize.height / 4,
              )
            ],
          )),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: [
              SizedBox(
                height: mediaSize.height / 500,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: mediaSize.width,
                  height: mediaSize.height,
                  color: branaDeepBlack,
                  // padding: const EdgeInsets.only(left: 70, top: 20, right: 70),
                  child: Column(children: [
                    SizedBox(
                      height: mediaSize.height / 20,
                    ),
                    label("General Setting"),
                    buildChangePassword(context, "Change password"),
                    SizedBox(
                      height: mediaSize.height / 100,
                    ),
                    buildContentSettings(context, "Content settings"),
                    SizedBox(
                      height: mediaSize.height / 100,
                    ),
                    buildPreferences(context, "Preferences"),
                    SizedBox(
                      height: mediaSize.height / 40,
                    ),
                    label("Privacy Setting"),
                    buildAccountOptionRow(context, "Privacy and security"),
                    SizedBox(
                      height: mediaSize.height / 100,
                    ),
                    buildTermsAndConditions(context, "Terms and conditions"),
                    buildLogoutButton(context),
                  ]))
            ],
          ),
        ));
  }
}

GestureDetector buildAccountOptionRow(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Option 1"),
                  Text("Option 2"),
                  Text("Option 3"),
                ],
              ),
            );
          });
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 0, top: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 + 150,
        height: MediaQuery.of(context).size.height / 10,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: branaDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: branaWhite,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: branaWhite,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

GestureDetector buildChangePassword(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Colors.black,
                title: Text('Change Password',
                    style: GoogleFonts.jost(color: branaWhite)),
                actions: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      labelStyle: GoogleFonts.jost(color: branaWhite),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: branaWhite),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: branaWhite),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      labelStyle: GoogleFonts.jost(color: branaWhite),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: branaWhite),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: branaWhite),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 20,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: branaBlue.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Update',
                              style: GoogleFonts.jost(
                                  color: branaWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18)),
                        ),
                      ),
                    ),
                  ),
                ]);
          });
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 0, top: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 + 150,
        height: MediaQuery.of(context).size.height / 10,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: branaDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: branaWhite,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: branaWhite,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

GestureDetector buildContentSettings(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title, style: GoogleFonts.jost(color: branaWhite)),
              backgroundColor: Colors.black,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Explicit content",
                      style: GoogleFonts.jost(color: branaWhite)),
                  Text("Children Content",
                      style: GoogleFonts.jost(color: branaWhite)),
                  Text("Option 3", style: GoogleFonts.jost(color: branaWhite)),
                ],
              ),
            );
          });
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 0, top: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 + 150,
        height: MediaQuery.of(context).size.height / 10,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: branaDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: branaWhite,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: branaWhite,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

GestureDetector buildTermsAndConditions(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Colors.black,
                title: Text('Brana Audiobooks Terms and Conditions',
                    style: GoogleFonts.jost(color: branaWhite)),
                content: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RichText(
                            text: TextSpan(
                                style: GoogleFonts.jost(
                                    fontSize: 16, color: branaWhite),
                                children: [
                              TextSpan(
                                  text: "Terms and Conditions\n",
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "\n1. Introduction\n",
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text:
                                      "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
                              TextSpan(
                                  text: "\n2. Intellectual Property Rights\n",
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text:
                                      "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
                              TextSpan(
                                  text: "\n3. Intellectual Property Rights\n",
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text:
                                      "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
                              TextSpan(
                                  text: "\n4. User Accounts\n",
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text:
                                      "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
                              TextSpan(
                                  text: "\n5. Introduction\n",
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text:
                                      "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
                              TextSpan(
                                  text: "\n6. Intellectual Property Rights\n",
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text:
                                      "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
                              TextSpan(
                                  text: "\n7. Intellectual Property Rights\n",
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text:
                                      "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
                              TextSpan(
                                  text: "\n8. User Accounts\n",
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text:
                                      "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
                            ])))));
          });
    },
    child: SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 + 150,
        height: MediaQuery.of(context).size.height / 10,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: branaDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: branaWhite,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: branaWhite,
              ),
            ],
          ),
        ),
      ),
    )),
  );
}

GestureDetector buildPreferences(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
            );
          });
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 0, top: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 + 150,
        height: MediaQuery.of(context).size.height / 10,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: branaDark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: GoogleFonts.jost(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: branaWhite,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: branaWhite,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildLogoutButton(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: branaDarkBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _logoutDialog(context),
                  );
                },
                child: Text('Logout',
                    style: GoogleFonts.jost(color: Colors.white, fontSize: 18)),
              ))));
}

// dialog widget

Widget _logoutDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.black,
    title:
        Text('Logout Confirmation', style: GoogleFonts.jost(color: branaWhite)),
    content: Text('Are you sure you want to logout?',
        style: GoogleFonts.jost(color: branaWhite)),
    actions: [
      TextButton(
        onPressed: () async {
          await _logout(context);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: Text(
          'Logout',
          style: GoogleFonts.jost(
            fontSize: 15,
            color: Colors.red,
          ),
        ),
      ),
      TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'No',
            style: GoogleFonts.jost(
                fontSize: 15, color: kLightBlue.withOpacity(0.9)),
          ))
    ],
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
