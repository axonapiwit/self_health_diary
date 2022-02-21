import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:self_health_diary/api/pdf_api.dart';
import 'package:self_health_diary/api/pdf_invoice_api.dart';
import 'package:self_health_diary/main.dart';
import 'package:self_health_diary/models/customer.dart';
import 'package:self_health_diary/models/invoice.dart';
import 'package:self_health_diary/models/supplier.dart';
import 'package:self_health_diary/widgets/button_widget.dart';
import 'package:self_health_diary/widgets/title_widget.dart';

class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Generate PDF',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Diary PDF',
                  onClicked: () async {
                    final date = DateTime.now();
                    final dueDate = date.add(Duration(days: 7));

                    final invoice = Invoice(
                      supplier: Supplier(
                        name: 'Aont Smith',
                        address: 'ChainaTown Street 69, Beijing, China',
                        paymentInfo: 'https://paypal.me/sarahfieldzz',
                      ),
                      customer: Customer(
                        name: '178 Cm',
                        address: '50 Kg',
                      ),
                      info: InvoiceInfo(
                        date: date,
                        dueDate: dueDate,
                        description: 'My description...',
                        number: '${DateTime.now().year}-9999',
                      ),
                      items: [
                        InvoiceItem(
                          description: 'Good',
                          date: DateTime.now(),
                          time: DateTime.now(),
                          food: '3 Meals',
                          sleep: '7-8 Hrs',
                          water: '0.5 Liter',
                          note: '',
                        ),
                        InvoiceItem(
                          description: 'Good',
                          date: DateTime.now(),
                          time: DateTime.now(),
                          food: '3 Meals',
                          sleep: '3-4 Hrs',
                          water: '1 Liter',
                          note: '',
                        ),
                        InvoiceItem(
                          description: 'Badly',
                          date: DateTime.now(),
                          time: DateTime.now(),
                          food: '3 Meals',
                          sleep: '7-8 Hrs',
                          water: '2 Liter',
                          note: '',
                        ),
                        InvoiceItem(
                          description: 'Medium',
                          date: DateTime.now(),
                          time: DateTime.now(),
                          food: '3 Meals',
                          sleep: '5-6 Hrs',
                          water: '1.5 Liter',
                          note: '',
                        ),
                        InvoiceItem(
                          description: 'Good',
                          date: DateTime.now(),
                          time: DateTime.now(),
                          food: '3 Meals',
                          sleep: '7-8 Hrs',
                          water: '1 Liter',
                          note: '',
                        ),
                        InvoiceItem(
                          description: 'Good',
                          date: DateTime.now(),
                          time: DateTime.now(),
                          food: '3 Meals',
                          sleep: '7-8 Hrs',
                          water: '1 Liter',
                          note: '',
                        ),
                        InvoiceItem(
                          description: 'Medium',
                          date: DateTime.now(),
                          time: DateTime.now(),
                          food: '2 Meals',
                          sleep: '7-8 Hrs',
                          water: '0.5 Liter',
                          note: '',
                        ),
                      ],
                    );

                    final pdfFile = await PdfInvoiceApi.generate(invoice);

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
