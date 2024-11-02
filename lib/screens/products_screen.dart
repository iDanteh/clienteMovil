import 'package:flutter/material.dart';
import 'package:servicios_apis/models/product_Model.dart';
import 'package:servicios_apis/components/navbar.dart';
import 'package:servicios_apis/widgets/product_card.dart';
import 'package:servicios_apis/services/productsService.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final productService = ProductService();
    products = await productService.fetchProducts();
    filteredProducts = products; // Inicialmente, los productos filtrados son todos
    setState(() {});
  }

  void _searchProducts(String query) {
    final results = products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredProducts = results;
    });
  }

  // Métodos para manejar la actualización y eliminación de productos
  void _updateProduct(Product product) {
    // Lógica para actualizar el producto
  }

  void _deleteProduct(Product product) {
    // Lógica para eliminar el producto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Altura del AppBar
        child: Navbar(
          searchController: searchController,
          onSearch: () => _searchProducts(searchController.text),
        ),
      ),
      backgroundColor: Colors.grey[350],
      body: filteredProducts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: filteredProducts[index],
                  onUpdate: () => _updateProduct(filteredProducts[index]), // Proporciona el onUpdate
                  onDelete: () => _deleteProduct(filteredProducts[index]), // Proporciona el onDelete
                );
              },
            ),
    );
  }
}