import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/elec_model.dart';

class ApiService {
  static const String apiUrl = 'https://fakestoreapi.in/api/products'; // Replace with actual API URL

  Future<ResponseModel> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ResponseModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load products');
    }
    }
}
