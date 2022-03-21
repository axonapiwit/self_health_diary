import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User? user = FirebaseAuth.instance.currentUser;
Future<void> createExcel() async {
  final diary = await FirebaseFirestore.instance
      .collection('diaries')
      .where('createdBy', isEqualTo: user!.uid)
      .orderBy('dateTime')
      .get();

  final data = diary.docs.map((e) => e.data()).toList();

  // Create a new Excel Document.
  final Workbook workbook = Workbook();

  // Accessing worksheet via index.
  final Worksheet sheet = workbook.worksheets[0];

  // Set color
  sheet.getRangeByName('A1:G1').cellStyle.backColor = '#AEA9CF';

  // Set data in the worksheet.
  sheet.getRangeByName('B1').columnWidth = 15.00;
  sheet.getRangeByName('D1').columnWidth = 15.00;
  sheet.getRangeByName('F1').columnWidth = 15.00;
  sheet.getRangeByName('G1').columnWidth = 20.00;

  sheet.getRangeByName('A1').setText('อารมณ์');
  sheet.getRangeByName('B1').setText('วันที่และเวลา');
  sheet.getRangeByName('C1').setText('การพักผ่อน');
  sheet.getRangeByName('D1').setText('มื้ออาหาร');
  sheet.getRangeByName('E1').setText('ดื่มน้ำ');
  sheet.getRangeByName('F1').setText('การออกกำลังกาย');
  sheet.getRangeByName('G1').setText('รายละเอียด');
  sheet.getRangeByName('A1').cellStyle.bold = true;
  sheet.getRangeByName('B1').cellStyle.bold = true;
  sheet.getRangeByName('C1').cellStyle.bold = true;
  sheet.getRangeByName('D1').cellStyle.bold = true;
  sheet.getRangeByName('E1').cellStyle.bold = true;
  sheet.getRangeByName('F1').cellStyle.bold = true;
  sheet.getRangeByName('G1').cellStyle.bold = true;

  // Set the text value.

  for (int i = 2; i < data.length + 2; i++) {
    sheet.getRangeByIndex(i, 1).setText(data[i - 2]['mood']);
    sheet
        .getRangeByIndex(i, 2)
        .setDateTime((data[i - 2]['dateTime'] as Timestamp).toDate());
    sheet.getRangeByIndex(i, 3).setText(data[i - 2]['sleep']);
    sheet.getRangeByIndex(i, 4).setText(data[i - 2]['food']);
    sheet.getRangeByIndex(i, 5).setText(data[i - 2]['water']);
    sheet.getRangeByIndex(i, 6).setText(data[i - 2]['exercise']);
    sheet.getRangeByIndex(i, 7).setText(data[i - 2]['note']);
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
