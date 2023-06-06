import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/constants.dart';

class PersonalDocumentsScreen extends StatefulWidget {
  const PersonalDocumentsScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDocumentsScreen> createState() =>
      _PersonalDocumentsScreenState();
}

class _PersonalDocumentsScreenState extends State<PersonalDocumentsScreen> {
  //List<Document> parsedDocuments = [];
  @override
  initState() {
    super.initState();
  }

  /*Future<bool> getData() async {
    var response = await getDocuments().onError((error, stackTrace) => false);
    response
        .forEach((element) => parsedDocuments.add(Document.fromMap(element)));
    return true;
  }*/

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: Text('Personal documents', style: TextStyle(color: kGrey5)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kGrey4,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container()
          /*child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return PaginatedDataTable(
                source: parsedDocuments,
                rowsPerPage: 10,
                showCheckboxColumn: false,
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Icon(Icons.remove_red_eye)),
                ],
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              print(snapshot.stackTrace);
              return Center(child: Text('There has been an error'));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),*/
          ),
    );
  }
}

// The "soruce" of the table
/*
class CustomTableData extends DataTableSource {
  final DateFormat format = DateFormat('dd/MM/yyyy');

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => parsedDocuments.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(parsedDocuments.name)),
      DataCell(Text(format(parsedDocuments.date))),
      DataCell(Text(parsedDocuments.viewed ? 'Yes' : 'No')),
    ]);
  }

}
*/
