import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UserFireStoreService {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Future getUser(String uid) async {
    try {
      QuerySnapshot querySnapshot =
          await _firebaseFireStore.collection('users').get();

      for (var doc in querySnapshot.docs) {
        print('User ID: ${doc.id}, Name: ${doc['name']}');
      }
    } on FirebaseException catch (e) {
      throw RemoteException.firebaseError('Error getting user: $e', e.code);
    }
  }
}
