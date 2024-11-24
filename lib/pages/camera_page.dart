import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  int _selectedCameraIndex = 0;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[_selectedCameraIndex], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {
      isInitialized = true;
    });
  }

  Future<void> capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }
    try {
      final path = (await getApplicationDocumentsDirectory()).path;
      final photo = await _controller!.takePicture();
      final savedPath = File('$path/${DateTime.now().toString()}.jpg');
      await File(photo.path).copy(savedPath.path);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Photo saved at $savedPath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error capturing photo: $e")),
      );
    }
  }

  void switchCamera() async {
    final cameras = await availableCameras();
    if (cameras.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras.length;
      await _controller?.dispose();
      _controller = CameraController(cameras[_selectedCameraIndex], ResolutionPreset.high);
      await _controller!.initialize();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera")),
      body: isInitialized
          ? CameraPreview(_controller!)
          : Center(child: CircularProgressIndicator()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: capturePhoto,
            child: Icon(Icons.camera),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: switchCamera,
            mini: true,
            child: Icon(
              _selectedCameraIndex == 0 ? Icons.camera_front : Icons.camera_rear,
            ),
          ),
        ],
      ),
    );
  }
}