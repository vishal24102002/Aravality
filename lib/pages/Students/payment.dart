// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:slide_to_act/slide_to_act.dart';
// import 'package:upi_pay/upi_pay.dart';
//
// import '../../initial/Home.dart';
// import '../../initial/autoLogin.dart';
// import '../../initial/login.dart';
// import '../../services/mysql_api.dart';
//
// class Pay extends StatefulWidget {
//   const Pay({super.key});
//
//   @override
//   State<Pay> createState() => _PayState();
// }
//
// var user_email;
// double paid = 0.0;
// final upiPay = UpiPay();
//
// class _PayState extends State<Pay> {
//   late String dropdownValue_stream;
//   List<ApplicationMeta>? apps;
//   final String upiId = "8882083822@paytm"; // Replace with actual UPI ID
//   final String payeeName = "Accounts dept Aravali";
//   double pay_ruppe = 1.0;
//   Future<UpiTransactionResponse>? _transaction;
//
//   // Fetch user email details
//   void User_Email() {
//     if (username.isEmpty) {
//       user_email = user_email_live;
//     } else {
//       user_email = username;
//     }
//     setState(() {});
//   }
//
//   // Fetch payment details safely
//   void getdetail_email_pay() async {
//     try {
//       var detailData = await Getdetails(user_email);
//       var studData = jsonDecode(detailData);
//       name = studData[0];
//       roll_no = studData[1];
//       course = studData[2];
//       contact = studData[4];
//       paid = double.tryParse(studData[5].toString()) ?? 0.0;
//       setState(() {});
//     } catch (e) {
//       print("Error fetching details: $e");
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     User_Email();
//     getdetail_email_pay();
//
//     dropdownValue_stream = course;
//     if (["CSE", "AIML", "EC"].contains(dropdownValue_stream)) {
//       pay_ruppe = paid;
//     }
//
//     // Get installed UPI apps
//     upiPay.getInstalledUpiApplications().then((value) {
//       setState(() {
//         apps = value;
//       });
//
//       // ✅ Debugging: Print the installed apps
//       if (apps != null && apps!.isNotEmpty) {
//         print("✅ Installed UPI Apps:");
//         for (var app in apps!) {
//           print("📲 App: ${app.upiApplication.getAppName()}");
//         }
//       } else {
//         print("❌ No UPI apps found!");
//       }
//     }).catchError((e) {
//       setState(() {
//         apps = [];
//       });
//       print("🚨 Error fetching UPI apps: $e");
//     });
//   }
//
//   // Initiate UPI Transaction (Replaced `upi_india` with `upi_pay`
//   Future doUpiTransation(ApplicationMeta appMeta) async {
//     final UpiTransactionResponse response = await upiPay.initiateTransaction(
//       amount: pay_ruppe.toString(),
//       app: appMeta.application,
//       receiverName: payeeName,
//       receiverUpiAddress: upiId,
//       transactionRef: "TXN${DateTime.now().millisecondsSinceEpoch}",
//       transactionNote: 'College fee for 3rd semester of $name (Roll No: $roll_no)',
//     );
//     print(response.status);
//   }
// }
//
//   // Check Transaction Status
//   void _checkTxnStatus(UpiTransactionStatus status) {
//     switch (status) {
//       case UpiTransactionStatus.success:
//         print('Transaction Successful');
//         break;
//       case UpiTransactionStatus.submitted:
//         print('Transaction Submitted');
//         break;
//       case UpiTransactionStatus.failure:
//         print('Transaction Failed');
//         break;
//       default:
//         print('Unknown transaction status');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 90,
//         elevation: 0.0,
//         title: const Text("Aravali-Pay",
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//       ),
//       body: Align(
//         alignment: Alignment.center,
//         child: Column(
//           children: [
//             const CircleAvatar(
//               radius: 70,
//               backgroundImage:
//                   ExactAssetImage("assets/images/ara.jpeg", scale: 1),
//             ),
//             const SizedBox(height: 20),
//             const Padding(
//               padding: EdgeInsets.only(top: 8.0),
//               child: Text(
//                 "A.C.E.M.",
//                 style: TextStyle(
//                     fontStyle: FontStyle.italic,
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30),
//               ),
//             ),
//             // const Text("Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text("Details",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//             const SizedBox(
//               height: 20,
//             ),
//             // Text("Name: $name", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//             // Text("Course: $course", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//             // Text("Roll No: $roll_no", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//             // Text("Amount: Rs.$pay_ruppe", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//             // const SizedBox(height: 30),
//             Center(
//               child: Container(
//                 margin: const EdgeInsets.only(left: 40, right: 40),
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.all(Radius.circular(20)),
//                   color: Colors.blue[200],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           "Name",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           "course",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           "Roll No.",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           "Amount",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                       ],
//                     ),
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           " : ",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           " : ",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           " : ",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           " : ",
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           name,
//                           style: const TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           course,
//                           style: const TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           roll_no,
//                           style: const TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           "Rs.${pay_ruppe.toInt()}",
//                           style: const TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(28.0),
//               child: SlideAction(
//                 sliderButtonIcon: const Icon(Icons.arrow_forward),
//                 sliderRotate: true,
//                 sliderButtonIconSize: 10,
//                 submittedIcon: const Icon(Icons.currency_rupee),
//                 elevation: 0,
//                 innerColor: Colors.blue,
//                 outerColor: Colors.blue[300],
//                 height: 55,
//                 text: "Pay Now",
//                 onSubmit: () {
//                   if (apps == null || apps!.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text("No UPI apps found!"),
//                           backgroundColor: Colors.red,
//                       ),
//                     );
//                     return;
//                   }
//                   showModalBottomSheet(
//                     context: context,
//                     builder: (context) => Container(
//                       height: 175,
//                       width: double.infinity,
//                       child: ListView.builder(
//                         itemCount: apps!.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             leading: const Icon(Icons.account_balance_wallet),
//                             title: Text(apps![index].upiApplication.getAppName()),
//                             onTap: () {
//                               Navigator.pop(context);
//                               initiateUpiTransaction(apps![index]);
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:upi_pay/upi_pay.dart';

import '../../initial/Home.dart';
import '../../initial/autoLogin.dart';
import '../../initial/login.dart';
import '../../services/mysql_api.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

var user_email;
double paid = 0.0;
final upiPay = UpiPay();

class _PayState extends State<Pay> {
  late String dropdownValue_stream;
  List<ApplicationMeta>? upiApps;
  final String upiId = "8882083822@paytm"; // Replace with actual UPI ID
  final String payeeName = "Accounts dept Aravali";
  double payAmount = 1.0;

  @override
  void initState() {
    super.initState();
    _fetchUserEmail();
    _fetchUserPaymentDetails();
    _fetchInstalledUpiApps();

    dropdownValue_stream = course;
    if (["CSE", "AIML", "EC"].contains(dropdownValue_stream)) {
      payAmount = paid;
    }
  }

  // Fetch user email
  void _fetchUserEmail() {
    if (username.isEmpty) {
      user_email = user_email_live;
    } else {
      user_email = username;
    }
    setState(() {});
  }

  // Fetch payment details safely
  void _fetchUserPaymentDetails() async {
    try {
      var detailData = await Getdetails(user_email);
      var studData = jsonDecode(detailData);
      name = studData[0];
      roll_no = studData[1];
      course = studData[2];
      contact = studData[4];
      paid = double.tryParse(studData[5].toString()) ?? 0.0;
      setState(() {});
    } catch (e) {
      print("Error fetching details: $e");
    }
  }

  // Fetch installed UPI apps
  void _fetchInstalledUpiApps() async {
    try {
      List<ApplicationMeta> apps = await upiPay.getInstalledUpiApplications(
          statusType: UpiApplicationDiscoveryAppStatusType.all);
      setState(() {
        upiApps = apps;
      });

      // Debugging logs
      if (upiApps!.isNotEmpty) {
        print("✅ Installed UPI Apps:");
        for (var app in upiApps!) {
          print("📲 App: ${app.upiApplication.getAppName()}");
        }
      } else {
        print("❌ No UPI apps found!");
      }
    } catch (e) {
      print("🚨 Error fetching UPI apps: $e");
      setState(() {
        upiApps = [];
      });
    }
  }

  // UPI Transaction function
  Future<void> doUpiTransaction(ApplicationMeta appMeta) async {
    try {
      final UpiTransactionResponse response = await upiPay.initiateTransaction(
        amount: payAmount.toString(),
        app: appMeta
            .upiApplication, // ✅ Fixed to use ApplicationMeta.application
        receiverName: payeeName,
        receiverUpiAddress: upiId,
        transactionRef: "TXN${DateTime.now().millisecondsSinceEpoch}",
        transactionNote:
            'College fee for 3rd semester of $name (Roll No: $roll_no)',
      );

      print("Transaction Status: ${response.status}");
    } catch (e) {
      print("❌ UPI Transaction Failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0.0,
        title: const Text("Aravali-Pay",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage:
                  ExactAssetImage("assets/images/ara.jpeg", scale: 1),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "A.C.E.M.",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 20),

            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 40, right: 40),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.blue[200],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Name",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "course",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Roll No.",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Amount",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          " : ",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          " : ",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          " : ",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          " : ",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          course,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          roll_no,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Rs.${payAmount.toInt()}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: SlideAction(
                sliderButtonIcon: const Icon(Icons.arrow_forward),
                sliderRotate: true,
                sliderButtonIconSize: 10,
                submittedIcon: const Icon(Icons.currency_rupee),
                elevation: 0,
                innerColor: Colors.blue,
                outerColor: Colors.blue[300],
                height: 55,
                text: "Pay Now",
                onSubmit: () {
                  if (upiApps == null || upiApps!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No UPI apps found!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  showModalBottomSheet(
                    context: context,
                    builder: (context) =>Container(
                        height: 175,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: upiApps!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: upiApps![index].iconImage(48),
                              title: Text(
                                  upiApps![index].upiApplication.getAppName()),
                              onTap: () {
                                Navigator.pop(context);
                                doUpiTransaction(upiApps![index]);
                              },
                            );
                          },
                        ),
                      ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build the detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15)),
          Text(" : ", style: const TextStyle(fontSize: 15)),
          Text(value,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
