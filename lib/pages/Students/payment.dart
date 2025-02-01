import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:upi_india/upi_india.dart';
import '../../initial/Home.dart';
import '../../initial/autoLogin.dart';
import '../../initial/login.dart';
import '../../services/mysql_api.dart';
import 'payment_entry.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});
  @override
  State<Pay> createState() => _PayState();
}

var user_email;
double paid = 0.0;

class _PayState extends State<Pay> {
  final UpiIndia _upiIndia = UpiIndia();
  Future<UpiResponse>? _transaction;
  List<UpiApp>? apps;
  double pay_ruppe = 1.0;

  //details funtion again
  void User_Email() {
    if (username.isEmpty) {
      user_email = user_email_live;
    } else {
      user_email = username;
    }
    print(user_email);
    setState(() {});
  }

  void getdetail_email_pay() async {
    print(user_email);
    var detailData = await Getdetails(user_email);
    var studData = jsonDecode(detailData);
    name = studData[0];
    roll_no = studData[1];
    course = studData[2];
    contact = studData[4];
    paid = studData[5].toDouble();
    setState(() {});
  }

  @override
  void initState() {
    User_Email();
    getdetail_email_pay();
    dropdownValue_stream = course;
    if (dropdownValue_stream == "CSE") {
      pay_ruppe = 20000.00 - paid;
    } else if (dropdownValue_stream == "AIML") {
      pay_ruppe = 21000.00 - paid;
    } else if ((dropdownValue_stream == "EC")) {
      pay_ruppe = 17000.00 - paid;
    } else if ((dropdownValue_stream == "EC")) {
      pay_ruppe = 15000.00 - paid;
    }
    // if (dropdownValue == "B-Tech") {
    //
    // }
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "8882083822@paytm",
      receiverName: 'Accounts dept Aravali',
      transactionRefId: 'Aravali College of Engineering & Management',
      transactionNote:
          'college fee for 3rd semester of $name whose roll no. is $roll_no',
      amount: pay_ruppe,
    );
  }

  void _checkTxnStatus(String status) {
    print("status vishal is good");
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  //display the transaction data in widget format
  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),),
          Flexible(
              child: Text(
            body,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0.0,
        title: const Text("Aravali-Pay",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: 30,
        alignment: Alignment.bottomRight,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "team: coder-x",
            style: TextStyle(
                fontSize: 8, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      ExactAssetImage("assets/images/ara.jpeg", scale: 1),
                ),
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
                const SizedBox(
                  height: 20,
                ),
                const Text("Details",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
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
                              "Rs.$pay_ruppe",
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
                FutureBuilder(
                    future: _transaction,
                    builder: (BuildContext context,
                        AsyncSnapshot<UpiResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              _upiErrorHandler(snapshot.error.runtimeType),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ), // Print's text message on screen
                          );
                        }

                        // If we have data then definitely we will have UpiResponse.
                        // It cannot be null
                        UpiResponse upiResponse = snapshot.data!;

                        // Data in UpiResponse can be null. Check before printing
                        String txnId = upiResponse.transactionId ?? 'N/A';
                        String resCode = upiResponse.responseCode ?? 'N/A';
                        String txnRef = upiResponse.transactionRefId ?? 'N/A';
                        String status = upiResponse.status ?? 'N/A';
                        String approvalRef =
                            upiResponse.approvalRefNo ?? 'N/A';
                        _checkTxnStatus(status);

                        return AlertDialog(
                          title: const Text("payment status"),
                          content:Text(status,style: const TextStyle(color:Colors.red,fontWeight: FontWeight.bold),),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                              Navigator.pop(context);
                            },
                              child: const Text("Close",textAlign: TextAlign.right,),
                            )
                          ]
                        );
                      } else {
                        return const Center(
                          child: Text(''),
                        );
                      }
                    }),
                ///////////////////////////////////////////////////////////////
                const SizedBox(
                  height: 30,
                ),
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
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          color: Colors.amber,
                          height: 175,
                          width: double.infinity,
                          child: Center(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: apps!.map<Widget>((UpiApp app) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _transaction = initiateTransaction(app);
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    height: 150,
                                    width: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.memory(
                                          app.icon,
                                          height: 70,
                                          width: 70,
                                        ),
                                        Text(app.name),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                      return null;
                    },
                  ),
                ),
                const Text("Note !!!",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
                const Text(
                  "If the amount is wrong then please confirm it with Accounts Department",
                  style: TextStyle(fontSize: 10, color: Colors.red),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
