import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignupPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController dateofbirthController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColorLight;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(1), BlendMode.color),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 30, child: _buildTop()),
          Positioned(bottom: 50, child: _buildBottom()),
        ]),
      ),
    );
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
        Text(
          "Welcome",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w900),
        ),
        _buildGreyText("Fill Form To Register"),
        const SizedBox(height: 20),
        _buildInputFieldFirstName(firstnameController),
        const SizedBox(height: 5),
        _buildInputFieldLastName(lastnameController),
        const SizedBox(height: 5),
        _buildInputFieldPhoneNumber(phonenumberController),
        const SizedBox(height: 5),
        _buildInputFieldEmail(emailController),
        const SizedBox(height: 5),
        _buildInputFieldDateOfBirth(dateofbirthController),
        const SizedBox(height: 5),
        _buildInputFieldPassword(passwordController, isPassword: true),
        const SizedBox(height: 15),
        _buildSignupButton(),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputFieldFirstName(TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.done),
          hintText: 'First Name',
        ));
  }

  Widget _buildInputFieldLastName(TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.done),
          hintText: 'Last Name',
        ));
  }

  Widget _buildInputFieldEmail(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.done),
        hintText: 'Email',
      ),
    );
  }

  Widget _buildInputFieldPassword(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.remove_red_eye),
        hintText: 'Password',
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildInputFieldPhoneNumber(TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.done),
          hintText: 'Phone Number',
        ));
  }

  Widget _buildInputFieldDateOfBirth(TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.done),
          hintText: 'Date of Birth',
        ));
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("FirstName : ${firstnameController.text}");
        debugPrint("LastName : ${lastnameController.text}");
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
        debugPrint("Phone Number : ${phonenumberController.text}");
        debugPrint("Date of Birth : ${dateofbirthController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("SignUp"),
    );
  }
}
