import 'package:brana_mobile/new_password.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ResetPassword> {
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            "Code Sent On Your Email",
            style: GoogleFonts.jost(
              color: branaWhite,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: _buildPrimaryText(
              "Enter the verification number sent to your email"),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildInputFieldEmail(emailController),
        ),
        const SizedBox(height: 30),
        const SizedBox(height: 5),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: _buildButton(),
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

  Widget _buildInputFieldEmail(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
        labelStyle: GoogleFonts.jost(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        // debugPrint("Email : ${emailController.text}");
        // debugPrint("Password : ${passwordController.text}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewPassword()),
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
        "VERIFY",
        style: GoogleFonts.jost(
          color: branaWhite,
        ),
      ),
    );
  }
}
