import '../../config/ui_model.dart';
import '../../config/ui_theme.dart';
import '/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'who_we_are_model.dart';
export 'who_we_are_model.dart';

class WhoWeAreWidget extends StatefulWidget {
  const WhoWeAreWidget({Key? key}) : super(key: key);

  @override
  _WhoWeAreWidgetState createState() => _WhoWeAreWidgetState();
}

class _WhoWeAreWidgetState extends State<WhoWeAreWidget> {
  late WhoWeAreModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WhoWeAreModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Color(0xFF052106),
        automaticallyImplyLeading: true,
        title: Align(
          alignment: AlignmentDirectional(-1.2, 0.0),
          child: Text(
            'About Us',
            style: FlutterFlowTheme.of(context).title2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.72),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                  child: Container(
                    width: 377.4,
                    height: 257.2,
                    decoration: BoxDecoration(
                      color: Color(0x68185F1C),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.77),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            25.0, 15.0, 25.0, 15.0),
                        child: Text(
                          'Welcome to Gratoto, the mobile app for plant lovers and farmers! We\'re a team of five dedicated to creating a community that encourages plant-based living. Our diverse backgrounds in horticulture, agriculture, and software engineering allow us to create a user-friendly, informative, and fun app. Our goal is to promote sustainable farming practices and help both plant enthusiasts and farmers alike. ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF052106),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.67, -0.5),
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/IMG_6318.JPG',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.4, -0.1),
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/WhatsApp_Image_2023-03-13_at_23.40.38.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.75, -0.5),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/WhatsApp_Image_2023-03-13_at_23.40.38.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.03, -0.5),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/WhatsApp_Image_2023-03-13_at_23.40.38.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.36, -0.1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/IMG_6318.JPG',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.63, -0.28),
                child: Text(
                  'Sahas',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.02, -0.28),
                child: Text(
                  'Sachin ',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.39, 0.05),
                child: Text(
                  'Saranath',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.43, 0.05),
                child: Text(
                  'PrathikShan',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.7, -0.28),
                child: Text(
                  'Devarn ',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, -0.97),
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/GRATOTO__1_-removebg-preview.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.1, 0.91),
                child: Text(
                  'Thank you for choosing Gratoto....!',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF052106),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.93, -0.95),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeWidget(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 30.0,
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
