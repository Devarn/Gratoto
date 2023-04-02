import 'dart:io';

import '../config/ui_model.dart';
import '../config/ui_theme.dart';
import '../config/ui_widgets.dart';
import '/pages/image_test/image_test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
import 'package:path_provider/path_provider.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  void showMyDialog(
      BuildContext context, String fileName, String message) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';
    File imageFile = File(filePath);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image(
            image: FileImage(imageFile),
            height: 100,
            width: 100,
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/1.txt');
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(counter);
  }

  Future readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      showMyDialog(context, '1', contents.toString());
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Stack(
            alignment: AlignmentDirectional(-0.050000000000000044, 0.0),
            children: [
              Align(
                alignment: AlignmentDirectional(-0.7, -0.95),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                  child: Text(
                    'Recent Recognize Details',
                    style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, -0.25),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 80.0, 10.0, 140.0),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 12.0,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return [
                        () => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                'assets/images/Tomato-late-blight-72605cba08f2483aae0fd8f1dc3532a9.jpg',
                                width: 88.2,
                                height: 198.1,
                                fit: BoxFit.cover,
                              ),
                            ),
                        () => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                'assets/images/Tom_SeptFS2.jpg',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                        () => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                'assets/images/Septoria-Spot-800x533.jpg',
                                width: 100.0,
                                height: 240.9,
                                fit: BoxFit.cover,
                              ),
                            ),
                        () => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                'assets/images/Tom_SeptFS1.jpg',
                                width: 100.0,
                                height: 92.6,
                                fit: BoxFit.cover,
                              ),
                            ),
                        () => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                'assets/images/tomato-septoria-leaf-spot-grabowski.jpg',
                                width: 100.0,
                                height: 146.9,
                                fit: BoxFit.cover,
                              ),
                            ),
                        () => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                'assets/images/bacterial_spot_tomato.jpg',
                                width: 100.0,
                                height: 225.8,
                                fit: BoxFit.cover,
                              ),
                            ),
                        () => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                'assets/images/Tomato-late-blight-72605cba08f2483aae0fd8f1dc3532a9.jpg',
                                width: 84.0,
                                height: 201.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                      ][index]();
                    },
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.05, 0.86),
                child: FFButtonWidget(
                  onPressed: () async {
                    _localPath;
                    _localFile;
                    //  writeCounter("plant diease grape");

                    //  writeCounter("plant dieasffe grape");
                    readCounter();

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageTestWidget(),
                      ),
                    );
                  },
                  text: 'Detect the Disease',
                  options: FFButtonOptions(
                    width: 184.3,
                    height: 57.5,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF052106),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
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
