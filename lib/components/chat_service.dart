import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createChat(String patientId, String doctorId) async {
    // Create a new chat document
    final chatRef = await _firestore.collection('chats').add({
      'participants': {
        'patient_id': patientId,
        'doctor_id': doctorId,
      },
      'messages': [],
    });

    return chatRef.id;
  }

  Stream<QuerySnapshot> getChatMessages(String chatId) {
    // Stream of messages for a specific chat
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .snapshots();
  }

  Future<void> sendMessage(String chatId, String senderId, String text) async {
    // Add a new message to the chat
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'sender_id': senderId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
