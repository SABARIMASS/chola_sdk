import 'dart:convert';
import 'dart:io';
import 'package:cholai_sdk/src/constants/api_constants.dart';
import 'package:cholai_sdk/src/constants/app_strings.dart';
import 'package:cholai_sdk/src/utils/logger_util.dart';
import 'package:get/get.dart';
import '../api_provider.dart';
import 'data.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart'; // For file path manipulation

final ApiProvider apiProvider = GetInstance().put(ApiProvider());
Future<DocumentTempUploadResponseData> documentUploadTempApi(
  String imagePath,
) async {
  try {
    final file = File(imagePath);
    final fileBytes = await file.readAsBytes();
    final fileName = basename(file.path); // Get the file name with extension

    // Determine MIME type based on file extension
    String mimeType = 'image/jpeg'; // Default MIME type
    if (fileName.endsWith('.png')) {
      mimeType = 'image/png';
    } else if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg')) {
      mimeType = 'image/jpeg';
    }

    // Create a MultipartFile with the correct contentType
    final multipartFile = MultipartFile(
      fileBytes,
      filename: fileName,
      contentType: mimeType, // Directly set the MIME type as a string
    );

    // Make the request
    final response = await apiProvider.httpRequest(
      resource: Resource(url: ApiConstants.uploadTempUrl, request: ''),
      formData: FormData({'image': multipartFile}),
      requestType: RequestType.kPost,
    );

    LoggerUtil.debug("Upload Image Response: $response");

    return DocumentTempUploadResponseData.fromJson(json.decode(response));
  } catch (e) {
    LoggerUtil.error("Error: Upload Temp Image Error: $e");
    throw AppStrings.errorMessage;
  }
}
