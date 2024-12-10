import 'package:flutter/material.dart';
import 'package:servicios_apis/components/myTextField.dart';
import 'package:servicios_apis/components/myButton.dart';
import 'package:servicios_apis/services/usersService.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await AuthService.getUserData();
    if (userData != null) {
      nameController.text = userData['name'];
      emailController.text = userData['email'];
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _updateUser() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    final success = await AuthService.updateUser(name, email, password);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User updated successfully!')),
      );
      Navigator.pop(context); // Regresamos a la pantalla anterior
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(title: const Text('Update User')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.person,
                      size: 80,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Update your details',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // TextField Name
                    MyTextfield(controller: nameController, hintText: 'Full Name', obscureText: false),

                    const SizedBox(height: 25),

                    // TextField Email
                    MyTextfield(controller: emailController, hintText: 'Email', obscureText: false),

                    const SizedBox(height: 25),

                    // TextField Password
                    MyTextfield(controller: passwordController, hintText: 'Password', obscureText: true),

                    const SizedBox(height: 30),

                    // Update Button
                    MyButton(
                      onTap: () => _updateUser(),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
