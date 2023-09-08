import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/navigation.dart';

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
  bool isPasswordVisible = false;
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColorLight;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
      ),
      child: Scaffold(
        backgroundColor: branaPrimaryColor,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 150, left: 10, right: 10, child: _buildBottom()),
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
        color: kLightBlue.withOpacity(0.1),
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
        const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          "Welcome",
          style: TextStyle(
            color: branaWhite,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildPrimaryText("Fill Form To Register"),),
        const SizedBox(height: 20),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildInputFieldFirstName(firstnameController),),
        const SizedBox(height: 5),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildInputFieldLastName(lastnameController),),
        const SizedBox(height: 5),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildInputFieldPhoneNumber(phonenumberController),),
        const SizedBox(height: 5),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildInputFieldEmail(emailController),),
        const SizedBox(height: 5),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildInputFieldDateOfBirth(dateofbirthController),),
        const SizedBox(height: 5),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildInputFieldPassword(passwordController, isPassword: true),),
        const SizedBox(height: 15),
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: _buildSignupButton(),),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildPrimaryText(String text) {
    return Text(
      text,
      style: const TextStyle(color: branaWhite),
    );
  }

  Widget _buildInputFieldFirstName(TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.done),
          hintText: 'First Name',
          hintStyle: TextStyle(color: branaWhite)
        ));
  }

  Widget _buildInputFieldLastName(TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.done),
          hintText: 'Last Name',
          hintStyle: TextStyle(color: branaWhite)
        ));
  }

  Widget _buildInputFieldEmail(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.done),
        hintText: 'Email',
          hintStyle: TextStyle(color: branaWhite)
      ),
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
          hintStyle: const TextStyle(color: branaWhite)
      ),
      obscureText: !isPasswordVisible,
    );
  }

  Widget _buildInputFieldPhoneNumber(TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.done),
          hintText: 'Phone Number',
          hintStyle: TextStyle(color: branaWhite)
        ));
  }

  Widget _buildInputFieldDateOfBirth(TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.done),
          hintText: 'Date of Birth',
          hintStyle: TextStyle(color: branaWhite)
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
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Navigation()),
        );},
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        minimumSize: const Size.fromHeight(60),
      ),
      child: Text("SignUp",
        style: TextStyle(
          color: branaPrimaryColor,),),
    );
  }
}
