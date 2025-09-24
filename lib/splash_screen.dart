import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'admin_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    final user = await authService.getMe();
    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } else {
      if (user["role"] == "ADMIN") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => AdminScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
