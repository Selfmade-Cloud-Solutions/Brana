import 'package:brana_mobile/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double bottomPadding;
    double toppadding;
    double leftRightPadding;

    mediaSize = MediaQuery.of(context).size;
    toppadding = mediaSize.height;
    bottomPadding = mediaSize.height / 5;
    leftRightPadding = mediaSize.width * 0.05;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: branaDeepBlack,
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
              left: leftRightPadding,
              top: toppadding / 9,
              right: leftRightPadding,
              bottom: toppadding / 25),
          child: Container(
            color: branaDarkBlue,
            width: mediaSize.width - 50,
            height: mediaSize.height / 1.2,
            child: Column(
              children: [
                Container(
                  child: _buildTop(),
                ),
                Container(
                  child: _buildForm(),
                ),
                // Container(
                //   child: _buildBottom(),
                // )
              ],
            ),
          ),
        ),
      ]),
      // body: SafeArea(
      //   child: Stack(alignment: Alignment.topCenter, children: [
      //     Positioned(
      //         // top: toppadding,
      //         // bottom: bottomPadding,
      //         left: leftRightPadding,
      //         right: leftRightPadding,
      //         child: _buildBottom())
      //   ]),
      // )
    );
  }

  Widget _buildTop() {
    return SizedBox(
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: SizedBox(
        // width: mediaSize.width,
        // height: mediaSize.height - 350,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          color: kLightBlue.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            // child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double toppadding = mediaSize.height;
    double leftpadding = mediaSize.width;
    double screenHeight = mediaSize.height;
    double fontSize = screenWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: leftpadding),
            // child: _buildTop(),
          ),
        ),
        Center(
          child: Text(
            "Welcome Back",
            style: GoogleFonts.jost(
              color: branaWhite,
              fontSize: fontSize / 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: screenHeight / 20,
        ),
        Center(
          child: _buildPrimaryText("Please Login"),
        ),
        SizedBox(height: screenHeight / 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: leftpadding / 20),
          child: _buildInputFieldEmail(emailController),
        ),
        SizedBox(
          height: screenHeight / 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: leftpadding / 20),
          child:
              _buildInputFieldPassword(passwordController, isPassword: false),
        ),
        SizedBox(height: screenHeight / 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: leftpadding / 20),
          child: _buildRememberForgot(),
        ),
        SizedBox(height: screenHeight / 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: leftpadding / 20),
          child: _buildLoginButton(),
        ),
        SizedBox(
          height: screenHeight / 20,
        ),
      ],
    );
  }

  Widget _buildPrimaryText(String text) {
    return Text(
      text,
      style: GoogleFonts.jost(
        color: branaWhite,
      ),
    );
  }

  Widget _buildInputFieldEmail(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: GoogleFonts.jost(color: branaWhite),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildInputFieldPassword(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: GoogleFonts.jost(color: branaWhite),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          icon: isPasswordVisible
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
      obscureText: !isPasswordVisible,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberUser,
              onChanged: (value) {
                setState(() {
                  rememberUser = value!;
                });
              },
            ),
            _buildPrimaryText("Remember me"),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPassword()),
            );
          },
          child: _buildPrimaryText("Forgot password"),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
    double screenHeight = mediaSize.height;
    double toppadding = mediaSize.height;
    double leftpadding = mediaSize.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(leftpadding / 4.5, toppadding / 150,
          leftpadding / 4, toppadding / 200),
      child: SizedBox(
        width: screenWidth / 3,
        height: screenHeight / 20,
        child: ElevatedButton(
          onPressed: () {
            // debugPrint("Email : ${emailController.text}");
            // debugPrint("Password : ${passwordController.text}");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Navigation()),
            );
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              backgroundColor: branaPrimaryColor),
          child: Text(
            "LOGIN",
            style: GoogleFonts.jost(
              color: branaWhite,
            ),
          ),
        ),
      ),
    );
  }
}
