import 'package:flutter/material.dart';
import 'package:servicios_apis/models/product_Model.dart';
import 'package:servicios_apis/screens/product_screens/updateProduct_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final VoidCallback onShop;
  final BuildContext context;

  const ProductCard({
    super.key,
    required this.product,
    required this.onUpdate,
    required this.onDelete,
    required this.onShop,
    required this.context,
  });

  @override
  Widget build( context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              height: 250,
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
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProduct(
                            product: product,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      'Editar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14, // Tamaño de texto más grande
                        fontWeight: FontWeight.bold, // Negrita para mejor legibilidad
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey, // Fondo oscuro para buen contraste
                      padding: const EdgeInsets.symmetric(vertical: 12), // Más altura
                    ),
                  ),
                ),
                const SizedBox(width: 5), // Espaciado entre botones
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      'Eliminar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent, // Color rojo para indicar acción de eliminación
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 5), // Espaciado entre botones
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onShop,
                    icon: const Icon(Icons.payment, color: Colors.white),
                    label: const Text(
                      'Comprar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 152, 216, 154), // Verde para acción positiva
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
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
