import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<NewPassword> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
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
            "SET NEW PASSWORD",
            style: GoogleFonts.jost(
              color: branaWhite,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              _buildInputFieldPassword(passwordController, isPassword: false),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildInputFieldRetypePassword(passwordController2),
        ),
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

  Widget _buildInputFieldPassword(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
        labelText: 'New Password',
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

  Widget _buildInputFieldRetypePassword(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
        labelText: 'Confirm New Password',
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

  Widget _buildButton() {
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
        "CHANGE PASSWORD",
        style: GoogleFonts.jost(
          color: branaWhite,
        ),
      ),
    );
  }
}
