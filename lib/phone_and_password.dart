import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/navigation.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

class PhoneAndPassword extends StatefulWidget {
  const PhoneAndPassword({super.key});

  @override
  State<PhoneAndPassword> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PhoneAndPassword> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColorLight;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: branaPrimaryColor,
      ),
      child: Scaffold(
        backgroundColor: branaDeepBlack,
        body: Stack(children: [
          Positioned(bottom: 50, left: 10, right: 10, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 100,
          height: 100,
        ),
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
        color: kLightBlue.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: _buildTop(),
          ),
        ),
        Center(
          child: Text(
            "Complete registration",
            style: GoogleFonts.jost(
              color: branaWhite,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: _buildPrimaryText("Set Password to complete registration"),
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          // child: buildDatePicker(context),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              _buildInputFieldPassword(passwordController, isPassword: false),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildInputFieldRepeatPassword(passwordController2,
              isPassword: false),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: _buildLoginButton(context),
        ),
        const SizedBox(height: 35),
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

  Widget _buildInputFieldPassword(
    TextEditingController controller, {
    isPassword = false,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.jost(color: Colors.white), // Add text style
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: GoogleFonts.jost(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
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

  Widget _buildInputFieldRepeatPassword(
    TextEditingController controller2, {
    isPassword = false,
  }) {
    return TextField(
      controller: controller2,
      style: GoogleFonts.jost(color: Colors.white), // Add text style
      decoration: InputDecoration(
        labelText: 'Repeat Password',
        labelStyle: GoogleFonts.jost(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
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

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // debugPrint("Email : ${emailController.text}");
        // debugPrint("Password : ${passwordController.text}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Navigation()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: branaPrimaryColor,
        backgroundColor: branaPrimaryColor,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        "Continue",
        style: GoogleFonts.jost(
          color: branaWhite,
        ),
      ),
    );
  }
}
