import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:servicios_apis/components/myTextField.dart';
import 'package:servicios_apis/components/myButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servicios_apis/services/usersService.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _onLoginPressed(BuildContext context) async {
    const url = "http://192.168.1.79:5000/api/v1/login";
    final body = jsonEncode({
      'email': usernameController.text,
      'password': passwordController.text
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: body
      );

      if (response.statusCode == 200){
        final responseData = json.decode(response.body);
        final token = responseData['accessToken'];
        print('Login Successful: ${responseData}');

        // Guarda el token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        print('Token: ${prefs.getString('authToken')}');

        //Navigate to Products Page
        Navigator.pushNamed(context, '/products');
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                const Icon(
                  Icons.lock,
                  size: 80,
                ),
                const SizedBox(height: 40),

                Text(
                  'Welcome again!',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 28,
                  ),
                ),

                const SizedBox(height: 25),

                // TextField Email
                MyTextfield(controller: usernameController, hintText: 'Email', obscureText: false),

                const SizedBox(height: 30),

                // TextField Password
                MyTextfield(controller: passwordController, hintText: 'Password', obscureText: true),

                const SizedBox(height: 30),

                // Login Button
                MyButton(
                  onTap: () => _onLoginPressed(context),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}