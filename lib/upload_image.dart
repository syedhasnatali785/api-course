import 'dart:io' show File;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  //file path store
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('failed');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = "Statyc Tytle";
    var multiPort = http.MultipartFile('image', stream, length);
    request.files.add(multiPort);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Success');
      setState(() {
        showSpinner = false;
      });
    } else {
      print('Failed');
      setState(() {
        showSpinner = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  child: image == null
                      ? Center(
                          child: Container(
                            height: 25,
                            width: 110,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Text('Select Image'),
                          ),
                        )
                      : Container(child: Image.file(image!, fit: BoxFit.cover)),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(color: Colors.red),
                child: Center(
                  child: Text("Upload", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
