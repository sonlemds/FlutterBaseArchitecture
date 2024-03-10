import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/model/chat.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FirebaseChatDatabase {
  CollectionReference<ChatDTO> getMessagesCollectionReference(
      String contactId) {
    return FirebaseFirestore.instance
        .collection('contacts')
        .doc(contactId)
        .collection(ChatDTO.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              ChatDTO.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  Future<void> sendMessage(
      {required String contactId, required ChatDTO chat}) async {
    try {
      var ref = getMessagesCollectionReference(contactId).doc();
      chat.messageID = ref.id;
      await ref.set(chat).timeout(const Duration(seconds: 60));
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError(e.message, e.code);
    } on IOException {
      throw const RemoteException.noInternet();
    } on TimeoutException {
      throw const RemoteException.timeoutError();
    } on Exception catch (exception) {
      throw RemoteException.unexpectedError(exception);
    }
  }

  Stream<QuerySnapshot<ChatDTO>> getMessagesStream(
      {required String contactId}) {
    return getMessagesCollectionReference(contactId).snapshots();
  }
}
