import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';



class ImageUploadProvider extends ChangeNotifier {
  bool isLoading = false;

  bool isGetPredictData=false;

  bool isPredicting = false;

  final _accessToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjdjMDJiMTE5ZjA2NTY3NjM0MDhkNTgwIiwiaWF0IjoxNzQxMTY1MTU4fQ.t9mlLfZKyUhn-5bA7er9ZGWGANoLnjfBAtq3NLYxQ0Q";

  File? _image;

  File? get image => _image;

  String? responseText;

  String? uidata;

  Map<String, dynamic>? malumot;
  String? createData;


  String filePath = "";

  void setImage(File imageFile) {
    _image = imageFile;
    notifyListeners();
  }

  Future<void> uploadImage() async {
    if (_image == null) return;
    isLoading = true;
    notifyListeners();

    try {
      var uri = Uri.parse("https://api.agronomai.birnima.uz/api/upload");
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $_accessToken';

      request.headers['Accept'] = "*/*";
      request.headers['Content-Type'] = "multipart/form-data";

      var mimeType = lookupMimeType(image!.path) ?? 'image/jpeg';

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        image!.path,
        contentType: MediaType.parse(mimeType),
      ));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        responseText = responseBody;
        final imgPath = jsonDecode(responseText!);
        filePath = imgPath['data']['url'];

        log("$filePath       salom");
      } else {
        responseText = "xatolik";
      }
    } catch (e) {
      responseText = "server xatosi $e";
    }

    isLoading = false;
    notifyListeners();
  }


  Future<void> getDatawithImage(String imagePath) async {
  log("Keldi");
  log(imagePath);
  isPredicting = true;
  notifyListeners();
  try {
    log("Tryga tushdi");

    final uri = Uri.parse("https://api.agronomai.birnima.uz/api/predict");
    final response = await http.post(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"image_path": imagePath}),
    );

    log("Serverdan javob keldi: ${response.body}");

    if (response.statusCode == 201) {
      final decodedResponse = jsonDecode(response.body);

      malumot=decodedResponse['data']['type'];
      createData=decodedResponse['data']['created_at'].toString();

      uidata=malumot!['description'].toString();

    }}catch(e)
    {
      throw Exception(e);
    }


  isPredicting = false;
  notifyListeners();
}



 List<dynamic> predictData=[];
  void getPredictData()async
  {

    isGetPredictData=true;
    notifyListeners();

    try {

      final url=Uri.parse("https://api.agronomai.birnima.uz/api/predict");

      final response= await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json',
      },);

      log(response.body);

      log(isGetPredictData.toString());

      if(response.statusCode==200)
      {
         final jsonData=jsonDecode(response.body);
          log("ok +++");
         predictData=jsonData['data'];
      }

    }catch(e)
    {
      log("xato 444444444444444444");
      throw Exception(e);
    }

    isGetPredictData=false;

    log(isGetPredictData.toString());
    notifyListeners();

  }


}











   // 🛑 To‘g‘ri decodlash
  //     log("Decoded response: $decodedResponse");

  //     // if (decodedResponse.containsKey('data') && decodedResponse['data'] is Map<String, dynamic>) {
  //     //   final malumot = decodedResponse['data'];

  //     //   if (malumot.containsKey('description')) {
  //     //     log(malumot['description'].toString()); // 🛑 String sifatida olish
  //     //     data = malumot['description'].toString();
  //     //   } else {
  //     //     log("❗ `description` maydoni mavjud emas.");
  //     //   }
  //     } else {
  //       log("❗ `data` maydoni noto‘g‘ri formatda yoki mavjud emas.");
  //     }
  //   } else {
  //     log("❌ Xatolik: ${response.statusCode}");
  //     log("❌ Response body: ${response.body}");
  //   }
  // } catch (e) {
  //   log("❗ Tryga tushmadi");
  //   log("❗ Xatolik bor: $e");
  // }





  // Future<void> getDatawithImage(String imagePath) async {
  //   log("keldi");
  //   log(imagePath);
  //   isPredicting = true;
  //   notifyListeners();
  //   try {
  //     log("tryga tushdi");

  //     final uri = Uri.parse("https://api.agronomai.birnima.uz/api/predict");
  //     final response = await http.post(
  //       uri,
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $_accessToken',
  //         'Content-Type': 'application/json', // 🛑 Tokenni headerga qo‘shish
  //       },
  //       body: jsonEncode({"image_path": imagePath}),
  //     );
  //     print(response.headers);
  //     if (response.statusCode == 201) {
  //       final malumot = jsonDecode(response.body)['data'];
  //       log(malumot);
  //       log(malumot['data']['description']);
  //       data = malumot['data']['description'];
  //     } else {
  //       log(response.body);
  //     }
  //   } catch (e) {
  //     log("tryga tushmadi");
  //     log("xatolik bor $e");
  //   }

  //   isPredicting = false;
  //   notifyListeners();
  // }