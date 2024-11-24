import 'package:flutter/material.dart';
import 'camera_page.dart';
import 'saved_photos_page.dart';
import 'firebase_photos_page.dart';
import '../widgets/ar_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ARCore + YOLOv8 App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ARViewWidget()));
              },
              child: Text("AR Object Detection"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()));
              },
              child: Text("Take Photos"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SavedPhotosPage()));
              },
              child: Text("View Saved Photos"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FirebasePhotosPage()));
              },
              child: Text("Firebase Photos"),
            ),
          ],
        ),
      ),
    );
  }
}
