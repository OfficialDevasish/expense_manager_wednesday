import 'package:flutter/material.dart';

import '../helpers/DataBaseHandler.dart';



class Balance extends StatefulWidget {


  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {


  var totalincome = 0.0,
      totalexpense = 0.0,
      balance = 0.0;

  getdata() async {
    DatabaseHandler obj = new DatabaseHandler();
    List alldata = await obj.getallexpense();
    for (var row in alldata) {
      if (row["typ"].toString() == "expense") {
        setState(() {
          totalexpense = totalexpense + double.parse(row["amount"].toString());
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("₹ " + totalexpense.toString(), style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),),
                  Text("₹ " + totalincome.toString(), style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  Text("₹ " + balance.toString(), style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          )

      ),
    );
  }
}