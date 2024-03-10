import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

@LazySingleton()
class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile({
    required String folderName,
    required File postFile,
  }) async {
    final fileName = basename(postFile.path);
    final destination = 'files/$folderName/$fileName';
    final ref = _storage.ref(destination);
    UploadTask uploadTask = ref.putFile(postFile);
    String fileOfPostUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return fileOfPostUrl;
  }

  Future<String> uploadData(
      {required String folderName, required Uint8List data}) async {
    final fileName = DateTime.now().toString();
    final destination = 'data/$folderName/$fileName';
    final ref = _storage.ref(destination);
    UploadTask uploadTask = ref.putData(data);
    String fileOfPostUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return fileOfPostUrl;
  }

  Future<void> deleteFile(String fileUrl) async {
    final Reference fileRef = _storage.refFromURL(fileUrl);
    await fileRef.delete();
  }

  Future<File> downloadFile(String fileUrl, String saveToPath) async {
    final Reference fileRef = _storage.refFromURL(fileUrl);
    final bytes = await fileRef.getData();
    final file = File(saveToPath);
    await file.writeAsBytes(bytes!);
    return file;
  }
}
