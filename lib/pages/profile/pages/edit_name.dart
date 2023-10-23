import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:brana_mobile/user/user_data.dart';
import 'package:brana_mobile/widgets/appbar_widget.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';

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
  var user = UserData.myUser;

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  void updateUserValue(String name) {
    user.name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
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
                      SizedBox(
                          width: 330,
                          child: Text(
                            "What's Your Name?",
                            style: GoogleFonts.jost(
                              fontSize: 25,
                              color: branaWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                              child: SizedBox(
                                  height: 100,
                                  width: 150,
                                  child: TextFormField(
                                    // Handles Form Validation for First Name
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your first name';
                                      } else if (!isAlpha(value)) {
                                        return 'Only Letters Please';
                                      }
                                      return null;
                                    },
                                    decoration:  InputDecoration(
                                      labelText: 'First Name',
                                      labelStyle: GoogleFonts.jost(
                                        color: branaWhite,
                                      ),
                                    ),
                                    controller: firstNameController,
                                  ))),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                              child: SizedBox(
                                  height: 100,
                                  width: 150,
                                  child: TextFormField(
                                    // Handles Form Validation for Last Name
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      } else if (!isAlpha(value)) {
                                        return 'Only Letters Please';
                                      }
                                      return null;
                                    },
                                    decoration:  InputDecoration(
                                      labelText: 'Last Name',
                                      labelStyle: GoogleFonts.jost(
                                        color: branaWhite,
                                      ),
                                    ),
                                    controller: secondNameController,
                                  )))
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: 330,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate() &&
                                        isAlpha(firstNameController.text +
                                            secondNameController.text)) {
                                      updateUserValue(
                                          "${firstNameController.text} ${secondNameController.text}");
                                      Navigator.pop(context);
                                    }
                                  },
                                  child:  Text(
                                    'Update',
                                    style: GoogleFonts.jost(fontSize: 15),
                                  ),
                                ),
                              )))
                    ],
                  ),
                ))));
  }
}
