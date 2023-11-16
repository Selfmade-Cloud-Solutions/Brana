import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:brana_mobile/user/user_data.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/widgets/appbar_widget.dart';
import 'package:google_fonts/google_fonts.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);
  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: branaDeepBlack,
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
                                "What's Your phone Number?",
                                style: GoogleFonts.jost(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: branaWhite,
                                ),
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
                                        return 'Please enter your phone number';
                                      } else if (isAlpha(value)) {
                                        return 'Only Numbers Please';
                                      } else if (value.length < 10) {
                                        return 'Please enter a VALID phone number';
                                      }
                                      return null;
                                    },
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      labelText: 'Your Phone Number',
                                      labelStyle: GoogleFonts.jost(
                                        color: branaWhite,
                                      ),
                                    ),
                                  ))),
                                  Text(
                                        'Update',
                                        style: GoogleFonts.jost(fontSize: 15),
                                  )       
                        ]),
                  ))),
        ));
  }
}
