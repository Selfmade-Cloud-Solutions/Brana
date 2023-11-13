// ignore_for_file: use_build_context_synchronously

import 'package:brana_mobile/login_page.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late Size mediaSize;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController username = TextEditingController();
  bool rememberUser = false;

  Future<void> signUp() async {
    const apiEndpoint =
        'https://app.berana.app/api/method/brana_audiobook.api.auth_api.signup';

    final Map<String, dynamic> signUpData = {
      'firstname': firstname.text,
      'lastname': lastname.text,
      'username': username.text,
      'email': email.text,
      'phonenumber': phonenumber.text,
    };

    final response = await http.post(
      Uri.parse(apiEndpoint),
      body: signUpData,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (responseBody.containsKey('message')) {
        final dynamic message = responseBody['message'];

        if (message is Map && message.containsKey('message')) {
          final String errorMessage = message['message'];

          if (errorMessage.toLowerCase().contains('already registered')) {
            // Username is already in use, show the error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.transparent,
                content: Text(
                  'Username is already registered. Please try another name.',
                  style: GoogleFonts.jost(color: Colors.red),
                ),
              ),
            );
            return;
          }
        }
      }
      if (_formKey.currentState!.validate()) {
      // Successful signup, show a dialog popup
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor:kLightBlue.withOpacity(0.5) ,
            title:  Text('Signup Successful',
            style: GoogleFonts.jost(
                          fontSize: 18,
                          height: 1,
                          color: branaWhite,
                          fontWeight: FontWeight.bold,
                                    ),
            ),
            content: Text('You have successfully signed up! please check your email for password link',
            style: GoogleFonts.jost(
                          fontSize: 18,
                          height: 1,
                          color: branaWhite,
                                    ),),
            actions: <Widget>[
              ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 10,
          minimumSize: const Size.fromHeight(50),
          backgroundColor: branaPrimaryColor),
      child: Text(
        "Continue",
        style: GoogleFonts.jost(
          color: branaWhite,
        ),
      ),
    )
            ],
          );
        },
      );
    }
  }  else {
      // Error in the signup process, display a snackbar with a generic error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Sign Up Failed!',
            style: GoogleFonts.jost(color: Colors.red),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double topPadding;
    double leftRightPadding;

    mediaSize = MediaQuery.of(context).size;

    topPadding = mediaSize.height * 0.03;
    leftRightPadding = mediaSize.width * 0.05;

    return Scaffold(
        backgroundColor: branaDeepBlack,
        body: Stack(children: [
          Positioned(
              top: topPadding,
              left: leftRightPadding,
              right: leftRightPadding,
              child: _buildBottom())
        ]));
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
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
          padding: const EdgeInsets.all(20.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
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
              "Welcome",
              style: GoogleFonts.jost(
                color: branaWhite,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: _buildPrimaryText("Fill Form To Register"),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildInputFieldFirstName(firstname),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildInputFieldLastName(lastname),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildInputFieldPhoneNumber(phonenumber),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildInputFieldEmail(email),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildInputFieldUsername(username),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: _buildSignupButton(),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildPrimaryText(String text) {
    return Text(
      text,
      style: GoogleFonts.jost(color: branaWhite),
    );
  }

  Widget _buildInputFieldFirstName(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
          suffixIcon: const Icon(Icons.done),
          labelText: 'First Name',
          labelStyle: GoogleFonts.jost(color: branaWhite),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: branaWhite),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: branaWhite),
              borderRadius: BorderRadius.circular(8))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter your first name';
        } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
          return 'Please enter only letters';
        }
        return null;
      },
    );
  }

  Widget _buildInputFieldLastName(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
          suffixIcon: const Icon(Icons.done),
          labelText: 'Last Name',
          labelStyle: GoogleFonts.jost(color: branaWhite),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: branaWhite),
              borderRadius: BorderRadius.circular(8))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter your last name';
        } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
          return 'Please enter only letters';
        }
        return null;
      },
    );
  }

  Widget _buildInputFieldUsername(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
          suffixIcon: const Icon(Icons.done),
          labelText: 'Set Username',
          labelStyle: GoogleFonts.jost(color: branaWhite),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: branaWhite),
              borderRadius: BorderRadius.circular(8))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please set username';
        } 
        return null;
      },
    );
  }

  Widget _buildInputFieldEmail(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.done),
        labelText: 'Email',
        labelStyle: GoogleFonts.jost(color: branaWhite),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter your email address';
        } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildInputFieldPhoneNumber(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.done),
        labelText: 'Phone Number',
        labelStyle: GoogleFonts.jost(color: branaWhite),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter your phone number';
        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'Please enter only numbers';
        }
        return null;
      },
    );
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: signUp,
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          minimumSize: const Size.fromHeight(60),
          backgroundColor: branaPrimaryColor),
      child: Text(
        "SignUp",
        style: GoogleFonts.jost(
          color: branaWhite,
        ),
      ),
    );
  }
}
