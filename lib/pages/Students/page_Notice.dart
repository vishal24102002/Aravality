import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notice extends StatefulWidget {
  const Notice({super.key});
  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  final List<Map<String, String>> notices = [
    {
      "title": "Exam Schedule Released",
      "body": "The final exam timetable for Semester 6 has been released. Check the portal for details.",
      "department": "Examination Cell",
      "date": "2025-02-04"
    },
    {
      "title": "Holiday Announcement",
      "body": "College will remain closed on Feb 10 due to a public holiday.",
      "department": "Administration",
      "date": "2025-02-02"
    },
    {
      "title": "Project Submission Deadline",
      "body": "Final year students must submit their projects by March 15.",
      "department": "CSE Department",
      "date": "2025-01-29"
    },
  ];

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM d, yyyy').format(date); // Example: Feb 4, 2025
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
      shadowColor: Colors.transparent,
      title: const Text(
        "Notice",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: notices.length,
          itemBuilder: (context, index) {
            final notice = notices[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notice Title
                    Text(
                      notice["title"]!,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    SizedBox(height: 8),

                    // Notice Body (Summary)
                    Text(
                      notice["body"]!,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),

                    // Department & Date Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notice["department"]!,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        Text(
                          formatDate(notice["date"]!),
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}