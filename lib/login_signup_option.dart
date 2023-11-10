import 'package:flutter/material.dart';
import 'package:brana_mobile/signup_page.dart';
import 'package:brana_mobile/login_page.dart';
import 'package:brana_mobile/constants.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:brana_mobile/navigation.dart';

class LoginSignupOption extends StatefulWidget {
  const LoginSignupOption({super.key, required double screenHeight});

  @override
  State<LoginSignupOption> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginSignupOption> {
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  late Size mediaSize;
  late Color myColor;

  Widget _buildTop() {
    mediaSize = MediaQuery.of(context).size;
    double screenHeight = mediaSize.height;
    double screenWidth = mediaSize.width;
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: screenWidth / 4,
            height: screenHeight / 8,
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    mediaSize = MediaQuery.of(context).size;
    double topppadding = mediaSize.height;
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: kLightBlue.withOpacity(0.1),
        child: Padding(
          padding: EdgeInsets.all(topppadding / 15),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    mediaSize = MediaQuery.of(context).size;
    double screenHeight = mediaSize.height;

    double leftppadding = mediaSize.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: _buildTop(),
        ),
        SizedBox(height: screenHeight / 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: leftppadding / 7),
          child: _buildLoginButton(),
        ),
        SizedBox(height: screenHeight / 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: leftppadding / 7),
          child: _buildSignupButton(),
        ),
        SizedBox(height: screenHeight / 25),
        _buildOtherLogin(),
        SizedBox(height: screenHeight / 25),
      ],
    );
  }

  Widget _buildPrimaryText(String text) {
    return Text(
      text,
      style: GoogleFonts.jost(color: branaWhite),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 10,
        backgroundColor: branaPrimaryColor.withBlue(90),
        shadowColor: const Color.fromARGB(50, 110, 105, 105),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text("LOGIN",
          style: GoogleFonts.jost(
            color: branaWhite,
            fontWeight: FontWeight.w800,
          )),
    );
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignupPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 10,
        backgroundColor: branaWhite,
        shadowColor: const Color.fromARGB(50, 110, 105, 105),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text("SIGN UP",
          style: GoogleFonts.jost(
            color: branaPrimaryColor,
            fontWeight: FontWeight.w800,
          )),
    );
  }

  Widget _buildOtherLogin() {
    mediaSize = MediaQuery.of(context).size;
    double screenHeight = mediaSize.height;
    double screenWidth = mediaSize.width;

    // double leftppadding = mediaSize.width;
    return Center(
      child: Column(
        children: [
          _buildPrimaryText("Or Login with"),
          SizedBox(height: screenHeight / 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            // children: [
            //   Tab(
            //     icon: InkWell(
            //         onTap: () async {
            //           final GoogleSignInAccount? googleUser =
            //               await googleSignIn.signIn();

            //           if (googleUser != null) {
            //             // user signed in
            //           } else {
            //             // user canceled
            //           }
            //         },
            //         child: Image.asset("assets/images/google.png")),
            //   ),
            //   Tab(icon: Image.asset("assets/images/facebook.png")),
            //   Tab(icon: Image.asset("assets/images/twitter.png"))
            // ],
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleUser =
                        await googleSignIn.signIn();

                    if (googleUser != null) {
                      // Perform authentication with googleUser.id and googleUser.displayName
                      // Navigate to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Navigation()),
                      );
                    } else {
                      // User canceled
                    }
                  } catch (error) {
                    // Handle errors
                    print('Google Sign-In failed: $error');
                  }
                },
                icon: Image.asset("assets/images/google.png",
                    height: screenHeight / 30, width: screenWidth / 30),
                // label: Text(""),
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.white, // Background color
                //   onPrimary: Colors.black, // Text color
                //   minimumSize: Size(100, 40),
                // ),
              ),
              Tab(icon: Image.asset("assets/images/facebook.png")),
              Tab(icon: Image.asset("assets/images/twitter.png")),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColorLight;
    mediaSize = MediaQuery.of(context).size;
    double screenHeight = mediaSize.height;
    double screenWidth = mediaSize.width;
    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          color: branaDeepBlack,
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(children: <Widget>[
              Positioned(
                  top: screenHeight / 6,
                  bottom: screenHeight / 9,
                  left: screenWidth / 20,
                  right: screenWidth / 20,
                  child: _buildBottom())
            ])),
      ),
    );
  }
}
