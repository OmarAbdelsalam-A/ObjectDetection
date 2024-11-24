import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ARViewWidget extends StatefulWidget {
  @override
  _ARViewState createState() => _ARViewState();
}

class _ARViewState extends State<ARViewWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AR Object Detection")),
      body: ARView(
        onARViewCreated: onARViewCreated,
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager? arAnchorManager,
      ARLocationManager? arLocationManager,
      ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    arSessionManager.onPlaneOrPointTap = placeMarker;
  }

  Future<void> placeMarker(List<ARHitTestResult> hitTestResults) async {
    if (hitTestResults.isNotEmpty) {
      var worldTransform = hitTestResults.first.worldTransform;

      Vector3? position = extractPosition(worldTransform);

      var markerResult = await arObjectManager?.addNode(
        ARNode(
          type: NodeType.localGLTF2,
          uri: "assets/marker.glb",
          position: position,
          scale: Vector3(0.2, 0.2, 0.2),
        ),
      );
    }
  }

  /// Function to extract the position from Matrix4
  Vector3 extractPosition(Matrix4 matrix) {
    final translation = Vector3.zero();
    matrix.copyTranslation(translation);
    return translation;
  }
}

extension on Matrix4 {
  void copyTranslation(Vector3 translation) {}
}
