import 'package:flutter/material.dart';
import 'package:brana_mobile/signup_page.dart';
import 'package:brana_mobile/login_page.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSignupOption extends StatefulWidget {
  const LoginSignupOption({super.key, required double screenHeight});

  @override
  State<LoginSignupOption> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginSignupOption> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late Size mediaSize;
  late Color myColor;

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      height: mediaSize.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: branaPrimaryColor.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: _buildLoginButton(),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: _buildSignupButton(),
        ),
        const SizedBox(height: 30),
        _buildOtherLogin(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPrimaryText(String text) {
    return Text(
      text,
      style: const TextStyle(color: branaDark),
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
      child: const Text("LOGIN",
          style: TextStyle(
            color: branaDark,
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
        backgroundColor: branaDark,
        shadowColor: const Color.fromARGB(50, 110, 105, 105),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text("SIGN UP",
          style: TextStyle(
            color: branaPrimaryColor,
            fontWeight: FontWeight.w800,
          )),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildPrimaryText("Or Login with"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(
                icon: InkWell(
                    onTap: () async {
                      final GoogleSignInAccount? googleUser =
                          await googleSignIn.signIn();

                      if (googleUser != null) {
                        // user signed in
                      } else {
                        // user canceled
                      }
                    },
                    child: Image.asset("assets/images/google.png")),
              ),
              Tab(icon: Image.asset("assets/images/facebook.png")),
              Tab(icon: Image.asset("assets/images/twitter.png"))
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
    return Container(
      decoration: BoxDecoration(
        color: branaPrimaryColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 10, left: 10, right: 10, child: _buildBottom()),
        ]),
      ),
    );
  }
}
