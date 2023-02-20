import 'dart:io';

import 'package:b/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return MaterialApp(home: Login());
      },
    ),
  );
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
    Navigator.of(context).pop();
  }

  openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Choose one of the options"),
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(9.0)),
                  GestureDetector(
                    child: Text("Camera"),
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (null), icon: Image.asset('images/logo.png'))
        ],
        shadowColor: Colors.lightGreen,
        title: const Text(
          "Gratato",
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
        backgroundColor: Color.fromARGB(255, 12, 245, 124),
      ),
      body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        decideImageView(),
        ElevatedButton(
          onPressed: () {
            showChoiceDialog(context);
            ElevatedButton.styleFrom(backgroundColor: Colors.green);
          },
          child: Text(
            "Select leaf image",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ],
        ),
      ),
    );
  }
}
