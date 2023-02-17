import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Transaction Screen"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Expense Manager').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: Center(child: Text(document['title'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}












// import 'package:flutter/material.dart';
//
// import '../helpers/DataBaseHandler.dart';
//
//
//
//
//
// class TransactionScreen extends StatefulWidget {
//
//   @override
//   State<TransactionScreen> createState() => _TransactionScreenState();
// }
//
// class _TransactionScreenState extends State<TransactionScreen> {
//
//   late Future<List> alldata;
//
//
//   getdata() async {
//     setState(() {
//       alldata;
//       // alldata = obj.getallexpense();
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getdata();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: alldata,
//       builder: (context, snapshots) {
//         if (snapshots.hasData) {
//           if (snapshots.data!.length <= 0) {
//             return const Center(
//               child: Text("No Data Avaialable"),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: snapshots.data!.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   shape: const BeveledRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(15),
//                     ),
//                   ),
//                   elevation: 20,
//                   color: (snapshots.data![index]["typ"].toString() ==
//                       "expense")
//                       ? Colors.red.shade100
//                       : Colors.green.shade100,
//                   margin: const EdgeInsets.all(15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           alignment: Alignment.topRight,
//                           child: Text(
//                             "₹${snapshots.data![index]["amount"]}",
//                             style: const TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: Text(
//                           snapshots.data![index]["expense_head"]
//                               .toString().toUpperCase(),
//                           style: const TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.purple),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "${snapshots.data![index]["descp"]}",
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Date:${snapshots.data![index]["dat"]}",
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             child: GestureDetector(
//                               onTap: () {
//                                 var eid = snapshots.data![index]["eid"]
//                                     .toString();
//
//                                 // Navigator.of(context).push(
//                                 //     MaterialPageRoute(
//                                 //         builder: (context) =>
//                                 //             ExpenseUpdate(
//                                 //               updateid: eid,
//                                 //             )));
//                               },
//                               child: Container(
//                                 // margin: EdgeInsets.all(10),
//                                   padding: const EdgeInsets.all(10),
//                                   width: MediaQuery.of(context)
//                                       .size
//                                       .width /
//                                       2.2,
//                                   color: Colors.blue,
//                                   child: const Center(
//                                     child: Text(
//                                       "Update",
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.white),
//                                     ),
//                                   )),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.all(1),
//                             alignment: Alignment.bottomRight,
//                             child: GestureDetector(
//                               onTap: () {
//                                 AlertDialog alert = AlertDialog(
//                                   title: const Text(
//                                     "Are You Sure ",
//                                     style:
//                                     TextStyle(color: Colors.red),
//                                   ),
//                                   content:
//                                   const Text("This Expense Has delete"),
//                                   actions: [
//                                     ElevatedButton(
//                                       onPressed: () async {
//                                         DatabaseHandler obj =
//                                         DatabaseHandler();
//                                         Navigator.of(context).pop();
//                                         getdata();
//                                       },
//                                       child: const Text("Yes"),
//                                     ),
//                                     // ElevatedButton(
//                                     //   onPressed: () {
//                                     //     Navigator.of(context).pop();
//                                     //   },
//                                     //   child: const Text("No"),
//                                     // ),
//                                   ],
//                                 );
//
//                                 // show the dialog
//                                 showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return alert;
//                                   },
//                                 );
//                               },
//                               child: Container(
//                                 width: MediaQuery.of(context)
//                                     .size
//                                     .width /
//                                     2.2,
//                                 padding: const EdgeInsets.all(10),
//                                 color: Colors.red,
//                                 child: const Center(
//                                     child: Text(
//                                       "Delete",
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.white),
//                                     )),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//
//                 // ListTile(
//                 //   title:
//                 //   subtitle:
//                 // );
//               },
//             );
//           }
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
//
// class DataEvent {
//   int data;
//   DataEvent(this.data);
// }