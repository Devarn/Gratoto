import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    title: "Gratoto",
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File? imageFile;
  final ImagePicker imagePicker = ImagePicker();

  openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.pop(context);

  }

  openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.pop(context);
  }

  Future uploadImage() async {
    final uri = Uri.parse("http://localhost:8000/predict");
    var request = http.MultipartRequest('POST', uri);
    request.headers['Content-Type'] = 'application/json';
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed');
    }
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Choose one of the options"),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      openGallery(context);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(9.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      openCamera(context);
                    },
                  )
                ],
              )));
        });
  }

  Widget decideImageView() {
    if (imageFile == null) {
      //return Text("No image selected");
      //return Text("no image selected");
      return Image.asset(
        'images/logo.png',
        height: 180,
        width: 180,
      );
    } else {
      return Image.file(imageFile!, width: 450, height: 450);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner:
    false;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (null), icon: Image.asset('images/logo.png'))
        ],
        shadowColor: Colors.lightGreen,
        title: const Text(
          "Gratoto",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: const Color.fromARGB(255, 12, 245, 124),
      ),
      body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        decideImageView(),
        ElevatedButton(
          onPressed: () {
            showChoiceDialog(context);
          },
          style:
          ElevatedButton.styleFrom(backgroundColor: Colors.green,padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 20)),
          child: const Text(
            "Select leaf image",
            style: TextStyle(fontSize: 25),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            uploadImage();
            // Handle button press
          },
          child: const Text('Upload image'),
        )
      ],
        ),
      ),
    );
  }
}
