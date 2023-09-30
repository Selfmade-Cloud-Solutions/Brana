import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/navigation.dart';

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
    myColor = Theme.of(context).primaryColorLight;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: branaPrimaryColor,
      ),
      child: Scaffold(
        backgroundColor: branaPrimaryColor,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 50, left: 10, right: 10, child: _buildBottom()),
        ]),
      ),
    );
  }

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Welcome Back",
            style: TextStyle(
              color: branaDark,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildPrimaryText("Please login to Brana"),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildInputFieldEmail(emailController),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildInputFieldPassword(passwordController, isPassword: true),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildRememberForgot(),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: _buildLoginButton(),
        ),
        const SizedBox(height: 35),
      ],
    );
  }

  Widget _buildPrimaryText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: branaDark,
      ),
    );
  }

  Widget _buildInputFieldEmail(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.done),
          hintText: 'Email',
          hintStyle: TextStyle(color: branaDark)),
    );
  }

  Widget _buildInputFieldPassword(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
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
          hintText: 'Password',
          hintStyle: const TextStyle(color: branaDark)),
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
                }),
            _buildPrimaryText("Remember me"),
          ],
        ),
        TextButton(
            onPressed: () {}, child: _buildPrimaryText("Forgot password"))
      ],
    );
  }

  Widget _buildLoginButton() {
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
      child: const Text(
        "LOGIN",
        style: TextStyle(
          color: branaDark,
        ),
      ),
    );
  }
}
