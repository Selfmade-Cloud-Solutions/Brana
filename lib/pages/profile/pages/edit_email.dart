import 'package:flutter/material.dart';
import 'package:brana_mobile/user/user_data.dart';
import 'package:brana_mobile/widgets/appbar_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void updateUserValue(String email) {
    user.email = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: branaDeepBlack,
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                            width: 320,
                            child: Text(
                              "What's your email?",
                              style: GoogleFonts.jost(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: branaWhite,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: SizedBox(
                                height: 100,
                                width: 320,
                                child: TextFormField(
                                  // Handles Form Validation
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Your email address',
                                      labelStyle: GoogleFonts.jost(
                                        color: branaWhite,
                                      )),
                                  controller: emailController,
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 320,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      if (_formKey.currentState!.validate() &&
                                          EmailValidator.validate(
                                              emailController.text)) {
                                        updateUserValue(emailController.text);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      'Update',
                                      style: GoogleFonts.jost(fontSize: 15),
                                    ),
                                  ),
                                )))
                      ]),
                )),
          ),
        ));
  }
}
