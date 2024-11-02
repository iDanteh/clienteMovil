import 'package:flutter/material.dart';

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
          const Text(
            'Ecommerce',
            style: TextStyle(fontSize: 20),
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
    );
  }
}
