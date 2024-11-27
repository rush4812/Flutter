import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/post_model.dart';


class ApiService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts"; // Use your actual API URL

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}