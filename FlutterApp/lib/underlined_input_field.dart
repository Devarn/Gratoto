import 'package:flutter/material.dart';

class UnderlinedInputField extends StatefulWidget {

  final String hint;
  final TextInputType ?type;
  final bool isPassword;
  final TextEditingController? controller;
  final Function? onFocused;

  const UnderlinedInputField({Key? key, required this.hint, required this.isPassword, this.type, this.controller, this.onFocused}) : super(key: key);

  @override
  State<UnderlinedInputField> createState() => _UnderlinedInputFieldState();
}

class _UnderlinedInputFieldState extends State<UnderlinedInputField> {
  bool hideText = false;
  FocusNode focusNode = FocusNode();

  void onFocusChanged(){
    if (widget.onFocused != null){
      widget.onFocused!(focusNode.hasFocus);
    }
  }

  @override
  void initState(){
    super.initState();
    hideText = widget.isPassword;
    focusNode.addListener(onFocusChanged);
  }

  @override
  void dispose(){
    super.dispose();
    focusNode.removeListener(onFocusChanged);
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: "Google",
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.black,
    );
    return TextField(
      style: textStyle,
      focusNode: focusNode,
      controller: widget.controller,
      cursorColor: Theme
          .of(context)
          .primaryColor,
      keyboardType: widget.type,
      obscureText: hideText,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hint,
        hintStyle: textStyle,
        suffix: widget.isPassword?IconButton(
          alignment: Alignment.bottomCenter,
          onPressed: (){
            setState((){
              hideText = !hideText;
            });
          },
          icon: Icon(hideText?Icons.visibility_off:Icons.visibility),
          visualDensity: VisualDensity(vertical: -4),
          padding: EdgeInsets.only(bottom: 0),
        ):null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}