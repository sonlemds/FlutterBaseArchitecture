import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/model/chat.dart';
import 'package:injectable/injectable.dart';

import 'firebase/firebase_chat_database.dart';

@LazySingleton()
class FirebaseChatRemoteDataSource {
  FirebaseChatDatabase database;

  FirebaseChatRemoteDataSource({required this.database});

  Future<void> sendMessage(
      {required ChatDTO chat, required String contactId}) async {
    await database.sendMessage(chat: chat, contactId: contactId);
  }

  Stream<QuerySnapshot<ChatDTO>> getMessages({required String contactId}) {
    return database.getMessagesStream(contactId: contactId);
  }
}
