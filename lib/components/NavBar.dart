import 'package:flutter/material.dart';
import 'package:servicios_apis/screens/product_screens/createProduct_screen.dart';
import 'package:servicios_apis/screens/company_screens/create_company.dart';
import 'package:servicios_apis/screens/user_screens/update_User.dart';

class Navbar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;

  const Navbar({Key? key, required this.searchController, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey[500], 
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.supervised_user_circle),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UpdateUser())
            );
          }
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none, 
                  prefixIcon: Icon(Icons.search), 
                  contentPadding: EdgeInsets.symmetric(vertical: 15), 
                ),
                onSubmitted: (_) => onSearch(),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => CreateProduct()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.store),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => CreateCompany()),
            );
          },
        ),
      ],
    );
  }
}
