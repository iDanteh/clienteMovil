import 'package:flutter/material.dart';
import 'package:servicios_apis/components/myTextField.dart';
import 'package:servicios_apis/components/myButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final role = "user";

  void _onRegisterPressed(BuildContext context) async {
    const url = "http://192.168.1.79:5000/api/v1/register";
    final body = jsonEncode({
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'role': role
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body
      );

      if (response.statusCode == 200){
        final responseData = json.decode(response.body);
        print('Register Successful: ${responseData}');

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
        child: SingleChildScrollView( // Agrega el SingleChildScrollView aquí
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Icon(
                  Icons.person_add,
                  size: 80,
                ),
                const SizedBox(height: 30),
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 25),

                MyTextfield(controller: nameController, hintText: 'Nombre de usuario', obscureText: false),

                const SizedBox(height: 25),

                MyTextfield(controller: emailController, hintText: 'Email', obscureText: false),

                const SizedBox(height: 25),

                MyTextfield(controller: passwordController, hintText: 'Contraseña', obscureText: true),

                const SizedBox(height: 25),

                MyButton(onTap: () => _onRegisterPressed(context)),

                const SizedBox(height: 30), // Añadir un espacio adicional al final
              ],
            ),
          ),
        ),
      ),
    );
  }
}