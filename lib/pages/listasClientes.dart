import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore',
      home: Scaffold(
        appBar: AppBar(title: Text('Datos ')),
        body: StreamBuilder(
            stream: Firestore.instance.collection('clientesCtp1').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<DocumentSnapshot> docs = snapshot.data.documents;
              return Lista1(docs: docs);
            }),
      ),
    );
  }
}

class Lista1 extends StatelessWidget {
  const Lista1({
    Key key,
    @required this.docs,
  }) : super(key: key);
  final List<DocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> data = docs[index].data;
          return Card(
            elevation: 9,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text((index + 1).toString(), style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            data['CODCLI'].toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(data['NOMCLI']),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
          );
        });
  }
}

class Lista extends StatelessWidget {
  const Lista({
    Key key,
    @required this.docs,
  }) : super(key: key);

  final List<DocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> data = docs[index].data;
          return ListTile(
              leading: Text(
                  (index + 1).toString() + ' - ' + data['CODCLI'].toString()),
              title: Text(data['NOMCLI']));
        });
  }
}
