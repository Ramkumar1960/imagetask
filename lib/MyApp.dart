import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descpController = TextEditingController();
  final picker = ImagePicker();
  XFile? _image;
  String? _imageUrl;

  Future<void> _captureImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = pickedFile;
      });
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _uploadImageToFirebaseStorage() async {
    if (_image == null) {
      return;
    }

    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');

      final UploadTask uploadTask = storageReference.putFile(File(_image!.path));

      final TaskSnapshot storageTaskSnapshot = await uploadTask;
      final imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;
      });

      print('Image uploaded successfully. URL: $_imageUrl');
      await FirebaseFirestore.instance.collection("wallpapers").add({
        'title': titleController.text,
        'desc': descpController.text,
        'url': _imageUrl
      });
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path)),
            TextFormField(
              controller: titleController,
              validator: (value){
                if(value!.isEmpty){
                  return "It is Empty";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelText: "Name",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Set the border color
                  borderRadius: BorderRadius.circular(10.0), // Adjust the border radius
                ),
              ),
            ),
            TextFormField(
              controller: descpController,
              validator: (value){
                if(value!.isEmpty){
                  return "It is Empty";
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelText: "Category",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green), // Set the border color
                  borderRadius: BorderRadius.circular(10.0), // Adjust the border radius
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Capture Image'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green.shade800, // Background color
                textStyle: TextStyle(
                  color: Colors.white, // Text color
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _uploadImageToFirebaseStorage,
              child: Text('Upload Image to Firebase'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green.shade900, // Background color
                textStyle: TextStyle(
                  color: Colors.white, // Text color
                ),
              ),
            ),
            _imageUrl != null
                ? Image.network(
              _imageUrl!,
              height: 150.0,
              width: 150.0,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}