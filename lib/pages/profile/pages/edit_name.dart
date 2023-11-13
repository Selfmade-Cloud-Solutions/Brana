import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:brana_mobile/user/user_data.dart';
import 'package:brana_mobile/widgets/appbar_widget.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/pages/profile/pages/edit_image.dart';
import 'package:brana_mobile/widgets/display_image_widget.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  late Size mediaSize;

  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  var user = UserData.myUser;
  bool edit = false;

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();

    super.dispose();
  }

  void updateUserValue(
    String fname,
    String lname,
    String email,
  ) {
    user.firstName = fname;
    user.lastName = lname;
    user.email = email;
  }

  @override
  void initState() {
    super.initState();
    firstNameController.text = user.firstName;
    secondNameController.text = user.lastName;
    emailController.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    double toppadding = mediaSize.height;
    double bottompadding = mediaSize.height;
    double leftpadding = mediaSize.width;
    double rightpadding = mediaSize.width;
    double screenHeight = mediaSize.height;
    double screenWidth = mediaSize.width;

    double fontSize = screenWidth;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: branaDeepBlack,
          flexibleSpace: Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: bottompadding / 500),
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
                  width: 150,
                ),
                Text(
                  "Edit Profile",
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
            Ink(
              child: Material(
                color: edit ? Color.fromARGB(255, 1, 35, 2) : Colors.blue,
                borderRadius: BorderRadius.circular(100.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      edit = !edit;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: leftpadding / 300,
                        vertical: leftpadding / 300),
                    child: Icon(
                      Icons.edit,
                      color: edit
                          ? Color.fromARGB(255, 252, 252, 252)
                          : Color.fromARGB(255, 255, 255, 255),
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Form(
                key: _formKey,
                child: Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: const InputDecorationTheme(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: branaWhite),
                        ),
                      ),
                    ),
                    child: Container(
                      color: branaDeepBlack,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Center(
                              //   child: Text(
                              //     "Profile Information ",
                              //     style: TextStyle(
                              //         color: Colors.blue, fontSize: 17),
                              //   ),
                              // ),

                              SizedBox(
                                height: screenHeight / 30,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: leftpadding / 2.5),
                                child: InkWell(
                                  onTap: () {
                                    navigateSecondPage(const EditImagePage());
                                  },
                                  child: Stack(
                                      alignment: Alignment
                                          .bottomRight, // Adjust the alignment as needed
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          child: DisplayImage(
                                            imagePath: user.image,
                                            onPressed: () {},
                                          ),
                                        ),
                                        Material(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: InkWell(
                                            onTap: () {
                                              navigateSecondPage(
                                                  const EditImagePage());
                                            },
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: leftpadding / 10,
                                    vertical: toppadding / 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    label("First Name"),
                                    SizedBox(
                                      height: screenHeight / 80,
                                    ),
                                    firstName(),
                                    SizedBox(
                                      height: screenHeight / 50,
                                    ),
                                    label("Last Name"),
                                    SizedBox(
                                      height: screenHeight / 80,
                                    ),
                                    lastName(),
                                    SizedBox(
                                      height: screenHeight / 50,
                                    ),
                                    label("Email"),
                                    SizedBox(
                                      height: screenHeight / 80,
                                    ),
                                    email(),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: toppadding / 20),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: screenWidth / 2,
                                    height: screenHeight / 20,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_formKey.currentState!.validate() &&
                                            isAlpha(firstNameController.text +
                                                secondNameController.text) &&
                                            EmailValidator.validate(
                                                emailController.text)) {
                                          updateUserValue(
                                              firstNameController.text,
                                              secondNameController.text,
                                              emailController.text);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        'Update',
                                        style: GoogleFonts.jost(
                                            fontSize: fontSize / 25,
                                            fontWeight: FontWeight.w500,
                                            color: branaPrimaryColor),
                                      ),
                                    ),
                                  )))
                        ],
                      ),
                    ))),
          ),
        ));
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

  Widget firstName() {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double screenHeight = mediaSize.height;
    double leftpadding = mediaSize.width;
    double fontSize = screenWidth;
    return Container(
      height: screenHeight / 15,
      width: screenWidth,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: TextFormField(
          controller: firstNameController,
          enabled: edit,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your first name';
            } else if (!isAlpha(value)) {
              return 'Only Letters Please';
            }
            return null;
          },
          style: TextStyle(color: Colors.white, fontSize: fontSize / 27),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none, // Remove underline for error state
              focusedBorder: InputBorder.none,
              // hintText: "First Name",
              // hintStyle: TextStyle(
              // color: Colors.grey,
              // fontSize: 17,
              // ),
              contentPadding: EdgeInsets.only(
                left: leftpadding / 20,
                right: leftpadding / 20,
              )),
        ),
      ),
    );
  }

  Widget lastName() {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double screenHeight = mediaSize.height;
    double leftpadding = mediaSize.width;
    double fontSize = screenWidth;
    return Container(
      height: screenHeight / 15,
      width: screenWidth,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: TextFormField(
          controller: secondNameController,
          enabled: edit,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your last name';
            } else if (!isAlpha(value)) {
              return 'Only Letters Please';
            }
            return null;
          },
          style: TextStyle(color: Colors.white, fontSize: fontSize / 27),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none, // Remove underline for error state
              focusedBorder:
                  InputBorder.none, // Remove underline for focused state
              // hintText: "Last Name",
              // hintStyle: TextStyle(
              //   color: Colors.grey,
              //   fontSize: 17,
              // ),
              contentPadding: EdgeInsets.only(
                left: leftpadding / 20,
                right: leftpadding / 20,
              )),
        ),
      ),
    );
  }

  Widget email() {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double screenHeight = mediaSize.height;
    double leftpadding = mediaSize.width;
    double fontSize = screenWidth;
    return Container(
      height: screenHeight / 15,
      width: screenWidth,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: TextFormField(
          controller: emailController,
          enabled: edit,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email.';
            }
            return null;
          },
          style: TextStyle(color: Colors.white, fontSize: fontSize / 27),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none, // Remove underline for error state
              focusedBorder: InputBorder.none,
              // hintText: "Enter your email",
              // hintStyle: TextStyle(
              //   color: Colors.grey,
              //   fontSize: 17,
              // ),
              contentPadding: EdgeInsets.only(
                left: leftpadding / 20,
                right: leftpadding / 20,
              )),
        ),
      ),
    );
  }

  Widget label(String label) {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double fontSize = screenWidth;
    return Text(
      label,
      style: GoogleFonts.jost(
          color: const Color.fromARGB(255, 255, 255, 255),
          letterSpacing: 0.2,
          fontSize: 20),
    );
  }
}
