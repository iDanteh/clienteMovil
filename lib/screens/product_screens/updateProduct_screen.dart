import 'package:flutter/material.dart';
import 'package:servicios_apis/components/myTextField.dart';
import 'package:servicios_apis/components/myButton.dart';
import 'package:servicios_apis/models/product_Model.dart';
import 'package:servicios_apis/services/productsService.dart';
import 'package:servicios_apis/components/confirmationDialog.dart';
import 'package:servicios_apis/components/categoryDropdown.dart';

const List<String> categories = <String>["Seleccionar","Electronica", "Hogar", "Ropa"];

class UpdateProduct extends StatefulWidget {
  final Product product;

  UpdateProduct({super.key, required this.product});

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final nameProductController = TextEditingController();
  final descriptionProductController = TextEditingController();
  final priceProductController = TextEditingController();
  final stockProductController = TextEditingController();
  final imageProductController = TextEditingController();

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los valores actuales del producto
    nameProductController.text = widget.product.name;
    descriptionProductController.text = widget.product.description;
    priceProductController.text = widget.product.price;
    stockProductController.text = widget.product.stock.toString();
    imageProductController.text = widget.product.imageUrl;
    selectedCategoryIndex = widget.product.categoryId;
  }

  Future<void> _updateProduct(BuildContext context) async {
    final updatedProduct = Product(
      id: widget.product.id,
      name: nameProductController.text,
      description: descriptionProductController.text,
      price: priceProductController.text,
      stock: int.parse(stockProductController.text),
      categoryId: selectedCategoryIndex,
      imageUrl: imageProductController.text,
    );

    final productService = ProductService();
    await productService.updateProduct(updatedProduct);
    Navigator.pop(context); // Cierra la vista de actualización
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
                const Icon(Icons.edit, size: 80),
                const SizedBox(height: 20),
                MyTextfield(
                  controller: nameProductController,
                  hintText: 'Nombre del Producto',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextfield(
                  controller: descriptionProductController,
                  hintText: 'Descripción',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextfield(
                  controller: priceProductController,
                  hintText: 'Precio',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextfield(
                  controller: stockProductController,
                  hintText: 'Stock',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextfield(
                  controller: imageProductController,
                  hintText: 'URL de la Imagen',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                const Text("Categoría"),
                CategoryDropdown(
                  initialIndex: selectedCategoryIndex,
                  onSelected: (index) {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 20),
                MyButton(
                  onTap: () => ConfirmationDialog.show(
                    context,
                    title: 'Confirmar actualización',
                    content: '¿Estás seguro de que deseas actualizar este producto?',
                    onConfirm: () => _updateProduct(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
