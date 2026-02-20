import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled1/Model/user_model.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatelessWidget {
  ExampleThree({super.key});
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserAp() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users?_limit=10'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserAp(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    if (!snapshot.hasData) {
                      return Center(child:  CircularProgressIndicator(),);
                    } else {
                      return Card(
                        child: Column(
                          children: [
                   Reusable(title: 'Name:', value: snapshot.data![index].name.toString()),
                            Reusable(title: 'username: ', value: snapshot.data![index].username.toString()),
                            Reusable(title: 'email', value: snapshot.data![index].email.toString()),
                          Reusable(title: 'Address', value: snapshot.data![index].address!.geo!.lat.toString())
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class Reusable extends StatelessWidget {
Reusable({super.key, required this.title, required this.value});
String  title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Text(title), Text(value)
      ],),
    );
  }
}
