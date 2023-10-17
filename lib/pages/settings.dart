import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            buildChangePassword(context, "Change password"),
            buildAccountOptionRow(context, "Content settings"),
            buildPreferences(context, "Preferences"),
            buildAccountOptionRow(context, "Privacy and security"),
            buildTermsAndConditions(context, "Terms and conditions"),
            buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildChangePassword(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
    backgroundColor: Colors.black,
    title: const Text('Change Password', 
    style:TextStyle(color: Colors.white)),
    actions: [
      TextField(
        decoration: InputDecoration(
          labelText: 'Old Password',
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      TextField(
        decoration: InputDecoration(
          labelText: 'New Password',
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          
        ),
      ),
      Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 220,
          height: 28,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Update',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    ),]
  );

            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildTermsAndConditions(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return  AlertDialog(
    backgroundColor: Colors.black,
    title: const Text('Brana Audiobooks Terms and Conditions', 
    style:TextStyle(color: Colors.white)),
    
      content:SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(16.0), 
          child:RichText(
  text: const TextSpan(
    style: TextStyle(
      fontSize: 16, 
      color: Colors.white
    ),
    children: [
      TextSpan(text: "Terms and Conditions\n",
      style: TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(
        text: "\n1. Introduction\n", 
        style: TextStyle(fontWeight: FontWeight.bold)  
      ),
      TextSpan(text: "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
      TextSpan(
        text: "\n2. Intellectual Property Rights\n",
        style: TextStyle(fontWeight: FontWeight.bold)  
      ),
      TextSpan(text: "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
      TextSpan(
        text: "\n3. Intellectual Property Rights\n",
        style: TextStyle(fontWeight: FontWeight.bold)  
      ),
      TextSpan(text: "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
      TextSpan(
        text: "\n4. User Accounts\n",
        style: TextStyle(fontWeight: FontWeight.bold)  
      ),
      TextSpan(text: "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
      TextSpan(
        text: "\n5. Introduction\n", 
        style: TextStyle(fontWeight: FontWeight.bold)  
      ),
      TextSpan(text: "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
      TextSpan(
        text: "\n6. Intellectual Property Rights\n",
        style: TextStyle(fontWeight: FontWeight.bold)  
      ),
      TextSpan(text: "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
      TextSpan(
        text: "\n7. Intellectual Property Rights\n",
        style: TextStyle(fontWeight: FontWeight.bold)  
      ),
      TextSpan(text: "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
      TextSpan(
        text: "\n8. User Accounts\n",
        style: TextStyle(fontWeight: FontWeight.bold)  
      ),
      TextSpan(text: "\n These terms and conditions govern your use of the audiobook streaming app. By accessing or using the app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms and conditions, you must not use the app.\n"),
      
    ]
  )
)
    )  
      )    
        );

            });
  
      },
      child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      )),
    );
  }


  GestureDetector buildPreferences(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  ],
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
Widget buildLogoutButton(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
              width: 250,
              height: 28,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _logoutDialog(context),
                  );
                },
                child: const Text('Logout',
                style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold)),
              ))));
}


// dialog widget

Widget _logoutDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.black,
    title: const Text('Logout Confirmation',
    style: TextStyle(color: Colors.white)),
    content: const Text('Are you sure you want to logout?',
    style: TextStyle(color: Colors.white)),
    actions: [
      TextButton(
        onPressed: () async {
          // Log out user
          // await AuthService().signOut();

          // Navigate to login page
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Text(
          'Logout',
          style: TextStyle(fontSize: 15),
        ),
      ),
      TextButton(
          onPressed: () => Navigator.pop(context), child: const Text('No'))
    ],
  );
}

