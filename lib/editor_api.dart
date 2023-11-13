import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://librivox.org/api/feed/audiobooks'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['user'] as int,
      id: json['first_name'] as int,
      title: json['email'] as String,
    );
  }
}

void main() => runApp(const AudiobookList());

class AudiobookList extends StatefulWidget {
  const AudiobookList({Key? key}) : super(key: key);

  @override
  State<AudiobookList> createState() => _AudiobookListState();
}

class _AudiobookListState extends State<AudiobookList> {
  late Future<Album> futureAlbum;
  ConnectivityResult? connectivityResult;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    initializeConnectivity();
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
    });
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initializeConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      connectivityResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (connectivityResult == ConnectivityResult.none) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('No Internet Connection'),
          ),
          body: const Center(
            child:  Text('Please check your internet connection.'),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Text('Failed to load album');
            },
          ),
        ),
      ),
    );
  }
}