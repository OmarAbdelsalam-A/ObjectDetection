import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SavedPhotosPage extends StatefulWidget {
  @override
  _SavedPhotosPageState createState() => _SavedPhotosPageState();
}

class _SavedPhotosPageState extends State<SavedPhotosPage> {
  List<File> photos = [];

  @override
  void initState() {
    super.initState();
    loadPhotos();
  }

  Future<void> loadPhotos() async {
    final dir = await getApplicationDocumentsDirectory();
    final photoDir = Directory(dir.path);
    final files = photoDir.listSync().where((file) => file is File).cast<File>().toList();
    setState(() {
      photos = files;
    });
  }

  void deletePhoto(File photo) async {
    await photo.delete();
    loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved Photos")),
      body: photos.isEmpty
          ? Center(child: Text("No photos saved"))
          : ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.file(photos[index]),
            title: Text(photos[index].path.split('/').last),
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
