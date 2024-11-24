import 'package:flutter/material.dart';

class FirebasePhotoListItem extends StatelessWidget {
  final String photoUrl;
  final Function() onDelete;

  FirebasePhotoListItem({
    required this.photoUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(photoUrl),
      title: Text(photoUrl.split('/').last),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
