import 'package:flutter/material.dart';

class TimetablePage extends StatefulWidget {
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample timetable data
  final Map<String, List<Map<String, String>>> timetable = {
    "Monday": [
      {"time": "09:00 - 10:00 AM", "subject": "Mathematics", "faculty": "Dr. A. Sharma"},
      {"time": "10:00 - 11:00 AM", "subject": "Physics", "faculty": "Prof. B. Singh"},
      {"time": "11:30 - 12:30 PM", "subject": "Computer Science", "faculty": "Dr. C. Verma"},
      {"time": "01:30 - 02:30 PM", "subject": "Electronics", "faculty": "Prof. D. Mishra"},
    ],
    "Tuesday": [
      {"time": "09:00 - 10:00 AM", "subject": "Chemistry", "faculty": "Dr. E. Tiwari"},
      {"time": "10:00 - 11:00 AM", "subject": "Mathematics", "faculty": "Dr. A. Sharma"},
      {"time": "11:30 - 12:30 PM", "subject": "Data Structures", "faculty": "Prof. F. Gupta"},
      {"time": "01:30 - 02:30 PM", "subject": "Mechanical", "faculty": "Dr. G. Reddy"},
    ],
    "Wednesday": [
      {"time": "09:00 - 10:00 AM", "subject": "Physics", "faculty": "Prof. B. Singh"},
      {"time": "10:00 - 11:00 AM", "subject": "Mathematics", "faculty": "Dr. A. Sharma"},
      {"time": "11:30 - 12:30 PM", "subject": "Database Management", "faculty": "Prof. H. Rao"},
      {"time": "01:30 - 02:30 PM", "subject": "Artificial Intelligence", "faculty": "Dr. I. Nair"},
    ],
    "Thursday": [
      {"time": "09:00 - 10:00 AM", "subject": "Software Engineering", "faculty": "Prof. J. Pandey"},
      {"time": "10:00 - 11:00 AM", "subject": "Computer Networks", "faculty": "Dr. K. Das"},
      {"time": "11:30 - 12:30 PM", "subject": "Operating Systems", "faculty": "Prof. L. Shukla"},
      {"time": "01:30 - 02:30 PM", "subject": "Machine Learning", "faculty": "Dr. M. Joshi"},
    ],
    "Friday": [
      {"time": "09:00 - 10:00 AM", "subject": "Python Programming", "faculty": "Dr. N. Singh"},
      {"time": "10:00 - 11:00 AM", "subject": "Data Science", "faculty": "Prof. O. Patel"},
      {"time": "11:30 - 12:30 PM", "subject": "Cloud Computing", "faculty": "Dr. P. Kumar"},
      {"time": "01:30 - 02:30 PM", "subject": "Cyber Security", "faculty": "Prof. Q. Jain"},
    ],
    "Saturday": [
      {"time": "09:00 - 10:00 AM", "subject": "Ethics & Communication", "faculty": "Dr. R. Yadav"},
      {"time": "10:00 - 11:00 AM", "subject": "Blockchain Technology", "faculty": "Prof. S. Mehta"},
      {"time": "11:30 - 12:30 PM", "subject": "IoT & Smart Systems", "faculty": "Dr. T. Kapoor"},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: timetable.keys.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timetable"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: timetable.keys.map((day) => Tab(text: day)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: timetable.keys.map((day) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: timetable[day]!.map((lecture) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        lecture["subject"]!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🕒 ${lecture["time"]!}", style: TextStyle(fontSize: 14)),
                          Text("👨‍🏫 ${lecture["faculty"]!}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
