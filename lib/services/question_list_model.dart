import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/question_list_model.dart';
import 'package:quiz_app/services/api_url.dart';

class QuestionListApiService{
  static Future<List<Questions>?> fetchQuestionListData() async {
    final uri = Uri.parse(Apis.questionListUrl);

    try {
      final response = await http.get(uri,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      final map = jsonDecode(response.body);
      print(map);
      print('${response.statusCode}');
      if (response.statusCode == 200) {
       print('${response.statusCode}');
        var a = QuestionListModel.fromJson(map);
        return a.questions;
      }
    } catch (error) {
      EasyLoading.dismiss();
      print("Error : $error");
    }
    EasyLoading.dismiss();
    Get.snackbar("Error", 'Data fetch Failed',
        backgroundColor: Colors.red.shade50,
        duration: const Duration(seconds: 2),
        overlayBlur: 3,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        colorText: Colors.red,
        snackPosition: SnackPosition.TOP);

    return null;
  }
}