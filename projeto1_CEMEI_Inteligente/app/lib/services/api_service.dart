import 'package:app/models/class_summary.dart';
import 'package:app/models/kid_summary.dart';
import 'package:app/utils/api_request.dart' as ApiRequest;
import '../models/class.dart';
import '../models/kid.dart';
import '../models/user.dart';

class ApiService {
  // Buscar todas as turmas
  static Future<List<ClassSummary>> getAllClasses({int perPage = 10}) async {
    try {
      final response = await ApiRequest.get('api/v1/classes?per_page=$perPage');

      if (response == null || response['data'] == null) {
        return [];
      }

      final List classesJson = response['data'];
      final classes = <ClassSummary>[];

      for (var json in classesJson) {
        try {
          classes.add(ClassSummary.fromJson(json as Map<String, dynamic>));
        } catch (e) {
          print('⚠️ Erro ao parsear turma: $json - $e');
          continue;
        }
      }

      return classes;
    } catch (e) {
      throw Exception('Erro ao buscar turmas: $e');
    }
  }

  static Future<Class> getClassById(String classId) async {
    try {
      final response = await ApiRequest.get('api/v1/classes/$classId');

      if (response == null || response['data'] == null) {
        throw Exception('Turma não encontrada');
      }

      final classJson = response['data'] as Map<String, dynamic>;
      return Class.fromJson(classJson);
    } catch (e) {
      throw Exception('Erro ao buscar turma: $e');
    }
  }

  // Buscar alunos de uma turma específica
  static Future<List<KidSummary>> getKidsByClass(String classId) async {
    try {
      final response = await ApiRequest.get('api/v1/classes/$classId/kids');
      final List kidsJson = response['data'];
      return kidsJson.map((json) => KidSummary.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Erro ao parsear alunos da turma $classId: $e');
    }
  }

  // Buscar todos os alunos
  static Future<List<KidSummary>> getAllKids() async {
    try {
      final response = await ApiRequest.get('api/v1/kids');

      // Verifica se a resposta tem dados
      if (response == null || response['data'] == null) {
        return [];
      }

      final List kidsJson = response['data'];

      // Filtra e mapeia, ignorando registros com erro
      final kids = <KidSummary>[];
      for (var json in kidsJson) {
        try {
          kids.add(KidSummary.fromJson(json as Map<String, dynamic>));
        } catch (e) {
          print('⚠️ Erro ao parsear criança: $json - $e');
          // Continua processando os próximos registros
          continue;
        }
      }

      return kids;
    } catch (e) {
      throw Exception('Erro ao buscar alunos: $e');
    }
  }

  // Buscar criança por ID
  static Future<Kid> getKidById(String kidId) async {
    try {
      final response = await ApiRequest.get('api/v1/kids/$kidId');

      if (response == null || response['data'] == null) {
        throw Exception('Criança não encontrada');
      }

      final kidJson = response['data'] as Map<String, dynamic>;
      return Kid.fromJson(kidJson);
    } catch (e) {
      throw Exception('Erro ao buscar criança: $e');
    }
  }

  // Registro de usuário
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

  static Future<List<Kid>> searchKids(String query) async {
    try {
      final response = await ApiRequest.get('api/v1/kids?q=$query');

      if (response == null || response['data'] == null) {
        return [];
      }

      final List kidsJson = response['data'];
      final allResults = <Kid>[];

      for (var json in kidsJson) {
        try {
          allResults.add(Kid.fromJson(json as Map<String, dynamic>));
        } catch (e) {
          continue;
        }
      }

      // Filtrar localmente como fallback
      final queryLower = query.toLowerCase().trim();
      final filtered = allResults.where((kid) {
        final nameLower = kid.name.toLowerCase();
        final cpfLower = kid.cpf.toLowerCase();
        final libraryIdLower = kid.libraryIdentifier.toLowerCase();

        return nameLower.contains(queryLower) ||
            cpfLower.contains(queryLower) ||
            libraryIdLower.contains(queryLower);
      }).toList();

      return filtered;
    } catch (e) {
      throw Exception('Erro ao buscar crianças: $e');
    }
  }

  // Update Kid
  static Future<Kid> updateKid(String kidId, Map<String, dynamic> data) async {
    try {
      final response = await ApiRequest.put('api/v1/kids/$kidId', data: data);
      if (response == null || response['data'] == null) {
        throw Exception('Falha ao atualizar criança');
      }
      final kidJson = response['data'] as Map<String, dynamic>;
      return Kid.fromJson(kidJson);
    } catch (e) {
      throw Exception('Erro ao atualizar criança: $e');
    }
  }
}
