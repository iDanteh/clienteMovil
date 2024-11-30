import 'package:flutter/material.dart';
import 'package:servicios_apis/screens/user_screens/login_screen.dart';
import 'package:servicios_apis/screens/product_screens/products_screen.dart';
import 'package:servicios_apis/screens/user_screens/register_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Servicios APIs',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/products': (context) => const ProductsPage(),
        '/register': (context) => RegisterPage(),
      }
    );
  }
}