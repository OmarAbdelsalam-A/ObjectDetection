import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(String filePath) async {
    try {
      final file = File(filePath);
      final fileName = file.path.split('/').last;
      await storage.ref(fileName).putFile(file);
    } catch (e) {
      throw Exception("Failed to upload file: $e");
    }
  }

  Future<List<String>> fetchUploadedPhotos() async {
    try {
      final result = await storage.ref().listAll();
      return await Future.wait(result.items.map((item) => item.getDownloadURL()));
    } catch (e) {
      throw Exception("Failed to fetch uploaded photos: $e");
    }
  }

  Future<void> deleteFile(String filePath) async {
    try {
      final fileName = Uri.parse(filePath).pathSegments.last;
      await storage.ref(fileName).delete();
    } catch (e) {
      throw Exception("Failed to delete file: $e");
    }
  }
}
