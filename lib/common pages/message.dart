import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class Message_chat extends StatefulWidget {
  @override
  _Message_chatState createState() => _Message_chatState();
}

class _Message_chatState extends State<Message_chat> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_controller.text.trim().isNotEmpty) {
      await _firestore.collection('messages').add({
        'text': _controller.text.trim(),
        'sender': _auth.currentUser?.email ?? 'Unknown',
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
    }
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "Unknown";
    DateTime date = timestamp.toDate();
    return DateFormat('MMM d, yyyy - h:mm a').format(date);
  }

  void deleteMessage(String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Message?"),
        content: const Text("Are you sure you want to delete this message?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await _firestore.collection('messages').doc(docId).delete();
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
          title: const Text("Chat")
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                var messages = snapshot.data!.docs;
                String currentUserEmail = _auth.currentUser?.email ?? '';

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    String docId = message.id;
                    String sender = message['sender'];
                    String text = message['text'];
                    Timestamp? timestamp = message['timestamp'] as Timestamp?;
                    String formattedTime = formatTimestamp(timestamp);

                    bool isCurrentUser = sender == currentUserEmail;

                    return Align(
                      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: GestureDetector(
                        onLongPress: isCurrentUser ? () => deleteMessage(docId) : null, // Only delete own messages
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          constraints: const BoxConstraints(maxWidth: 250), // Message width limit
                          decoration: BoxDecoration(
                            color: isCurrentUser ? Colors.blueAccent : Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10),
                              topRight: const Radius.circular(10),
                              bottomLeft: isCurrentUser ? const Radius.circular(10) : Radius.zero,
                              bottomRight: isCurrentUser ? Radius.zero : const Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isCurrentUser) // Show sender email for other users
                                Text(
                                  sender,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
                                ),
                              const SizedBox(height: 3),
                              Text(
                                text,
                                style: TextStyle(fontSize: 14, color: isCurrentUser ? Colors.white : Colors.black),
                              ),
                              const SizedBox(height: 3),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  formattedTime,
                                  style: TextStyle(fontSize: 10, color: isCurrentUser ? Colors.white70 : Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Message Input Box
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      hintText: "Enter message...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}