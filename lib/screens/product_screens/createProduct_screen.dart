import 'package:flutter/material.dart';
import 'package:servicios_apis/components/myTextField.dart';
import 'package:servicios_apis/components/myButton.dart';
import 'package:servicios_apis/components/categoryDropdown.dart';
import 'package:servicios_apis/models/product_Model.dart';
import 'package:servicios_apis/screens/product_screens/products_screen.dart';
import 'package:servicios_apis/services/productsService.dart';
import 'package:servicios_apis/components/confirmationDialog.dart';

const List<String> categories = <String>["Seleccionar","Electronica", "Hogar", "Ropa"];

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final nameProductController = TextEditingController();
  final descriptionProductController = TextEditingController();
  final priceProductController = TextEditingController();
  final stockProductController = TextEditingController();
  final imageProductController = TextEditingController();

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con valores por defecto
    nameProductController.text = '';
    descriptionProductController.text = '';
    priceProductController.text = '';
    stockProductController.text = '';
    imageProductController.text = '';
    selectedCategoryIndex = 0;
  }

Future<void> _createProduct(BuildContext context) async {
  final productService = ProductService();

  // Crear el objeto Product a partir de los datos del formulario
  final newProduct = Product(
    name: nameProductController.text,
    description: descriptionProductController.text,
    price: priceProductController.text,
    stock: int.tryParse(stockProductController.text) ?? 0,
    categoryId: selectedCategoryIndex,
    imageUrl: imageProductController.text,
  );

  try {
    // Llamar a la función para crear el producto y recibir el response
    final response = await productService.createProduct(newProduct);

    // Verificar si la creación fue exitosa con el código 201
    if (response.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductsPage()),
      );

      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto creado exitosamente')),
      );
    } else {
      // Manejar otros códigos de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear el producto: ${response.body}')),
      );
    }
  } catch (e) {
    // Mostrar un mensaje de error en caso de excepción
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Excepción al crear el producto: $e')),
    );
  }
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
                const Icon(Icons.add_shopping_cart, size: 80),
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
                    title: 'Confirmar creación',
                    content: '¿Estás seguro de que deseas crear este producto?',
                    onConfirm: () => _createProduct(context),
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
