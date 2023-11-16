// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:brana_mobile/forgot_password.dart';
import 'package:brana_mobile/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double leftRightPadding;

    mediaSize = MediaQuery.of(context).size;
    leftRightPadding = mediaSize.width * 0.05;

    return Scaffold(
      backgroundColor: branaDeepBlack,
      body: Padding(
        padding: EdgeInsets.only(
            left: leftRightPadding,
            top: mediaSize.height / 20,
            right: leftRightPadding,
            bottom: mediaSize.height / 343),
        child: Container(
          color: branaDarkBlue,
          width: mediaSize.width - 50,
          height: mediaSize.height / 1.2,
          child: Column(
            children: [
              _buildTop(),
              _buildForm(),
            ],
          ),
        ),
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

  Widget _buildForm() {
    mediaSize = MediaQuery.of(context).size;
    double screenWidth = mediaSize.width;
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
          child: _buildSignup(),
        ),
        SizedBox(height: screenHeight / 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: leftpadding / 20),
          child: Center(child: _buildLoginButton()),
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

  Widget _buildSignup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupPage()),
            );
          },
          child: _buildPrimaryText("Not Registered ?"),
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
    return SizedBox(
      width: screenWidth / 3,
      height: screenHeight / 20,
      child: ElevatedButton(
        onPressed: () async {
          if (_validateInputs()) {
            final bool success = await _login();
            if (success) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Navigation()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.transparent,
                    content: Text('Incorrect username or password',
                        style: TextStyle(color: Colors.red))),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            backgroundColor: branaPrimaryColor),
        child: Text(
          "LOGIN",
          style: GoogleFonts.jost(
            color: branaWhite,
          ),
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.transparent,
            content: Text('Please enter email and password',
                style: TextStyle(color: Colors.red))),
      );
      return false;
    }
    return true;
  }

  Future<bool> _login() async {
    const apiUrl =
        'https://app.berana.app/api/method/brana_audiobook.api.auth_api.login';

    Dio dio = Dio(); // Create a Dio instance

    try {
      // Set up the headers
      dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
      dio.options.headers['authHeader'] = 'Your-Header-Value';

      // Set up the request data
      Map<String, dynamic> requestData = {
        'identifier': emailController.text,
        'password': passwordController.text,
      };

      // Make the request
      final response =
          await dio.post(apiUrl, data: FormData.fromMap(requestData));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = response.data;
        if (responseJson.containsKey('message') &&
            responseJson['message'] != null) {
          // Extract and store headers in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String>? cookies = response.headers['set-cookie'];
          Map<String, String> headers = extractHeadersFromCookies(cookies);

          print('Received headers: ${response.headers}');
          prefs.setString('authHeaders', jsonEncode(headers));
          prefs.setBool('isLoggedIn', true);
          return true;
        }
      } else {
        // Handle other status codes if needed
      }
    } catch (error) {
      // Handle Dio errors, if any
      print('Dio error: $error');
    }

    return false;
  }

  Map<String, String> extractHeadersFromCookies(List<String>? cookies) {
    Map<String, String> headers = {};

    if (cookies != null) {
      for (String cookieString in cookies) {
        Cookie cookie = Cookie.fromSetCookieValue(cookieString);

        if (cookie.name == 'sid' ||
            cookie.name == 'system_user' ||
            cookie.name == 'full_name' ||
            cookie.name == 'user_id' ||
            cookie.name == 'user_image') {
          headers[cookie.name] = cookie.value;

    print(headers);
        }
      }
    }

    return headers;
  }
}
