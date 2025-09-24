import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://api.devthigas.shop"));
  final storage = const FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    final response = await dio.post("/login", data: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      String token = response.data["token"];
      await storage.write(key: "token", value: token);
      return token;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getMe() async {
    String? token = await storage.read(key: "token");
    if (token == null) return null;

    try {
      final response = await dio.get("/me",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response.data;
    } catch (e) {
      return null; // token inválido ou expirado
    }
  }

  Future<void> logout() async {
    await storage.delete(key: "token");
  }
}
