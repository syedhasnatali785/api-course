import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/example_three.dart';

class ExampleFour extends StatelessWidget {
  ExampleFour({super.key});
  var data;
  Future<void> getApiDat() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    if (response.statusCode == 200) {
      return data = jsonDecode(response.body.toString());
    } else {
      throw Exception(' Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getApiDat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Reusable(
                        title: 'name',
                        value: data[index]['name'].toString(),
                      ),
                      Reusable(
                        title: 'username',
                        value: data[index]['username'].toString(),
                      ),
                      Reusable(
                        title: 'email',
                        value: data[index]['email'].toString(),
                      ),
                      Reusable(
                        title: 'address',
                        value: data[index]['address']['street'].toString(),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  ReusableRow({super.key, required this.title, required this.value});
  String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}
