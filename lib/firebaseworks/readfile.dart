import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/DataBaseHandler.dart';






class readfile extends StatefulWidget {

  @override
  State<readfile> createState() => _readfileState();
}

class _readfileState extends State<readfile> {
  var totalincome = 0.0,
      totalexpense = 0.0,
      balance = 0.0;

  getdata() async {
    print("output-->hello ${totalexpense}");
    DatabaseHandler obj = new DatabaseHandler();
    List alldata = await obj.getallexpense();
    for (var row in alldata) {
      if (row["typ"].toString() == "expense") {
        setState(() {
          totalexpense = totalexpense + double.parse(row["amount"].toString());
          print("output-->${totalexpense}");
        });
      }
      else {
        setState(() {
          totalincome = totalincome + double.parse(row["amount"].toString());
        });
      }
      setState(() {
        balance = totalincome - totalexpense;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Expense Manager Demo"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ExpenseManagerDemo')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: Center(child: Text(document['Amount'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}