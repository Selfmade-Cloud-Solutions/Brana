import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late Color myColor;
  late Size mediaSize;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController dateofbirthController = TextEditingController();
  bool isPasswordVisible = false;
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    double bottomPadding;
    double leftRightPadding;

    mediaSize = MediaQuery.of(context).size;

    bottomPadding = mediaSize.height * 0.01;
    leftRightPadding = mediaSize.width * 0.05;

    return Scaffold(
        backgroundColor: branaDeepBlack,
        body: Stack(children: [
          Positioned(
              bottom: bottomPadding,
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
            child: _buildInputFieldFirstName(firstnameController),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildInputFieldLastName(lastnameController),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildInputFieldPhoneNumber(phonenumberController),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildInputFieldEmail(emailController),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildInputFieldDateOfBirth(dateofbirthController),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                _buildInputFieldPassword(passwordController, isPassword: true),
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
          return 'please enter your first name';
        } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildInputFieldPassword(TextEditingController controller,
      {isPassword = false}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
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
        labelText: 'Password',
        labelStyle: GoogleFonts.jost(color: branaWhite),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: branaWhite),
            borderRadius: BorderRadius.circular(8)),
      ),
      obscureText: !isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$')
            .hasMatch(value)) {
          return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
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

  Widget _buildInputFieldDateOfBirth(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: branaWhite),
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.done),
        labelText: 'Date of Birth',
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
          return 'please enter your birthdate';
        }
        return null;
      },
    );
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          debugPrint("FirstName : ${firstnameController.text}");
          debugPrint("LastName : ${lastnameController.text}");
          debugPrint("Email : ${emailController.text}");
          debugPrint("Password : ${passwordController.text}");
          debugPrint("Phone Number : ${phonenumberController.text}");
          debugPrint("Date of Birth : ${dateofbirthController.text}");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Navigation()),
          );
        }
      },
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
