class MarkMessageStatusRequest {
  String? messageId;
  String? status;

  MarkMessageStatusRequest({this.messageId, this.status});

  Map<String, dynamic> toJson() {
    return {'messageId': messageId, 'status': status};
  }
}

class MarkMessageStatusResponse {
  final int status;
  final String message;

  MarkMessageStatusResponse({required this.status, required this.message});

  factory MarkMessageStatusResponse.fromJson(Map<String, dynamic> json) {
    return MarkMessageStatusResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
