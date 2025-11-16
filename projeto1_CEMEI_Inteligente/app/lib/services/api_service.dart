import 'dart:convert';
import 'package:app/utils/api_request.dart' as ApiRequest;
import '../models/class.dart';
import '../models/kid.dart';

class ApiService {
  // static const String baseUrl = 'http://172.32.0.111:80';
  
  // static String? _accessToken;

  // static void setAccessToken(String token) {
  //   _accessToken = token;
  // }

  // static Map<String, String> get _headers => {
  //       'Accept': 'application/json',
  //       'Content-Type': 'application/json',
  //       if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
  //     };

  // Buscar todas as turmas
  static Future<List<Class>> getClasses() async {

    try {
      final response = await ApiRequest.get('api/v1/classes');
      final List classesJson = response['data'];
      return classesJson.map((json) => Class.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao parsear turmas: $e');
    }
  }

  // Buscar alunos de uma turma específica
  static Future<List<Kid>> getKidsByClass(String classId) async {
    try {
      final response = await ApiRequest.get('api/v1/classes/$classId/kids');
      final List kidsJson = response['data'];
      return kidsJson.map((json) => Kid.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao parsear alunos da turma $classId: $e');
    }
  }

  // Buscar todos os alunos
  static Future<List<Kid>> getAllKids() async {
    try {
      final response = await ApiRequest.get('api/v1/kids');
      final List kidsJson = response['data'];
      return kidsJson.map((json) => Kid.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao parsear alunos: $e');
    }
  }
}
