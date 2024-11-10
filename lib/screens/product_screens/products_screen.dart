import 'package:flutter/material.dart';
import 'package:servicios_apis/models/product_Model.dart';
import 'package:servicios_apis/components/navbar.dart';
import 'package:servicios_apis/widgets/product_card.dart';
import 'package:servicios_apis/services/productsService.dart';
import 'package:servicios_apis/screens/product_screens/updateProduct_screen.dart';
import 'package:servicios_apis/components/confirmationDialog.dart';

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
  Future<void> _navigateToUpdateProduct(Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProduct(product: product),
      ),
    );
    _fetchProducts(); // Refresca la lista de productos después de la actualización
  }

  void _deleteProduct(Product product) {
  ConfirmationDialog.show(
    context,
    title: 'Confirmar eliminación',
    content: '¿Estás seguro de que deseas eliminar este producto?',
    onConfirm: () async {
      try {
        final productService = ProductService();
        final response = await productService.deleteProduct(product.id.toString());

        if (response.statusCode == 200 || response.statusCode == 204) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Producto eliminado exitosamente')),
          );
          _fetchProducts(); // Refresca la lista de productos
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar el producto: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Excepción al eliminar el producto: $e')),
        );
      }
    },
  );
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
      body: RefreshIndicator(
        onRefresh: _fetchProducts, // Este método se llama al hacer el gesto de pull-to-refresh
        child: filteredProducts.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    context: context,
                    product: filteredProducts[index],
                    onUpdate: () => _navigateToUpdateProduct(filteredProducts[index]),
                    onDelete: () => _deleteProduct(filteredProducts[index]),
                  );
                },
              ),
      ),
    );
  }
}
