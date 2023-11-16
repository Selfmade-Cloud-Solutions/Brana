import 'package:flutter/material.dart';
import 'package:brana_mobile/user/user_data.dart';
import 'package:brana_mobile/widgets/appbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';

// This class handles the Page to edit the About Me Section of the User Profile.
class EditDescriptionFormPage extends StatefulWidget {
  const EditDescriptionFormPage({super.key});

  @override
  State<EditDescriptionFormPage> createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  var user = UserData.myUser;
  DateTime? _selectedDate;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: branaDeepBlack,
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: 350,
                    child: Text(
                      "Update your birthday",
                      style: GoogleFonts.jost(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: branaWhite),
                    )),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 50,
                    width: 350,
                    child: TextButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        _selectedDate != null
                            ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'
                            : 'Select your birthday',
                        style: GoogleFonts.jost(
                          color: _selectedDate != null
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                            Text(
                              'Update',
                              style: GoogleFonts.jost(fontSize: 15),
                            ),
              ]),
        ));
  }
}
