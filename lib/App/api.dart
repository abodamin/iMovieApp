import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient._();

  static final ApiClient apiClient = ApiClient._();
  static final http.Client _httpClient = http.Client();
  //Dev API
  static final String _DEV_URL = "http://blabla-dev.com";
  //Prod API
  // static final String _DEV_URL = "https://blabla-prod.com/";
  static final String _BASE_URL = "$_DEV_URL";

  // Future<TempClass> postTemplate(String id) async {
  //   Map<String, String> header = {
  //     'Content-type': 'application/json',
  //     'token': mUserToken,
  //   };

  //   try {
  //     final response = await _httpClient.get(
  //       "$_BASE_URL/AAA/BBB?xxxID=" + id,
  //       headers: header,
  //     );

  //     print("PostTemplate " + response.body);
  //     //return parseOtp(response.body);
  //     final parsed = json.decode(response.body);
  //     return TempClass.fromJson(parsed);
  //   } on SocketException {
  //     return Future.error("check your internet connection");
  //   } on http.ClientException {
  //     return Future.error("check your internet connection");
  //   } catch (e) {
  //     return Future.error("Server Error");
  //   }
  // }

  // Future<TempClass> getTemplate(String url) async {
  //   try {
  //     print("asdfsdaf " + mUserToken + "   " + mUserName + "  " + mUserID);
  //     Map<String, String> header = {
  //       'Content-type': 'application/json',
  //       'token': mUserToken,
  //     };

  //     final response = await _httpClient.get(url, headers: header);
  //     print("getTemplate " + response.body);
  //     return TempClass.fromJson(response.body);
  //   } on SocketException {
  //     return Future.error("check your internet connection");
  //   } on http.ClientException {
  //     return Future.error("check your internet connection");
  //   } catch (e) {
  //     return Future.error("Server Error");
  //   }
  // }

  // Future<TempClass> putTemplate(
  //     int id, String name, String birthday, var file) async {
  //   try {
  //     Map<String, String> header = {
  //       'Content-type': 'application/json',
  //       'token': mUserToken,
  //     };

  //     final response = await _httpClient.put(
  //       "http://$_BASE_URL/Edit",
  //       body: jsonEncode(<String, dynamic>{
  //         'ID': id,
  //         'Name': name,
  //         'BirthDate': birthday,
  //         'Files': file
  //       }),
  //       headers: header,
  //     );
  //     print(
  //       "upload_res " +
  //           jsonEncode(
  //             <String, dynamic>{
  //               'Name': mUserID,
  //               'BirthDate': birthday,
  //               'Files': file
  //             },
  //           ),
  //     );
  //     print("upload_res " + response.body);
  //     //return parseOtp(response.body);
  //     final parsed = json.decode(response.body);
  //     return TempClass.fromJson(parsed);
  //   } on SocketException {
  //     return Future.error("check your internet connection");
  //   } on http.ClientException {
  //     return Future.error("check your internet connection");
  //   } catch (e) {
  //     return Future.error("Server Error");
  //   }
  // }

  // Future<dynamic> uploadImageOnServer(List<ByteData> byteImages,
  //     {bool isComment = false}) async {
  //   Map<String, String> header = {
  //     'Content-type': 'application/json',
  //     'token': mUserToken,
  //   };

  //   List<dynamic> arrayOfFiles = List();
  //   Uri uri = Uri.parse('$_BASE_URL/AAA/BBB');

  //   var request = new http.MultipartRequest("POST", uri);
  //   request.headers.addAll(header);
  //   for (int i = 0; i < byteImages.length; i++) {
  //     List<int> imageData = byteImages[i].buffer.asUint8List();
  //     MultipartFile multipartFile = new http.MultipartFile.fromBytes(
  //       'image$i', //<-- this was causing overriding image.
  //       imageData,
  //       filename: ".jpg",
  //     );
  //     // mLogger.wtf('imageData: ${imageData}');
  //     request.files.add(multipartFile);
  //   }

  //   var response = await request.send();

  //   Stream<String> v = await response.stream.transform(utf8.decoder);
  //   String vv = await v.first;
  //   final parsed = json.decode(vv);
  //   print("LL1 " + parsed.toString());
  //   ImageData imageData = ImageData.fromJson(parsed);
  //   for (int i = 0; i < imageData.data.length; i++) {
  //     var g = isComment ?? false
  //         ? {
  //             'FileName': imageData.data[i].newFileName.toString(),
  //             'FileType': "image",
  //           }
  //         : {
  //             'FileName': imageData.data[i].newFileName.toString(),
  //             'FileType': imageData.data[i].extension.toString(),
  //           };
  //     arrayOfFiles.add(g);
  //   }

  //   return arrayOfFiles;
  // }

  // Future<dynamic> uploadVideoOnServer(filePath,
  //     {bool isComment = false}) async {
  //   var request =
  //       http.MultipartRequest('POST', Uri.parse('$_BASE_URL/AAA/BBB'));

  //   request.files.add(await http.MultipartFile.fromPath(
  //     "VideoFiles",
  //     filePath,
  //     filename: "file.mp4",
  //     contentType: MediaType("video", "mp4"),
  //   ));
  //   var res = await request.send();
  //   Stream<String> v = await res.stream.transform(utf8.decoder);

  //   String vv = await v.first;
  //   final parsed = json.decode(vv);
  //   print("video_resOK " + parsed.toString());
  //   ImageData imageData = ImageData.fromJson(parsed);
  //   List<dynamic> arrayOfFiles = List();

  //   for (int i = 0; i < imageData.data.length; i++) {
  //     var g = isComment ?? false
  //         ? {
  //             'FileName': imageData.data[i].newFileName.toString(),
  //             'FileType': "video",
  //           }
  //         : {
  //             'FileName': imageData.data[i].newFileName.toString(),
  //             'FileType': "mp4",
  //             // 'FileType': imageData.data[i].extension.toString(),
  //           };
  //     arrayOfFiles.add(g);
  //   }
  //   return arrayOfFiles;
  // }

  // Future<TempClass> DeleteTemplate(String id) async {
  //   Map<String, String> header = {
  //     'Content-type': 'application/json',
  //     'token': mUserToken,
  //     //        'token': 'UVhKZ2hCN2NRcTNQazVDREVSeml3TnlpS0RhbTgzSkh0ZUUvb3ZCbis5Zz06MTU6NjM3Mjc5MDkxNTAzNDM4NTk0',
  //   };
  //   try {
  //     final response = await _httpClient.delete(
  //       "$_BASE_URL/AAA/Delete?id=" + id.toString(),
  //       headers: header,
  //     );

  //     print("DeleteGroup " + response.body);
  //     //return parseOtp(response.body);
  //     final parsed = json.decode(response.body);
  //     return TempClass.fromJson(parsed);
  //   } on SocketException {
  //     return Future.error("check your internet connection");
  //   } on http.ClientException {
  //     return Future.error("check your internet connection");
  //   } catch (e) {
  //     return Future.error("Server Error");
  //   }
  // }

}

class TempClass {
  static Future<TempClass> fromJson(parsed) {}
}
