import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

void login(String email,String password) async {
  try {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data['token']);
      print('acc success');
    } else {
      print('acc failed');
    }
  } catch (e) {
    print(e.toString());
  }
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api Course")),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              controller: emailController,
            ),
            SizedBox(height: 15),

            TextFormField(
              decoration: InputDecoration(hintText: "Password"),
              controller: passwordController,
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                login(
                  emailController.text.toString(),
                  passwordController.text.toString(),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.orange),
                child: Center(child: Text("Login")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
