import 'package:flutter/material.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _handleLogin() {
    final email = _emailController.text;
    final name = _nameController.text;

    if (!_validateEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Format email tidak valid."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Login berhasil
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) => HomePage(
              userName: name,
              userEmail: email,
              showWelcomeMessage: true, // Kirim parameter ini
            ),
      ),
    );

    // Tampilkan notif login berhasil
    Future.delayed(Duration(milliseconds: 300), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login berhasil. Selamat datang, $name!"),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nama"),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleLogin,
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
