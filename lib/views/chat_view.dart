import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/services/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.user});
  final User user;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController messageController = TextEditingController();

  void sendMessage() {
    _firestore.collection('messages').add({
      'message': messageController.text,
      'created_at': FieldValue.serverTimestamp(),
      'role': widget.user.role,
      'cnic': widget.user.cnic
    });
    messageController.clear();
  }

  Future<List<String>> getUserMessages() async {
    final userCollection = _firestore.collection(widget.user.role ?? '');
    final userDoc = await userCollection.doc(widget.user.cnic).get();
    final messages = userDoc.data()?['messages']?.cast<String>() ?? [];
    return messages;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection("messages").snapshots(),
              builder: (context, snapshot) {
                List<DocumentSnapshot> documents = snapshot.data?.docs ?? [];
                final userMessages = documents
                    .where((doc) =>
                        doc.data() is Map<String, dynamic> &&
                        (doc.data() as Map<String, dynamic>)
                            .containsKey('cnic') &&
                        doc['cnic'] == widget.user.cnic)
                    .toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: userMessages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(3),
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            userMessages[index]['message'],
                            textAlign: TextAlign.right,
                            style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: sendMessage,
                  child: const Icon(
                    Icons.send,
                    color: Color(0xFFB28CFF),
                  ),
                ),
                hintText: "Type your message...",
                hintStyle: GoogleFonts.manrope(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      //     )
    );
  }
}
