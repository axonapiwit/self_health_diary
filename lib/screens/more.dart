import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_health_diary/screens/pdf_screen.dart';
import 'package:self_health_diary/themes/colors.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Palette.tertiary,
          body: ListView(
            children: [
              ListTile(
                title: Text('Goals'),
                leading: FaIcon(FontAwesomeIcons.bullseye),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.calendarWeek),
                title: Text('Weekly Report'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.calendarAlt),
                title: Text('Month Report'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.trophy),
                title: Text('Achievements'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.clock),
                title: Text('Time'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.smile),
                title: Text('Edit Moods'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.key),
                title: Text('PIN Lock'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.fileExport),
                title: Text('Export Diary'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.infoCircle),
                title: Text('About'),
                onTap: () {},
              ),
            ],
          )),
    );
  }
}
