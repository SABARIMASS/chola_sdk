class AuthorizationResponse {
  final num? status;
  final String? message;
  final String? accessToken;

  AuthorizationResponse({this.status, this.message, this.accessToken});

  factory AuthorizationResponse.fromJson(Map<String, dynamic> json) {
    return AuthorizationResponse(
      status: json['status'] is num ? json['status'] : null,
      message: json['message'] is String ? json['message'] : null,
      accessToken: json['access_token'] is String ? json['access_token'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message};
  }
}

class RefreshTokenRequest {
  final String grantType;
  final String refreshToken;

  RefreshTokenRequest({
    this.grantType = 'refresh_token',
    required this.refreshToken,
  });

  Map<String, String> toJson() {
    return {'grant_type': grantType, 'refreshToken': refreshToken};
  }
}

class OrganizationHeader {
  final String orgId;
  final String orgName;
  final String? token;

  OrganizationHeader({required this.orgId, required this.orgName, this.token});
}
