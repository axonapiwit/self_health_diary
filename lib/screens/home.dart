import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var doctors = [
    {
      'imgName': 'excellence.png',
      'subTitle': 'Excellence',
    },
    {
      'imgName': 'good.png',
      'subTitle': 'Good',
    },
    {
      'imgName': 'meduim.png',
      'subTitle': 'Meduim',
    },
    {
      'imgName': 'meduim.png',
      'subTitle': 'Meduim',
    },
    {
      'imgName': 'meduim.png',
      'subTitle': 'Meduim',
    },
    {
      'imgName': 'meduim.png',
      'subTitle': 'Meduim',
    },
    {
      'imgName': 'meduim.png',
      'subTitle': 'Meduim',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Palette.tertiary,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi There! How are you to day'),
            Container(
              child: Row(
                children: [
                  // Container(
                  //   child: Text(
                  //     'This is a Container',
                  //     textScaleFactor: 2,
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Palette.secondary,
                  //     border: Border(
                  //       left: BorderSide(
                  //         color: Colors.green,
                  //         width: 3,
                  //       ),
                  //     ),
                  //   ),
                  //   width: 100,
                  //   height: 100,
                  // ),
                  // Container(
                  //   child: Text(
                  //     'This is a Container',
                  //     textScaleFactor: 2,
                  //     style: TextStyle(color: Colors.black),
                  //   ),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Palette.secondary,
                  //     border: Border(
                  //       left: BorderSide(
                  //         color: Colors.green,
                  //         width: 3,
                  //       ),
                  //     ),
                  //   ),
                  //   width: 100,
                  //   height: 100,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Palette.secondary,
                  //   ),
                  //   width: 100,
                  //   height: 100,
                  // ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var d in doctors)
                          GestureDetector(
                            onTap: () {},
                            child: _doctorContainer('${d["imgName"]}',
                                '${d["title"]}', '${d["subTitle"]}'),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container _doctorContainer(String imgName, String title, String subTitle) {
  return Container(
    width: 100,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Palette.secondary,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/$imgName',
          height: 50,
          width: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '$subTitle',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
