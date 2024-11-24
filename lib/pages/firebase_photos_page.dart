import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class FirebasePhotosPage extends StatefulWidget {
  @override
  _FirebasePhotosPageState createState() => _FirebasePhotosPageState();
}

class _FirebasePhotosPageState extends State<FirebasePhotosPage> {
  final FirebaseService firebaseService = FirebaseService();
  List<String> photos = [];

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    try {
      final urls = await firebaseService.fetchUploadedPhotos();
      setState(() {
        photos = urls;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching photos: $e")),
      );
    }
  }

  void deletePhoto(String photoUrl) async {
    try {
      await firebaseService.deleteFile(photoUrl);
      fetchPhotos();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting photo: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Photos")),
      body: photos.isEmpty
          ? Center(child: Text("No photos uploaded"))
          : ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(photos[index]),
            title: Text('Photo ${index + 1}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deletePhoto(photos[index]),
            ),
          );
        },
      ),
    );
  }
}
