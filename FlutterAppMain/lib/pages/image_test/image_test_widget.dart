import 'dart:io';
//import 'dart:js_util';
import 'package:flutter_js/flutter_js.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tutorial/index.dart';
import '../../config/ui_model.dart';
import '../../config/ui_theme.dart';
import '/pages/loading_pag/loading_pag_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
  late String fertilizer;
  late String solution;
  bool isLoading = false;

  late File? imageFile;
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

  Future<String> _getNewImageFileName() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = await directory.list().toList();
    final imageFiles =
        files.where((file) => path.extension(file.path) == '.jpg').toList();
    final imageCount = imageFiles.length;
    //return '$directory/${imageCount + 1}.jpg';
    return '${imageCount + 1}';
  }

  Future<void> _saveImage() async {
    if (imageFile != null) {
      try {
        final appDir = await getApplicationDocumentsDirectory();

        final newFileName = await _getNewImageFileName();
        final savedImage =
            await imageFile!.copy('${appDir.path}/$newFileName.jpg');
        final File file = File('${appDir.path}/$newFileName.txt');

        if (!await file.exists()) {
          await file.create(recursive: true);
        }

        await file.writeAsString('$diseaseName,$fertilizer,$solution');

        // final savedImage = await imageFile!.copy(newFileName);
        //await imageFile!.copy(newFileName);
        //await ImageGallerySaver.saveFile(newFileName);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> saveImage(File image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = '3.png';
    final savedImage = await image.copy('${appDir.path}/$fileName');
    print(savedImage.path);
    print("checking path");
    return savedImage.path;
  }

  //last one
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/image.jpg');
  }

  void _saveImagfe(File image) async {
    final localFile = await _getLocalFile();
    await localFile.writeAsBytes(await image.readAsBytes());
  }

  Future<bool> diseaseInfo() async {
    bool dbResult = true;

    showLoadingDialog(context, "Connecting to database!", 70);

    var db = await mongo.Db.create(
            "mongodb+srv://devarn:devarngratoto@cluster0.klypayl.mongodb.net/diseasesDB?retryWrites=true&w=majority")
        .then((value) {
      print('Connected to MongoDB Atlas successfully.');

      showLoadingDialog(
          context, "Finding the best solutions just for you!", 80);
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

    final fertlizer = result?['Fertilizer'].toString();
    final treatment = result?['Solutions'].toString();
    if (fertlizer == null) {
      final fertlizer = "f";
    }
    fertilizer = "";
    solution = " ";

    print('Fertilizer for $diseaseName: $fertlizer');
    print('Treatment for $diseaseName: $treatment');
    fertilizer = fertlizer!;
    solution = treatment!;

    await db.close();

    if (result == null) {
      print('No data found for the disease $diseaseName');
    }
    showLoadingDialog(context, "Operation is a blooming success!", 100);
    await Future.delayed(Duration(milliseconds: 1000));
    print(diseaseName);
    print(result);

    await db.close();

    return Future.value(dbResult);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    //File('$path/1.txt').delete();
    // final File newImage = await imageFile!.copy('$path/1.png');
    return File('$path/1.txt');
  }

  Future<File> writeCounter(String name) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(diseaseName);
  }

  void showLoadingDialogBlur(
      BuildContext context, String message, double numbert) {
    //Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      //barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 350,
            height: 450,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF052106),
                  width: 5.0,
                )),
            //  padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircularIndicator(numbert),
                SizedBox(height: 16.0),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
  }

  void showLoadingDialog(BuildContext context, String message, double numbert) {
    //Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 350,
            height: 450,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Color(0xFF052106),
                  width: 5.0,
                )),
            //  padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircularIndicator(numbert),
                SizedBox(height: 16.0),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
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
    // Fluttertoast.showToast(msg: 'Image is being uploaded');
    showLoadingDialogBlur(context, "Uploading image", 20);
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
        showLoadingDialog(context, "Image uploaded successfully", 40);
        Fluttertoast.showToast(msg: 'Image uploaded successfully');
        await Future.delayed(Duration(milliseconds: 500));

        showLoadingDialog(context, "Processing image", 60);
        String responseString = await response.stream.bytesToString();
        print('Image uploaded successfully');
        String val = responseString;
        List user = val.split(',');

        diseaseName = (user[0]).toString();
        //getDiseaseInfo(diseaseName);

        confidence = (user[1]).toString();
        print("hello+$confidence");
        uploaded = true;
      } else {
        uploaded = false;

        imageUploadFail();
        Fluttertoast.showToast(msg: 'Image upload failed');
        print('Image upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
      Fluttertoast.showToast(msg: 'unexpected error in uploading');
      imageUploadFail();
    }
    return Future.value(uploaded);
  }

  Widget _buildCircularIndicator(double progress) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            percent: progress / 100,
            radius: 120.0,
            lineWidth: 25.0,
            animation: false,
            progressColor: Color(0xFF052106),
            backgroundColor: Color(0xFFF1F4F8),
            center: Text(
              '${progress.toStringAsFixed(0)}%',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 33,
                    color: Color(0xFF052106),
                  ),
            ),
          ),
          SizedBox(height: 16),
          //Text('Loading'),
        ],
      ),
    );
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
                            var picture = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            if (picture == null) {
                              Fluttertoast.showToast(
                                  msg: 'Image selection cancelled');
                              return;
                            }
                            this.setState(() {
                              imageFile = File(picture.path);
                            });
                            if (await uploadImage()) {
                              if (await diseaseInfo()) {
                                await _saveImage();
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoadingPagWidget(
                                        imageFile!,
                                        diseaseName,
                                        fertilizer,
                                        solution),
                                  ),
                                );
                                print("started");
                              } else
                                imageUploadFail("db acccses failed");
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
                                if (picture == null) {
                                  Fluttertoast.showToast(
                                      msg: 'Image selection cancelled');
                                  return;
                                }

                                this.setState(() {
                                  imageFile = File(picture.path);
                                });

                                if (await uploadImage()) {
                                  if (await diseaseInfo()) {
                                    await _saveImage();
                                    //    _localPath;
                                    //  _localFile;
                                    //writeCounter();
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultPageWidget(
                                            imageFile!,
                                            diseaseName,
                                            fertilizer,
                                            solution),
                                      ),
                                    );
                                    print("started");
                                  } else
                                    imageUploadFail("db acccess failed");
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
                    '    Your Plant Doctor\n in\nYour Pocket!',
                    textAlign: TextAlign.center,
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
