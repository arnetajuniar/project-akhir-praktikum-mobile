import '../service/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadListBook(String text) {
    return BaseNetwork.get("search/$text");
  }

  Future<Map<String, dynamic>> loadDetailBook(String id) {
    return BaseNetwork.get("book/$id");
  }
}
