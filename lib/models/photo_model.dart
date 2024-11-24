class PhotoModel {
  final String localPath;
  bool isUploaded;
  String? firebaseUrl;

  PhotoModel({
    required this.localPath,
    this.isUploaded = false,
    this.firebaseUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'localPath': localPath,
      'isUploaded': isUploaded,
      'firebaseUrl': firebaseUrl,
    };
  }

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      localPath: json['localPath'],
      isUploaded: json['isUploaded'] ?? false,
      firebaseUrl: json['firebaseUrl'],
    );
  }
}
