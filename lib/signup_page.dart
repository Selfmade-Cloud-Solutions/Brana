import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
    final apiEndpoint =
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

    if (response.statusCode == 200 && _formKey.currentState!.validate()) {
      // Successful signup, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    } else {
      // Error in the signup process, display a snackbar with an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign Up Failed!',
          style: GoogleFonts.jost(
            color:Colors.red,
          ),)),
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
        } else if (!RegExp(r'^[a-zA-Z0-9._]+$]').hasMatch(value)) {
          return 'Please enter only letters, number or _';
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
