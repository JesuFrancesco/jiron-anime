class UploadedFile {
  final String originalName;
  final String filePath;
  final String publicUrl;

  UploadedFile({
    required this.originalName,
    required this.filePath,
    required this.publicUrl,
  });

  factory UploadedFile.fromJson(Map<String, dynamic> json) {
    return UploadedFile(
      originalName: json['originalName'] as String,
      filePath: json['filePath'] as String,
      publicUrl: json['publicUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'originalName': originalName,
      'filePath': filePath,
      'publicUrl': publicUrl,
    };
  }
}

class UploadResponse {
  final String message;
  final List<UploadedFile> files;

  UploadResponse({required this.message, required this.files});

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      message: json['message'] as String,
      files: (json['files'] as List)
          .map((file) => UploadedFile.fromJson(file))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'files': files.map((file) => file.toJson()).toList(),
    };
  }
}
