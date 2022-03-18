import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class TextfieldInput extends StatefulWidget {
  const TextfieldInput(
      {Key? key,
      this.controller,
      this.onChanged,
      this.validate,
      this.labelText,
      this.suffix,
      this.keyboardType,
      this.width})
      : super(key: key);

  final onChanged;
  final labelText;
  final TextEditingController? controller;
  final String? validate;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final double? width;

  @override
  _TextfieldInputState createState() => _TextfieldInputState();
}

class _TextfieldInputState extends State<TextfieldInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: widget.width,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              fillColor: Palette.secondary,
              filled: true,
              suffix: widget.suffix,
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              labelText: widget.labelText,
              errorText: widget.validate,
            ),
            onChanged: widget.onChanged,
          ),
        )
      ]),
    );
  }
}
