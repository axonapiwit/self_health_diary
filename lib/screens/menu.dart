import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:self_health_diary/services/authentication_service.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'package:self_health_diary/services/excel.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Palette.tertiary,
          body: ListView(
            children: [
              ListTile(
                title: Text('เป้าหมาย'),
                leading: FaIcon(FontAwesomeIcons.bullseye),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.calendarWeek),
                title: Text('รายงานรายสัปดาห์'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.calendarAlt),
                title: Text('รายงานรายเดือน'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.trophy),
                title: Text('ความสำเร็จ'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.clock),
                title: Text('เวลา'),
                onTap: () {},
              ),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.fileExport),
                  title: Text('ส่งออกไดอารี่'),
                  onTap: createExcel),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.infoCircle),
                title: Text('เกี่ยวกับ'),
                onTap: () {},
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.signOutAlt),
                title: Text('ออกจากระบบ'),
                onTap: () {
                  context.read<AuthenticationService>().signOutWithGoogle();
                },
              ),
            ],
          )),
    );
  }
}
