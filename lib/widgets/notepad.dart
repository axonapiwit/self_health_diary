import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class NotePad extends StatefulWidget {
  const NotePad({Key? key}) : super(key: key);

  @override
  _NotePadState createState() => _NotePadState();
}

class _NotePadState extends State<NotePad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Note',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Palette.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            minLines:
                3, // any number you need (It works as the rows for the textarea)
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'What are you doing in day',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
