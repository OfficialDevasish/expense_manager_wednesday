import 'package:expense_manager_wednesday/Final_FirebaseExpenseManager_demo/calculationpart/ExpenseCalculatorListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/TransactionScreen.dart';
import 'expensethirdpage.dart';


class expensehomepage extends StatefulWidget {
  @override
  State<expensehomepage> createState() => _expensehomepageState();
}

class _expensehomepageState extends State<expensehomepage> {




  getdata() async {
    setState(() {
      // alldata = obj.getallexpense();
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
              child: Text("Homepage Expense Manager"),
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
            ExpenseCalculatorListScreen()

            // Balance()
          ]),

          floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              child: Icon(Icons.add),
              backgroundColor: Colors.blue.shade400,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => expensethirdpage()));
              })),
    );
  }
}