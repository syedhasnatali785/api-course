import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatelessWidget {
  ExampleTwo({super.key});
  List<Photos> photosList = [];
  Future<List<Photos>> getPhotos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos?_limit=20'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      for (Map i in data) {
        Photos photos = Photos(
          title: i['title'].toString(),
          url: i['url'].toString(),
        );
        photosList.add(photos);
      }
      return photosList;
    } else {
      throw Exception("Failed to Load photos");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Build running");
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error $snapshot"));
                  }
                  return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(photosList[index].title.toString()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Photos {
  String title, url;
  Photos({required this.title, required this.url});
}
