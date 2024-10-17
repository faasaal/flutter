import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isDataMatched = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildErrorMessage(),
              const SizedBox(height: 20),
              _buildLoginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Email',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Password',
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Visibility(
      visible: !_isDataMatched,
      child: const Text(
        'Email and password do not match',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  ElevatedButton _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        checkLogin(context);
      },
      child: const Text('Login'),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final _email = _emailController.text;
    final _password = _passwordController.text;

    if (validateCredentials(_email, _password)) {
      var box = Hive.box('userBox');
      await box.put('email', _email);
      await box.put('password', _password);
     
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(builder: (context) => const ScreenHome()),
      );
    } else {
      setState(() {
        _isDataMatched = false;
      });
      const String errorMessage = 'Email and password do not match';
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(30),
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  bool validateCredentials(String email, String password) {
    const validEmail = "fasal@gmail.com";
    const validPassword = "fasal@12";

    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    return email == validEmail &&
        password == validPassword &&
        emailRegExp.hasMatch(email);
  }
}
