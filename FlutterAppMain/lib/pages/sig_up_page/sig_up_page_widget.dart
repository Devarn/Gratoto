import '../../config/ui_model.dart';
import '../../config/ui_theme.dart';
import '../../config/ui_widgets.dart';
import '/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sig_up_page_model.dart';
export 'sig_up_page_model.dart';

class SigUpPageWidget extends StatefulWidget {
  const SigUpPageWidget({Key? key}) : super(key: key);

  @override
  _SigUpPageWidgetState createState() => _SigUpPageWidgetState();
}

class _SigUpPageWidgetState extends State<SigUpPageWidget> {
  late SigUpPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SigUpPageModel());

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
    _model.textController3 ??= TextEditingController();
    _model.textController4 ??= TextEditingController();
    _model.textController5 ??= TextEditingController();
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
            'Sign Up',
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeIn,
                width: 1036.7,
                height: 846.9,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                alignment: AlignmentDirectional(-0.9, -0.55),
                child: Align(
                  alignment: AlignmentDirectional(0.0, -0.35),
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, -0.95),
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/GRATOTO__1_-removebg-preview.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Align(
                        alignment: AlignmentDirectional(-0.89, -0.71),
                        child: Text(
                          'First Name',
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -0.59),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 60.0),
                          child: TextFormField(
                            controller: _model.textController1,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              fillColor: Color(0x68185F1C),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            validator: _model.textController1Validator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.88, -0.48),
                        child: Text(
                          'Last Name',
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -0.26),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 120.0),
                          child: TextFormField(
                            controller: _model.textController5,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              fillColor: Color(0x68185F1C),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            validator: _model.textController5Validator
                                .asValidator(context),
                          ),
                        ),
                      ),

                      Align(
                        alignment: AlignmentDirectional(-0.88, -0.25),
                        child: Text(
                          'Email',
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.01),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, .0, 20.0, 110.0),
                          child: TextFormField(
                            controller: _model.textController2,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              fillColor: Color(0x68185F1C),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            validator: _model.textController2Validator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.88, -0.015),
                        child: Text(
                          'Password',
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.34),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 140.0),
                          child: TextFormField(
                            controller: _model.textController4,
                            autofocus: true,
                            obscureText: !_model.passwordVisibility2,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              fillColor: Color(0x68185F1C),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                      () => _model.passwordVisibility2 =
                                  !_model.passwordVisibility2,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _model.passwordVisibility2
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0xFF757575),
                                  size: 22.0,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            validator: _model.textController4Validator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.86, 0.22),
                        child: Text(
                          'Confirm Password',
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),




                      Align(
                        alignment: AlignmentDirectional(0.0, 0.64),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 140.0),
                          child: TextFormField(
                            controller: _model.textController3,
                            autofocus: true,
                            obscureText: !_model.passwordVisibility1,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              filled: true,
                              fillColor: Color(0x68185F1C),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _model.passwordVisibility1 =
                                      !_model.passwordVisibility1,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _model.passwordVisibility1
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0xFF757575),
                                  size: 22.0,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            validator: _model.textController3Validator
                                .asValidator(context),
                          ),
                        ),
                      ),


                      Align(
                        alignment: AlignmentDirectional(0.0, 0.60),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeWidget(),
                              ),
                            );
                          },
                          text: 'Sign Up',
                          options: FFButtonOptions(
                            width: 159.4,
                            height: 48.2,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
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
            ),
          ),
        ),
      ),
    );
  }
}
