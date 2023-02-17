import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/DataBaseHandler.dart';

class TransactionScreen extends StatefulWidget {
  @override


  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late Future<List> alldata;
  var totalincome = 0.0, totalexpense = 0.0, balance = 0.0;

  get typ => null;

  getdata() async {
    print("output-->hello ${totalexpense}");
    DatabaseHandler obj = new DatabaseHandler();
    List alldata = await obj.getallexpense();
    print("What is Length ${alldata}");
    for (var row in alldata) {
      print("condition-->${typ}");

      if (row["typ"].toString() == "expense") {
        setState(() {
          totalexpense = totalexpense + double.parse(row["amount"].toString());
          print("output-->${totalexpense}");
        });
      } else {
        setState(() {
          totalincome = totalincome + double.parse(row["amount"].toString());
        });
      }
      setState(() {
       print("output--->$totalincome,$totalexpense");
        balance = totalincome - totalexpense;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // // backgroundColor: Colors.green,
      //   // title: Text("Transactions"),
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Expense Manager')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Card(
                //     child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: <Widget>[
                //     const ListTile(
                //    leading: Icon(Icons.album, size: 45),
                //   title: Text('title'),
                //   subtitle: Text('amount'),
                // ),
                // ],
                //     )
                child: Column(
                    children: [
                  Text(document['title']),
                  Text(document['description']),
                  Text(document['amount']),
                      Text(document['type']),
                ]),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
