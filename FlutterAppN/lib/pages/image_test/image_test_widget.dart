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
import 'package:connectivity/connectivity.dart';

import 'image_test_model.dart';
export 'image_test_model.dart';

class ImageTestWidget extends StatefulWidget {
  const ImageTestWidget({Key? key}) : super(key: key);

  @override
  _ImageTestWidgetState createState() => _ImageTestWidgetState();
}

class _ImageTestWidgetState extends State<ImageTestWidget> {
  late ImageTestModel _model;
  late String diseaseName; //name of dieases detected
  late String confidence; //confidence of ml model

  late String fertilizer; //fertiizer taken
  late String solution; //soution taken from DB
  bool isLoading = false; //is the ciriclar indcator loading

  late File? imageFile; //the image selected
  final ImagePicker imagePicker = ImagePicker(); //image picker to get the image

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
    try {
//get the direcotry where this app stores its documents
      final directory = await getApplicationDocumentsDirectory();
      //creates a list of all the files in the above diretory
      final files = await directory.list().toList();
      //get t he ones that end with jpg extension
      final imageFiles =
          files.where((file) => path.extension(file.path) == '.jpg').toList();
      //get the number of suc files in the directory

      final imageCount = imageFiles.length;
      //add one to it so the new file can be saved later as such
      return '${imageCount + 1}';
    } catch (e) {
      Fluttertoast.showToast(msg: 'unexpected error in searching for files');
      return ('99'); //give a fixed value which is unlikely to be reached soon
    }
  }

  Future<void> _saveImage() async {
    if (imageFile != null) {
      //check if image file is null or not
      try {
        //get the app document directroy
        final appDir = await getApplicationDocumentsDirectory();
//call funtion to get the new file name
        final newFileName = await _getNewImageFileName();
        //save image as the new file name
        final savedImage =
            await imageFile!.copy('${appDir.path}/$newFileName.jpg');
        //create a txt file to store info with the same file name
        final File file = File('${appDir.path}/$newFileName.txt');

        if (!await file.exists()) {
          await file.create(recursive: true);
        }
        //write the disease,fertlizer and solution to this file seprated by commas
        //so it can be split later and given to navigator

        await file.writeAsString('$diseaseName,$fertilizer,$solution');
      } catch (e) {
        Fluttertoast.showToast(msg: 'unexpected error in saving files');

        print(e);
      }
    }
  }

  Future<bool> diseaseInfo() async {
    bool dbResult = true;
//call the circular indicator function with a value of 70 percent
    showLoadingDialog(context, "Connecting to database!", 70, true);
//create connection with our dieases database
    var db = await mongo.Db.create(
            "mongodb+srv://devarn:devarngratoto@cluster0.klypayl.mongodb.net/diseasesDB?retryWrites=true&w=majority")
        .then((value) {
      print('Connected to MongoDB Atlas successfully.'); //to check in debug
//update the progrees to 80
      showLoadingDialog(
          context, "Finding the best solutions just for you!", 80, true);
      return value;
      //error handling below
    }).catchError((error) {
      Fluttertoast.showToast(msg: 'unexpected error in saving files');

      print('Failed to connect to MongoDB Atlas: $error');

      exit(1);
    });
//open a connection to the database
    await db.open();
    //get the collection called gratoto which has our data base

    final collection = db.collection("gratoto");
//find the section which has the current disease name
    final result =
        await collection.findOne(mongo.where.eq('disease', diseaseName));
//seperate the retuirn values as the named fertilize and solution
    final fertlizer = result?['Fertilizer'].toString();
    final treatment = result?['Solutions'].toString();
//doe just for checking if in case it is null
    fertilizer = "";
    solution = " ";
    //printing to see if it works in the debug

    print('Fertilizer for $diseaseName: $fertlizer');
    print('Treatment for $diseaseName: $treatment');
    //i did this to set the global fertilzer and solution to the vales we just got
    fertilizer = fertlizer!;
    solution = treatment!;
//close connection o the database
    await db.close();
//just in case the result isnt there
    if (result == null) {
      print('No data found for the disease $diseaseName');
      fertilizer = "Not found";
      solution = "not found";
    }
    //update the idicator to 100 and give artifical time of 500ms
    showLoadingDialog(context, "Operation is a blooming success!", 100, true);
    await Future.delayed(Duration(milliseconds: 1000));
    print(diseaseName); //just to check in debugger
    print(result);
//close connection to the database again just in case
    await db.close();
    //return the values we jsut got

    return Future.value(dbResult);
  }

//there are 2 loading screens since i wasnt able to get the blur effect and pop
//togther. so i created 2 dialog boxes for the perctanges one with blue and one without
  void showLoadingDialogBlur(
      BuildContext context, String message, double number) {
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
                _buildCircularIndicator(number),
                SizedBox(height: 16.0),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
  }

//dilaog box without blur
  void showLoadingDialog(
      BuildContext context, String message, double number, bool transparent) {
    late Color colorBarrier;
    if (transparent) {
      colorBarrier = Colors.transparent;
    } else {
      colorBarrier = Color(0x8A000000);
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: colorBarrier,
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
                _buildCircularIndicator(number),
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

  Future<bool> checkNetwork() async {
    bool network = true;
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      network = true;
    } else {
      //Fluttertoast.showToast(msg: 'no network');
      network = false;
    }
    return network;
  }

  Future<bool> uploadImage() async {
    Navigator.pop;
    // Fluttertoast.showToast(msg: 'Image is being uploaded');

    //make uri object with our cloud predict funtion url
    bool uploaded = false;
    late Uri uri;
    if (await checkNetwork()) {
      showLoadingDialog(context, "Uploading image", 20, false);

      try {
        print("1a");
        uri = Uri.parse(
            "https://us-central1-gratato-381114.cloudfunctions.net/predict");

        print("2a");
        //makling a multipart rquest using POST or our above url
        var request = http.MultipartRequest('POST', uri);
        print("3a");

        //since the below is a mulirpart part header we set it as such
        request.headers['Content-Type'] = 'multipart/form-data';
        print("4a");
        //addig the iage that the user ewlcted tot he request as name file(file is request by GCP)
        request.files
            .add(await http.MultipartFile.fromPath('file', imageFile!.path));

        //try sending the request
        var response = await request.send();

        print("7a");
        if (response.statusCode == 200) {
          print("8a");
          //if successul show as such
          //update percentage
          showLoadingDialog(context, "Image uploaded successfully", 40, true);
          // Fluttertoast.showToast(msg: 'Image uploaded successfully'); done just to check
          await Future.delayed(
              Duration(milliseconds: 1000)); //artifical time extension
//update percentage
          showLoadingDialog(context, "Processing image", 60, true);
          //convert the incoming respose as a string
          String responseString = await response.stream.bytesToString();
          print('Image uploaded successfully');
          String val = responseString;
          //spliot the string at commas to get the info correctly
          List user = val.split(',');

          diseaseName = (user[0]).toString();
          //getDiseaseInfo(diseaseName);

          confidence = (user[1]).toString();
          print("confidence+$confidence");
          uploaded = true;
        } else {
          uploaded = false;
//ifthe upload is false show a diloag that says image upload failed
          imageUploadFail();
          Fluttertoast.showToast(msg: 'Image upload failed');
          print('Image upload failed with status code ${response.statusCode}');
        }
      } catch (e) {
        print("error caught");
        imageUploadFail();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error.'),
        ));
        //Fluttertoast.showToast(msg: 'Network error.Please check your network');
        setState(() {
          isLoading = false;
          isLoading = false;
          diseaseName = "";
          confidence = "";
        });
        return Future.value(false);
      }
    } else {
      Fluttertoast.showToast(msg: 'no network connection');
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
                                await Navigator.pushReplacement(
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
                                await Future.delayed(
                                    Duration(milliseconds: 1000));

                                try {
                                  if (await uploadImage()) {
                                    if (await diseaseInfo()) {
                                      await _saveImage();

                                      await Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ResultPageWidget(
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
                                } on SocketException catch (e) {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Network error.Please check your network');
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
                  'Upload from \n this device',
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
                  '  Open\ncamera',
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