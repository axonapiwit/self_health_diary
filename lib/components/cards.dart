import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  Cards({this.title = '', this.subTitle = '', this.imgName = ''});

  final String title;
  final String subTitle;
  final String imgName;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.white30,
      child: InkWell(
        onTap: () {},
        splashColor: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imgName,
                height: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                subTitle,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
