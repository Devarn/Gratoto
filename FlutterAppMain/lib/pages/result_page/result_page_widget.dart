import '../../config/ui_model.dart';
import '../../config/ui_theme.dart';
import '/pages/who_we_are/who_we_are_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'result_page_model.dart';
export 'result_page_model.dart';

class ResultPageWidget extends StatefulWidget {
  final String diseaseName;
  final String confidence = "";
  ResultPageWidget(this.diseaseName, {Key? key}) : super(key: key);

  @override
  _ResultPageWidgetState createState() => _ResultPageWidgetState();
}

class _ResultPageWidgetState extends State<ResultPageWidget> {
  late ResultPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResultPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(-0.9, 0.0),
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WhoWeAreWidget(),
                    ),
                  );
                },
                child: Icon(
                  Icons.filter_list_rounded,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -0.05),
              child: Container(
                width: 176.5,
                height: 59.1,
                decoration: BoxDecoration(
                  color: Color(0xFF052106),
                  borderRadius: BorderRadius.circular(23.0),
                ),
                child: Align(
                  alignment: AlignmentDirectional(-0.05, 0.0),
                  child: Text(
                    'Results',
                    style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/images/Tomato-late-blight-72605cba08f2483aae0fd8f1dc3532a9.jpg',
                  width: 296.6,
                  height: 228.1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                child: Container(
                  width: 322.2,
                  height: 54.5,
                  decoration: BoxDecoration(
                    color: Color(0xFF052106),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-0.8, -0.75),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                      child: Text(
                        widget.diseaseName,
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Container(
                  width: 322.2,
                  height: 117.7,
                  decoration: BoxDecoration(
                    color: Color(0xFF052106),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-0.85, -0.65),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 5.0),
                      child: Text(
                        'Recommanded Solution :   To prevent late blight in tomato plants: rotate crops, use resistant varieties, practice sanitation, use fungicides, control moisture, and monitor plants for signs of disease.',
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Container(
                  width: 322.2,
                  height: 154.5,
                  decoration: BoxDecoration(
                    color: Color(0xFF052106),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(-0.85, -0.2),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                      child: Text(
                        'Recomended Fertilizers :  To prevent tomato late blight, use balanced fertilizers with an NPK ratio of 10-10-10 or 20-20-20, apply at planting time and every 3-4 weeks, use organic fertilizers, and avoid over-fertilization.',
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
