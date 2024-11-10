import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servicios_apis/models/product_Model.dart';
import 'package:servicios_apis/utils/url.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null) {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/products'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.body}');
      }
    } else {
      throw Exception('Token not found');
    }
  }

  Future<void> updateProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null) {
      final response = await http.put(
        Uri.parse('${Constants.baseUrl}/products/${product.id}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'stock': product.stock,
        'category_id': product.categoryId,
        'image_url': product.imageUrl,
      }),
      );

      if (response.statusCode != 200) {
        print('Error al actualizar el producto: ${response.body}');
        throw Exception('Failed to update product: ${response.body}');
      }
    } else {
      throw Exception('Token not found');
    }
  }

  Future<void> deleteProduct(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null) {
      final response = await http.delete(
        Uri.parse('${Constants.baseUrl}/products/$productId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product: ${response.body}');
      }
    } else {
      throw Exception('Token not found');
    }
  }
}
