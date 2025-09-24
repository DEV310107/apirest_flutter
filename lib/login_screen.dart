import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'splash_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool loading = false;

  void doLogin() async {
    setState(() => loading = true);
    final token = await authService.login(
      emailController.text,
      passwordController.text,
    );
    setState(() => loading = false);

    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SplashScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login inválido")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : doLogin,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Entrar"),
            ),
          ],
        ),
      ),
    );
  }
}
