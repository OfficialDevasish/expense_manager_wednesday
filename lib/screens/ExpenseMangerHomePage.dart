import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/DataBaseHandler.dart';
import 'Balance.dart';
import 'PersonalExpense.dart';
import 'TransactionScreen.dart';


class ExpenseMangerHomePage extends StatefulWidget {
  @override
  State<ExpenseMangerHomePage> createState() => _ExpenseMangerHomePageState();
}

class _ExpenseMangerHomePageState extends State<ExpenseMangerHomePage> {
  late Future<List> alldata;



  getdata() async {
    DatabaseHandler obj = DatabaseHandler();
    setState(() {
      alldata = obj.getallexpense();
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple.shade400,
            title: const Center(
              child: Text("Expense Manager"),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text("Transactions"),
                  icon: Icon(Icons.home),
                ),
                Tab(
                  child: Text("Balance"),
                  icon: Icon(Icons.money),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            TransactionScreen(),
            Balance()
          ]),

          floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              child: Icon(Icons.add),
              backgroundColor: Colors.blue.shade400,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PersonalExpense()));
              })),
    );
  }
}