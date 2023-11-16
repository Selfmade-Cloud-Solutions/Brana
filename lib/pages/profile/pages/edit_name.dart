import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:brana_mobile/user/user_data.dart';
// import 'package:brana_mobile/widgets/appbar_widget.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/pages/profile/pages/edit_image.dart';
import 'package:brana_mobile/widgets/display_image_widget.dart';

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
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    UserData.init().then((_) {
      UserData.fetchAndSetUserFromApi().then((_) {
        setState(() {
          firstNameController.text = UserData.myUser.firstName;
          lastNameController.text = UserData.myUser.lastName;
          emailController.text = UserData.myUser.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    double screenHeight = mediaSize.height;
    double screenWidth = mediaSize.width;
    double toppadding = mediaSize.height;
    double leftpadding = mediaSize.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: branaDeepBlack,
        flexibleSpace: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight / 500),
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
                const SizedBox(
                  width: 150,
                ),
                Text(
                  "Profile",
                  style: GoogleFonts.jost(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: branaWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
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
                    SizedBox(
                      height: screenHeight / 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          navigateSecondPage(const EditImagePage());
                        },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              child: DisplayImage(
                                imagePath: UserData.myUser.image,
                                onPressed: () {},
                              ),
                            ),
                            Material(
                              color: branaBlue,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  navigateSecondPage(const EditImagePage());
                                },
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: branaWhite,
                                  size: 28,
                                ),
                              ),
                            )
                          ],
                        ),
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
                          userInfo(UserData.myUser.firstName),
                          SizedBox(
                            height: screenHeight / 50,
                          ),
                          label("Last Name"),
                          SizedBox(
                            height: screenHeight / 80,
                          ),
                          userInfo(UserData.myUser.lastName),
                          SizedBox(
                            height: screenHeight / 50,
                          ),
                          label("Email"),
                          SizedBox(
                            height: screenHeight / 80,
                          ),
                          userInfo(UserData.myUser.email),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userInfo(String info) {
    return Container(
      height: mediaSize.height / 15,
      width: mediaSize.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          info,
          style: TextStyle(
            color: Colors.white,
            fontSize: mediaSize.width / 27,
          ),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: GoogleFonts.jost(
        color: const Color.fromARGB(255, 255, 255, 255),
        letterSpacing: 0.2,
        fontSize: 20,
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
