import 'package:expense_manager_wednesday/Final_FirebaseExpenseManager_demo/calculationpart/ExpenseCalculatorListScreen.dart';
import 'package:expense_manager_wednesday/Final_FirebaseExpenseManager_demo/expensehomepage.dart';
import 'package:expense_manager_wednesday/screens/ExpenseMangerHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Final_FirebaseExpenseManager_demo/TransactionScreen.dart';
import 'Final_FirebaseExpenseManager_demo/expensethirdpage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
          primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,

      home: expensehomepage(),
    );
  }
}




























// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
// import 'firebase_expense_calculator/expanse_calculator_list_screen.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // service.isLogin(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//
//     return Scaffold(
//         body: SafeArea(
//           child: Container(
//               width: double.infinity,
//               margin: EdgeInsets.symmetric(horizontal: 10),
//               padding: EdgeInsets.all(10),
//               child: Column(children: [
//                 SizedBox(height: 35),
//                 Text("Welcome Screen",
//                     style: GoogleFonts.ptSerif(
//                         fontSize: 32, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 15),
//
//                 Expanded(
//                     flex: 5,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 5),
//                           firebaseExpenseCalculatorWidget(),
//                         ],
//                       ),
//                     ))
//               ])),
//         ));
//   }
//
//   firebaseFireStoreDbWidget() =>
//       Container(
//         width: double.infinity,
//         height: 50,
//         margin: EdgeInsets.only(top: 15, left: 15, right: 15),
//         child: ElevatedButton(
//             onPressed: () {
//               debugPrint("main: onPressed:");
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                   firebaseExpenseCalculatorWidget()));
//             },
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10))),
//             child: Text("Firebase Firestore Db",
//                 style: GoogleFonts.ptSerif(fontSize: 17))),
//       );
//
//   firebaseExpenseCalculatorWidget() =>
//       Container(
//         width: double.infinity,
//         height: 50,
//         margin: EdgeInsets.only(top: 15, left: 15, right: 15),
//         child: ElevatedButton(
//             onPressed: () {
//               debugPrint("main: onPressed:");
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                        ExpenseCalculatorListScreen()));
//             },
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10))),
//             child: Text("Firebase Expense Db",
//                 style: GoogleFonts.ptSerif(fontSize: 17))),
//       );
//
// }
