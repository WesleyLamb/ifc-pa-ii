import 'package:app/models/kid.dart';

abstract class KidsRepositoryInterface {
  Future<Kid> index({int page = 1, int perPage = 25});
}
