import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:brana_mobile/user/user_data.dart';
import 'package:brana_mobile/widgets/appbar_widget.dart';
// import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/pages/profile/pages/edit_description.dart';
import 'package:brana_mobile/pages/profile/pages/edit_email.dart';
import 'package:brana_mobile/pages/profile/pages/edit_image.dart';
import 'package:brana_mobile/pages/profile/pages/edit_name.dart';
import 'package:brana_mobile/pages/profile/pages/edit_phone.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditProfile> {
  
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:SingleChildScrollView(
        child: 
    Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        EditImagePage(),
      EditNameFormPage(),
      EditPhoneFormPage(),
      EditEmailFormPage(),
      EditDescriptionFormPage(),
        ]
      )
    ));
  }
}
