import 'dart:convert';
import 'package:app/utils/api_request.dart' as ApiRequest;
import '../models/class.dart';
import '../models/kid.dart';
import '../models/user.dart';

class ApiService {
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
  static Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await ApiRequest.post(
      'api/v1/auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
    return User.fromJson(response['data']);
  }
}