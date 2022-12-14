import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication_app/models/teacher.dart';
import 'package:http/http.dart' as http;
class DataService {

  final String baseUrl="https://636be6d3ad62451f9fbee1c7.mockapi.io/api/dilber/";

  Future<Teacher> teacherDownload() async {

    final http.Response response=await http.get(Uri.parse('$baseUrl/Ogretmenler/1'));

    if (response.statusCode == 200) {

      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Öğretmen indirilemedi ! Status Code:  ${response.statusCode}');
    }
  }

  Future<void> teacherAdd(Teacher teacher) async {
   final response = await  http.post(Uri.parse('$baseUrl/Ogretmenler'),
     headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
     },
     body: jsonEncode(teacher.toMap()),
   );
   if (response.statusCode == 200) {

     return;
   } else {
     throw Exception('Öğretmen kayıt edilmedi ! Status Code:  ${response.statusCode}');
   }
  }

  Future<List<Teacher>> teachersGet() async {
    final http.Response response=await http.get(Uri.parse('$baseUrl/Ogretmenler/'));

    if (response.statusCode == 200) {
      final l=jsonDecode(response.body);
      return l.map<Teacher>((e)=>Teacher.fromMap(e)).toList();
    } else {
      throw Exception('Öğretmen indirilemedi ! Status Code:  ${response.statusCode}');
    }
  }
}

final dataServiceProvider=Provider((ref) =>
DataService()
);