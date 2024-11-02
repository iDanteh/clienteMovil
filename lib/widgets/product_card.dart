import 'package:flutter/material.dart';
import 'package:servicios_apis/models/product_Model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onUpdate,
    required this.onDelete,
  });

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
                ElevatedButton.icon(
                  onPressed: onUpdate,
                  icon: const Icon(Icons.edit, color: Colors.white70),
                  label: const Text('Actualizar', style: TextStyle(color: Colors.white70)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[600]),
                ),
                ElevatedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.white70),
                  label: const Text('Eliminar', style: TextStyle(color: Colors.white70)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
