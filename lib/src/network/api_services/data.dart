class DocumentTempUploadResponseData {
  DocumentTempUploadResponseData({
    this.status,
    this.message,
    this.tempPath,
    this.fileName,
    this.downloadUrl,
  });

  final num? status;
  final String? message;
  final String? tempPath;
  final String? fileName;
  final String? downloadUrl;

  factory DocumentTempUploadResponseData.fromJson(Map<String, dynamic> json) {
    return DocumentTempUploadResponseData(
      status: json["status"] ?? 0,
      message: json["message"] ?? "",
      tempPath: json["tempPath"] ?? "",
      downloadUrl: json["downloadUrl"] ?? "",
      fileName: json["fileName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "tempPath": tempPath,
    "fileName": fileName,
  };
}
