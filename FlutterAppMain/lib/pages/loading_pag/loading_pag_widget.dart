
import '../../config/ui_model.dart';
import '../../config/ui_theme.dart';
import '/pages/result_page/result_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'loading_pag_model.dart';
export 'loading_pag_model.dart';

class LoadingPagWidget extends StatefulWidget {
  const LoadingPagWidget({Key? key}) : super(key: key);

  @override
  _LoadingPagWidgetState createState() => _LoadingPagWidgetState();
}

class _LoadingPagWidgetState extends State<LoadingPagWidget> {
  late LoadingPagModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingPagModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 3000));
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPageWidget(),
        ),
      );
    });
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Align(
            alignment: AlignmentDirectional(0.0, -0.3),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.05, 0.45),
                  child: Text(
                    'Loading',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.05, -0.2),
                  child: Container(
                    width: 361.6,
                    height: 346.1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: CircularPercentIndicator(
                      percent: 1.0,
                      radius: 80.0,
                      lineWidth: 15.0,
                      animation: true,
                      progressColor: Color(0xFF052106),
                      backgroundColor: Color(0xFFF1F4F8),
                      center: Text(
                        '100%',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
