import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';

class AdminScreen extends StatelessWidget {
  final AuthService authService = AuthService();

  void logout(BuildContext context) async {
    await authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Área do Administrador"),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: const Center(
        child: Text("Painel de Administração"),
      ),
    );
  }
}
