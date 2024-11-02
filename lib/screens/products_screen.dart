import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servicios_apis/models/product_Model.dart';

void onUpdateProduct(){}

void onDeleteProduct(){}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null) {
      final response = await http.get(
        Uri.parse("http://192.168.1.79:5000/api/v1/products"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);
        setState(() {
          products = productsJson.map((json) => Product.fromJson(json)).toList();
        });
      } else {
        print('Error: ${response.body}');
      }
    } else {
      print('Token no encontrado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      backgroundColor: Colors.grey[350],
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'Precio: \$${product.price}',
              style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            const SizedBox(height: 5),
            Text(
              'Stock: ${product.stock}',
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),

            const SizedBox(height: 12,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: onUpdateProduct, 
                  label: const Text("Actualizar", 
                  style: TextStyle(color: Colors.white70),), 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[600]),
                  icon: Icon(Icons.edit, color: Colors.white70,
                  ),
                  ),

                  ElevatedButton.icon(
                  onPressed: onUpdateProduct, 
                  label: const Text("Eliminar", 
                  style: TextStyle(color: Colors.white70),), 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[600]),
                  icon: Icon(Icons.edit, color: Colors.white70,
                  ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
