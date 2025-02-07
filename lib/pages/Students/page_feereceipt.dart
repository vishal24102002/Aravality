import 'package:flutter/material.dart';

// import '../../initial/Admin_home.dart';
import '../../initial/Home.dart';


class Fee extends StatefulWidget {
  const Fee({super.key});

  @override
  State<Fee> createState() => _FeeState();
}

class _FeeState extends State<Fee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shadowColor: Colors.transparent,
        title: const Text(
            "Fee-Details",
            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // College Logo and Name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage:
                    ExactAssetImage("assets/images/ara.jpeg", scale: 0.5),
                  ), // College Icon
                  SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ARAVALI",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.red, // Red color for ARAVALI
                        ),
                      ),
                      Text(
                        "College of Engineering & Management",
                        style: TextStyle(
                          fontSize: 14, // Smaller font
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(thickness: 2),

              // Student Details
              Center(child: Text("Student Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              SizedBox(height: 5),
              buildRow("Student Name", "$name"),
              buildRow("Roll No", "$roll_no"),
              buildRow("Course", "$course"),
              buildRow("Semester", "$semester"),
              buildRow("Date of Payment", "dateofpayment"),

              SizedBox(height: 10),

              // Fee Details
              Center(child: Text("Fee Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              SizedBox(height: 5),
              buildRow("Semester Installment", "₹$paid"),
              buildRow("Library Fine", "₹0"),
              buildRow("Hostel Fee", "₹0"),
              buildRow("Advance", "₹0"),
              buildRow("Total Amount paid", "₹", isBold: true),

              SizedBox(height: 20),

              // Signature & Stamp
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(child: Text("Stamp Here")),
                      ),
                      Text("College Stamp", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Authorized Sign", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method to Create Rows
  Widget buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
