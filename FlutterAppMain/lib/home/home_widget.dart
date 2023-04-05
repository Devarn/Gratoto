import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/pages/result_page/result_page_widget.dart';

import '../config/ui_model.dart';
import '../config/ui_theme.dart';
import '../config/ui_widgets.dart';
import '/pages/image_test/image_test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  File? _image;
  List<File> _imageFiles = [];
  String? Filepath;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //  _getImage();
    //  _getImages();
    _loadImages();

    _model = createModel(context, () => HomeModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  Future<void> clickPic(String name, File image) async {
    name = name.replaceAll('.jpg', '');
    final directory = await getApplicationDocumentsDirectory();
    final textFilePath = '${directory.path}/$name.txt';
    final textContent = await File(textFilePath).readAsString();
    final induvidualName = textContent.split(':');
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPageWidget(
              image!, induvidualName[0], induvidualName[1], induvidualName[2]),
        ));

    print(textContent);
  }

  Future<String> _fetchFact() async {
    final apiUrl =
        Uri.parse('http://api.fungenerators.com/fact/search?query=Amazon');
    final headers = {
      'accept': 'application/json',
    };

    final response = await http.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final fact = jsonBody['contents']['fact'];
      return fact;
    } else {
      return ('Failed to fetch fact (${response.statusCode}): ${response.reasonPhrase}');
    }
  }

  Future<void> _getImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync();

    List<File> imageFiles = [];

    for (var file in files) {
      if (file is File && file.path.endsWith('.jpg')) {
        imageFiles.add(file);
      }
    }

    setState(() {
      //_images = imageFiles;
    });
  }

  Future<void> _loadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = await directory.list().toList();
    final imageFiles =
        files.where((file) => path.extension(file.path) == '.jpg').toList();
    setState(() {
      _imageFiles = imageFiles.cast<File>();
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<void> _getImage() async {
    final localFile = await _getLocalFile();

    if (await localFile.exists()) {
      setState(() {
        _image = localFile;
      });
    }
  }

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/image.jpg');
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
      // showMyDialog(context, '1.png', contents.toString());
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-0.7, -0.95),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 15.0),
                      child: Text(
                        'Your recent Searches',
                        style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xFF052106), width: 5)),
                                height: 500,
                                width: 330,
                                child: _imageFiles.isNotEmpty
                                    ? StaggeredGridView.countBuilder(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 20,
                                        itemCount: _imageFiles.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final reversedIndex =
                                              _imageFiles.length - index - 1;

                                          final imageFiles =
                                              _imageFiles[reversedIndex];
                                          final imageName =
                                              imageFiles.path.split('/').last;

                                          return GestureDetector(
                                            onTap: () async {
                                              await clickPic(imageName,
                                                  _imageFiles[reversedIndex]);
                                            },
                                            child: Image.file(
                                              _imageFiles[reversedIndex],
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                        staggeredTileBuilder: (int index) =>
                                            const StaggeredTile.fit(1),
                                      )
                                    : const Text('No images'),
                              )))),
                  Align(
                    alignment: Alignment.center,
                    child: FFButtonWidget(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageTestWidget(),
                          ),
                        );
                      },
                      text: 'Detect Disease',
                      options: FFButtonOptions(
                        width: 160,
                        height: 60,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFF052106),
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
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
        ));
  }
}
