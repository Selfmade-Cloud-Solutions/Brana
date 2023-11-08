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
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 20),
                                        child: Text(
                                          "Edit Profile",
                                          style: GoogleFonts.jost(
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Ink(
                                          child: Material(
                                            color: edit
                                                ? Color.fromARGB(255, 1, 35, 2)
                                                : Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  edit = !edit;
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.0,
                                                    vertical: 3.0),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: edit
                                                      ? Color.fromARGB(
                                                          255, 252, 252, 252)
                                                      : Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  size: 28,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    // IconButton(
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       edit = !edit;
                                    //     });
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.edit,
                                    //     color: edit
                                    //         ? Color.fromARGB(190, 2, 95, 56)
                                    //         : Colors.blue,
                                    //     size: 28,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 150.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    label("First Name"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    firstName(),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    label("Last Name"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    lastName(),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    label("Email"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    email(),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 50,
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue),
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
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
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
          style: TextStyle(color: Colors.white, fontSize: 17),
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
                left: 20,
                right: 20,
              )),
        ),
      ),
    );
  }

  Widget lastName() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
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
          style: TextStyle(color: Colors.white, fontSize: 17),
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
                left: 20,
                right: 20,
              )),
        ),
      ),
    );
  }

  Widget email() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
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
          style: TextStyle(color: Colors.white, fontSize: 17),
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
                left: 20,
                right: 20,
              )),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: GoogleFonts.jost(
          color: Colors.blue,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          fontSize: 16.5),
    );
  }
}
