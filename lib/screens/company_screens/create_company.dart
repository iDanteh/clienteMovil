import 'package:flutter/material.dart';
import 'package:servicios_apis/services/companyService.dart';
import 'package:servicios_apis/components/confirmationDialog.dart';
import 'package:servicios_apis/models/company_Model.dart';
import 'package:servicios_apis/components/myTextField.dart';
import 'package:servicios_apis/components/myButton.dart';
import 'package:servicios_apis/screens/product_screens/products_screen.dart';

class CreateCompany extends StatefulWidget {
  const CreateCompany({super.key});

  @override
  State<CreateCompany> createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  final nameCompanyController = TextEditingController();
  final descriptionCompanyController = TextEditingController();
  final addressCompanyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameCompanyController.text = '';
    descriptionCompanyController.text = '';
    addressCompanyController.text = '';
  }

  Future<void> _createCompany(BuildContext context) async {
    final companyService = CompanyService();

    final newCompany = Company(
      company_name: nameCompanyController.text, 
      company_description: descriptionCompanyController.text, 
      address: addressCompanyController.text
      );
      try {
    // Llamar a la función para crear el producto y recibir el response
    final response = await companyService.createCompany(newCompany);

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
                const Icon(Icons.store, size: 80,),
                const SizedBox(height: 20,),
                MyTextfield(
                  controller: nameCompanyController, 
                  hintText: 'Nombre de la empresa', 
                  obscureText: false
                  ),
                  const SizedBox(height: 20,),
                  MyTextfield(
                  controller: descriptionCompanyController, 
                  hintText: 'Descipción de la empresa', 
                  obscureText: false
                  ),
                  const SizedBox(height: 20,),
                  MyTextfield(
                  controller: addressCompanyController, 
                  hintText: 'Dirección completa de la empresa', 
                  obscureText: false
                  ),
                  const SizedBox(height: 20,),
                  MyButton(
                  onTap: () => ConfirmationDialog.show(
                    context,
                    title: 'Confirmar creación',
                    content: '¿Estás seguro de que deseas crear la compañía?',
                    onConfirm: () => _createCompany(context),
                  ),
                ),
              ],
            ),
          ),
        ))
    );
  }
}