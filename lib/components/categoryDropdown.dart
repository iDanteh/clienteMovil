import 'package:flutter/material.dart';

const List<String> categories = <String>["Seleccionar","Electronica", "Hogar", "Ropa"];

class CategoryDropdown extends StatefulWidget {
  final int initialIndex;
  final Function(int) onSelected;

  const CategoryDropdown({
    Key? key,
    required this.initialIndex,
    required this.onSelected,
  }) : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late int selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedCategoryIndex,
      onChanged: (int? newIndex) {
        if (newIndex != null) {
          setState(() {
            selectedCategoryIndex = newIndex;
          });
          widget.onSelected(selectedCategoryIndex); // Notify the parent widget about the selection
        }
      },
      items: List<DropdownMenuItem<int>>.generate(
        categories.length,
        (index) => DropdownMenuItem<int>(
          value: index,  // Make sure this value corresponds to the selected index
          child: Text(categories[index]),
        ),
      ),
    );
  }
}
