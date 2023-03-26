//import 'dart:ffi';
import 'dart:io';
//import 'dart:js_util';
import 'package:flutter_js/flutter_js.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:tutorial/dbHelper/mongodb.dart';

import '../../config/ui_model.dart';
import '../../config/ui_theme.dart';
import '/pages/loading_pag/loading_pag_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'image_test_model.dart';
export 'image_test_model.dart';

class ImageTestWidget extends StatefulWidget {
  const ImageTestWidget({Key? key}) : super(key: key);

  @override
  _ImageTestWidgetState createState() => _ImageTestWidgetState();
}

class _ImageTestWidgetState extends State<ImageTestWidget> {
  late ImageTestModel _model;
  late String diseaseName;
  late String confidence;
  late String fertlizer;
  late String solution;
  File? imageFile;
  final ImagePicker imagePicker = ImagePicker();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ImageTestModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  Future<bool> diseaseInfo() async {
    bool dbResult = true;
    var db = await mongo.Db.create(
            "mongodb+srv://devarn:devarngratoto@cluster0.klypayl.mongodb.net/diseasesDB?retryWrites=true&w=majority")
        .then((value) {
      print('Connected to MongoDB Atlas successfully.');
      return value;
    }).catchError((error) {
      print('Failed to connect to MongoDB Atlas: $error');
      exit(1);
    });

    await db.open();

    final collection = db.collection("gratoto");

    var query = mongo.where.eq('disease.$diseaseName', {'\$exists': true});
    final result =
        await collection.findOne(mongo.where.eq('disease', diseaseName));
    final fertilizer = result?['Fertilizer'].toString();
    final treatment = result?['Solutions'].toString();
    fertlizer = "";
    solution = " ";
    fertlizer = fertilizer!;
    solution = treatment!;

    print('Fertilizer for $diseaseName: $fertilizer');
    print('Treatment for $diseaseName: $treatment');

    //var fields = <String, dynamic>{'fertilizer': true, 'solutions': true};

    // var result = await collection.findOne(query);
    // var result = await collection
    //   .findOne(mongo.where.eq("disease: '$diseaseName'", {'\$exists': true}));

    await db.close();

    if (result == null) {
      print('No data found for the disease $diseaseName');
    }

    //final fertilizer = result!['fertilizer'] as String;
    //final solutions = result['solutions'] as List<dynamic>;

    //final solutionsString = solutions.join(', ');

    print(diseaseName);
    print(result);

    // showDialog(
    // context: context,
    //builder: (BuildContext context) {
    //return AlertDialog(
    //title: Text("Text values received"),
    //content: Text(result.toString()),
    //actions: [
    //TextButton(
    //child: Text("OK"),
    // onPressed: () {
    //   Navigator.of(context).pop();
    //   },
    //   ),
    //   ],
    //   );
    //   },
    //   );

    await db.close();
    return Future.value(dbResult);
  }

  Future<String> getDiseaseInfo(String diseaseName) async {
    try {
      await MongoDatabase.connect;
      diseaseName = "Grape Black rot";
      var result = await MongoDatabase.userCollection
          .findOne({'Disease.${diseaseName}'}.toList());
      var fertilizer = result.Disease[diseaseName].Fertilizer.toString();
      var solutions = result.Disease[diseaseName].Solutions.toString();
      diseaseName = fertilizer;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Text values received"),
            content: Text(fertilizer),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      return Future.value(diseaseName);
    } finally {}
  }

  void imageUploadFail([String? s]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Image upload has failed"),
          content: Text("Please try uploading again"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> uploadImage() async {
    final uri = Uri.parse(
        "https://us-central1-gratato-381114.cloudfunctions.net/predict");
    var request = http.MultipartRequest('POST', uri);
    bool uploaded = false;
    request.headers['Content-Type'] = 'multipart/form-data';
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile!.path));
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();
        //showDialog(
        //    context: context,
        //   builder: (BuildContext context) {
        //      return AlertDialog(
        //        title: Text("Text values received"),
        //       content: Text(responseString),
        //        actions: [
        //         TextButton(
        //           child: Text("OK"),
        //           onPressed: () {
        //              // Navigator.of(context).pop();
        //            },
        //         ),
        //      ],
        //      );
        //     },
        //    );
        print('Image uploaded successfully');
        String val = responseString;
        List user = val.split(',');

        diseaseName = (user[0]).toString();
        //getDiseaseInfo(diseaseName);

        confidence = (user[1]).toString();
        uploaded = true;
      } else {
        uploaded = false;
        imageUploadFail();
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
    return Future.value(uploaded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF052106),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 520.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 0.0, 20),
                        child: InkWell(
                          onTap: () async {
                            final imagePicker = ImagePicker();
                            XFile? pickedImage = await imagePicker.pickImage(
                                source: ImageSource.camera);
                            if (pickedImage != null) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoadingPagWidget(
                                      diseaseName, fertlizer, solution),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 110.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF052106),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-0.1, 0.0),
                              child: Icon(
                                Icons.photo_camera_rounded,
                                color: Colors.white,
                                size: 75.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            60.0, 0.0, 0.0, 20.0),
                        child: Container(
                          width: 110.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF052106),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.05, -0.25),
                            child: InkWell(
                              onTap: () async {
                                var picture = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                this.setState(() {
                                  imageFile = File(picture!.path);
                                });
                                uploadImage();
                                if (await uploadImage()) {
                                  diseaseInfo();

                                  if (await diseaseInfo()) {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoadingPagWidget(
                                            diseaseName, fertlizer, solution),
                                      ),
                                    );
                                    print("starteedddddddd");
                                  } else
                                    imageUploadFail("db acccses failes");
                                }
                              },
                              child: Icon(
                                Icons.drive_folder_upload,
                                color: Colors.white,
                                size: 75.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.1, -0.58),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(23.0),
                    child: Image.asset(
                      'assets/images/Leaf_H5_Material_Background_On_Green_Gradient_Background.jpg',
                      width: 324.0,
                      height: 429.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.03, -0.61),
                child: Image.asset(
                  'assets/images/GRATOTO__1_-removebg-preview.png',
                  width: 143.7,
                  height: 161.4,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.63, -0.07),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 50.0, 0.0),
                  child: Text(
                    '    Your Plant Doctor In\n            Your Pocket',
                    style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.52, 0.95),
                child: Text(
                  'Upload From \n This Device',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.56, 0.95),
                child: Text(
                  '  Open\nCamera',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
