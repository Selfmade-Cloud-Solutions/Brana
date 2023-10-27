import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EditorsPicksPage extends StatefulWidget {
  const EditorsPicksPage({Key? key}) : super(key: key);

  @override
  State<EditorsPicksPage> createState() => _EditorsPicksPageState();
}

class _EditorsPicksPageState extends State<EditorsPicksPage> {
  List<Map<String, dynamic>> _editorsPicks = [];

  @override
  void initState() {
    super.initState();
    _fetchEditorsPicks();
  }

  Future<void> _fetchEditorsPicks() async {
    final response = await get(Uri.parse('https://app.berana.app/api/method/brana_audiobook.api.editors_picks_api.retrieve_editors_picks'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<Map<String, dynamic>>;
      setState(() {
        _editorsPicks = data;
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editors\' Picks'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _editorsPicks.length,
          itemBuilder: (context, index) {
            final editorPick = _editorsPicks[index];
            return Card(
              child: ListTile(
                title: Text(editorPick['title']),
                subtitle: Text(editorPick['author']),
                leading: Image.network(editorPick['image_url']),
              ),
            );
          },
        ),
      ),
    );
  }
}