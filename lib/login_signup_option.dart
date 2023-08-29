import 'package:flutter/material.dart';
import 'package:brana_mobile/signup_page.dart';
import 'package:brana_mobile/login_page.dart';

class LoginSignupOption extends StatefulWidget {
  const LoginSignupOption({super.key, required double screenHeight});

  @override
  State<LoginSignupOption> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginSignupOption> {
  late Color myColor;
  late Size mediaSize;


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
          Positioned(bottom: 150, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child:  Column(
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
        const SizedBox(height: 40),
        _buildLoginButton(),
        const SizedBox(height: 40),
        _buildSignupButton(),
        const SizedBox(height: 30),
        _buildOtherLogin(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 10,
        backgroundColor:const Color.fromARGB(255, 44, 51, 53),
        shadowColor:const Color.fromARGB(255, 110, 105, 105),
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("LOGIN"),
    );
  }
    Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 10,
        backgroundColor:const Color.fromARGB(255, 7, 243, 204),
        shadowColor:const Color.fromARGB(255, 110, 105, 105),
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("SIGN UP"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
              child:
              Container(
                decoration:BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 58, 57, 57).withOpacity(0.2),
                      blurRadius: 1.0,
                      spreadRadius: 2.0,
                      offset:const Offset(0,0) ),
                  ]
                ),
                child:
              Tab(icon: Image.asset("assets/images/google.png"))),
              ),
            
              Container(
                decoration:BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 58, 57, 57).withOpacity(0.2),
                      blurRadius: 1.0,
                      spreadRadius: 2.0,
                      offset:const Offset(0,0) ,),
                      
                  ]
                ),
                child:
              Tab(icon: Image.asset("assets/images/facebook.png")),
              ),
                            Container(
                decoration:BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 58, 57, 57).withOpacity(0.2),
                      blurRadius: 1.0,
                      spreadRadius: 2.0,
                      offset:const Offset(0,0) ,),
                      
                  ]
                ),
                child:
              Tab(icon: Image.asset("assets/images/twitter.png")),
          )
          ],
          ),
        ],
      ),
    );
  }
}
