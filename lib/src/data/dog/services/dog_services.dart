import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task/src/data/dog/model/dog_model.dart';

import '../../../app/constants/api_constants.dart';

class DogServices {
  Future<DogModel?> loadDog({int? startAfter}) async {
    try {
      var response = await http.get(Uri.parse(ApiConstant.url));
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var model = DogModel.fromMap(data);
        return model;
      } else {
        throw Exception('Failed to load Image');
      }
    } catch (e) {
      print('kError 10 $e');
      return null;
    }
  }
}
