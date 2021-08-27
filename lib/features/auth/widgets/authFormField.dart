import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';

class AuthFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode myFocusNode;
  final FocusNode? nextFocusNode;
  final Function? onComplete;
  final bool isPassword;
  final String label;
  final String hint;
  final Icon myIcon;
  final Function(String?) myValidator;
  final TextInputType keyboardType;
  final int? maximum;

  const AuthFormField(
      {required this.controller,
        required this.myFocusNode,
        this.nextFocusNode,
        this.onComplete,
        required this.isPassword,
        required this.label,
        required this.hint,
        required this.myIcon,
        required this.myValidator,
        required this.keyboardType, this.maximum,
      });

  @override
  _AuthFormFieldState createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {

  bool _passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction:
      widget.onComplete == null ? TextInputAction.next : TextInputAction.done,
      focusNode: widget.myFocusNode,
      onEditingComplete: () {
        if (widget.onComplete == null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        } else {
          widget.onComplete!();
        }
      },
      maxLength: widget.maximum,
      decoration: InputDecoration(
          labelText: widget.label,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
          ),
          hintText: widget.hint,
          border: InputBorder.none,
          prefixIcon: widget.myIcon,
          suffixIcon: widget.isPassword? GestureDetector(
            onTap: (){
              setState(() {
                _passwordVisibility = !_passwordVisibility;
              });

            },
            child: Icon(
                !_passwordVisibility? Icons.visibility_off : Icons.visibility
            ),
          ) : null ,
          errorStyle: TextStyle(
              fontSize: 1.9 * textMultiplier
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 1 * textMultiplier, vertical: 1.5 * textMultiplier),
      ),
      obscureText: widget.isPassword? !_passwordVisibility : false ,
      validator: (String? value) => widget.myValidator(value),
    );
  }
}
