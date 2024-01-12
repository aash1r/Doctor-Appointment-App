import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/views/appointment_view.dart';
import 'package:doctor_appointment_app/views/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../../services/user.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    Key? key,
    required this.user,
    required this.admin,
  }) : super(key: key);

  final User user;
  final User admin;

  @override
  // ignore: library_private_types_in_public_api
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController messageController = TextEditingController();
  late String chatId;
  QueryDocumentSnapshot? document;
  List<Message> allMessages = [];
  final collection = _firestore.collection('chats');

  Future<void> setDoc() async {
    QuerySnapshot querySnapshot = await collection.get();
    if (querySnapshot.docs.isNotEmpty) {
      document = querySnapshot.docs.firstWhere(
        (doc) {
          bool checkOne = doc['userCnic'] == widget.user.cnic ||
              doc['userCnic'] == widget.admin.cnic;
          bool checkTwo = doc['adminCnic'] == widget.user.cnic ||
              doc['adminCnic'] == widget.admin.cnic;
          return checkOne && checkTwo;
        },
      );
      setState(() {});
    }
  }

  Future<void> sendMessage() async {
    if (document != null) {
      await document!.reference.update({
        'messages': FieldValue.arrayUnion(
          allMessages.map((message) => message.toJson()).toList(),
        ),
      });
    } else {
      chatId = const Uuid().v4();
      await collection.add({
        'messages': allMessages.map((message) => message.toJson()).toList(),
        'chatId': chatId,
        'userCnic': widget.user.cnic,
        'adminCnic': widget.admin.cnic,
      });
      await setDoc();
    }
  }

  Future<void> getData() async {
    await setDoc().then((value) {
      if (document != null) {
        allMessages.addAll(document!['messages']
                .map((message) => Message.fromJson(message))
                .cast<Message>()
                .toList() ??
            []);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 20,
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          widget.user.userName ?? "",
          style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AppointmentView(
                            user: widget.user.userName,
                          )));
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: const Color(0xFFB28CFF),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Book an appointment",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: document != null
                    ? collection.doc(document!.id).snapshots()
                    : StreamController().stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Text(
                      "Empty Chat :(",
                      style: GoogleFonts.manrope(
                          color: const Color(0xFFB28CFF),
                          fontWeight: FontWeight.w900),
                    ));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (allMessages.isEmpty) {
                    return const Center(child: Text('No messages'));
                  }
                  final List<Message> updatedMessages =
                      (snapshot.data!['messages'] as List<dynamic>?)
                              ?.map((message) => Message.fromJson(message))
                              .cast<Message>()
                              .toList() ??
                          [];
                  allMessages = updatedMessages;
                  return ListView.builder(
                    reverse: false,
                    itemCount: allMessages.length,
                    itemBuilder: (context, index) {
                      final message = allMessages[index];
                      final isAdmin = message.cnic == widget.admin.cnic;
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: Card(
                          color: isAdmin
                              ? const Color(0xFFB28CFF)
                              : const Color.fromARGB(255, 123, 192, 248),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              message.message ?? '',
                              textAlign:
                                  isAdmin ? TextAlign.right : TextAlign.left,
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
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
                    onTap: () async {
                      final newMessage = Message();
                      newMessage.message = messageController.text;
                      newMessage.cnic = widget.admin.cnic;
                      newMessage.currentDate = DateTime.now();
                      allMessages.add(newMessage);
                      messageController.clear();
                      await sendMessage();
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.send,
                      color: Color(0xFFB28CFF),
                    ),
                  ),
                  hintText: "Type your message...",
                  hintStyle: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
