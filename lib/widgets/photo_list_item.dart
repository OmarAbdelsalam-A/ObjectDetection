import 'dart:io';
import 'package:flutter/material.dart';

class PhotoListItem extends StatelessWidget {
  final File photo;
  final bool isUploaded;
  final VoidCallback onDelete;
  final VoidCallback onUpload;

  const PhotoListItem({
    required this.photo,
    required this.isUploaded,
    required this.onDelete,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.file(photo, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(photo.path.split('/').last),
      subtitle: Text(isUploaded ? 'Uploaded' : 'Not Uploaded'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.upload, color: isUploaded ? Colors.grey : Colors.blue),
            onPressed: isUploaded ? null : onUpload,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
