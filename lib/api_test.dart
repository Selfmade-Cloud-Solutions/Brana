import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}


class _MyPageState extends State<MyPage> {
  List<dynamic> data = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://app.berana.app/api/method/brana_audiobook.api.editors_picks_api.retrieve_editors_picks'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data = responseData['message'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Data Page'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(data[index]['thumbnail']),
              title: Text(data[index]['title']),
              subtitle: Text(data[index]['description']),
            );
          },
        ),
      ),
    );
  }
}
