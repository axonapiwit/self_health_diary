import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:self_health_diary/services/authentication_service.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  // getData() async {
  //   List<Map<String, dynamic>> data;
  //   FirebaseFirestore.instance
  //       .collection('diaries')
  //       .where('createdBy', isEqualTo: user!.uid)
  //       .orderBy('dateTime')
  //       .get()
  //       .then((value) {
  //     data = value.docs.map((doc) => doc.data()).toList();
  //   });
  // }

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

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

  Future<void> createExcel() async {
    final diary = await FirebaseFirestore.instance
        .collection('diaries')
        .where('createdBy', isEqualTo: user!.uid)
        .orderBy('dateTime')
        .get();

    // List<Map<String, dynamic>> data = diary.docs.map;
    final data = diary.docs.map((e) => e.data()).toList();
    //     .then((value) {
    //   data = value.docs.map((doc) => doc.data()).toList();
    //   setState(() {});
    // });

    // Create a new Excel Document.
    final Workbook workbook = Workbook();

    // Accessing worksheet via index.
    final Worksheet sheet = workbook.worksheets[0];

    // Set color
    sheet.getRangeByName('A1:G1').cellStyle.backColor = '#AEA9CF';

    // Set data in the worksheet.
    sheet.getRangeByName('B1').columnWidth = 15.00;
    sheet.getRangeByName('D1').columnWidth = 15.00;

    sheet.getRangeByName('A1').setText('อารมณ์');
    sheet.getRangeByName('B1').setText('วันที่และเวลา');
    sheet.getRangeByName('C1').setText('มื้ออาหาร');
    sheet.getRangeByName('D1').setText('การพักผ่อน');
    sheet.getRangeByName('E1').setText('ดื่มน้ำ');
    sheet.getRangeByName('F1').setText('โน๊ต');
    sheet.getRangeByName('A1').cellStyle.bold = true;
    sheet.getRangeByName('B1').cellStyle.bold = true;
    sheet.getRangeByName('C1').cellStyle.bold = true;
    sheet.getRangeByName('D1').cellStyle.bold = true;
    sheet.getRangeByName('E1').cellStyle.bold = true;
    sheet.getRangeByName('F1').cellStyle.bold = true;

    // Set the text value.

    for (int i = 2; i < data.length + 2; i++) {
      sheet.getRangeByIndex(i, 1).setText(data[i - 2]['mood']);
      sheet
          .getRangeByIndex(i, 2)
          .setDateTime((data[i - 2]['dateTime'] as Timestamp).toDate());
      sheet.getRangeByIndex(i, 3).setText(data[i - 2]['food']);
      sheet.getRangeByIndex(i, 4).setText(data[i - 2]['sleep']);
      sheet.getRangeByIndex(i, 5).setText(data[i - 2]['water']);
      sheet.getRangeByIndex(i, 6).setText(data[i - 2]['note']);
    }

    // Save and dispose the document.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // Get external storage directory
    final directory = await getExternalStorageDirectory();

    // Get directory path
    final path = directory!.path;

    final diaryName = DateTime.now().millisecondsSinceEpoch;
    // final diaryName = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Create an empty file to write Excel data
    File file = File('$path/$diaryName.xlsx');

    // Write Excel data
    await file.writeAsBytes(bytes, flush: true);

    // Open the Excel document in mobile
    OpenFile.open('$path/$diaryName.xlsx');
  }
}
