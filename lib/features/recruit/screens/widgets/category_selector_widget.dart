import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key, required this.onChanged});
  final Function(String? selectedCategory) onChanged;

  @override
  CategorySelectorState createState() => CategorySelectorState();
}

class CategorySelectorState extends State<CategorySelector> {
  String? _selectedCategory;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategoryItem('Animals', 'assets/paw_2.svg'),
        _buildCategoryItem('Humanitarian', 'assets/humans.svg'),
        _buildCategoryItem('Water', 'assets/water_2.svg'),
        _buildCategoryItem('Environment', 'assets/globe.svg'),
      ],
    );
  }

  Widget _buildCategoryItem(String category, String imagePath) {
  bool isSelected = category == _selectedCategory;

  return GestureDetector(
    onTapDown: (_) {
      setState(() {
        _selectedCategory = isSelected ? null : category;
      });
      widget.onChanged(_selectedCategory);
    },
    onLongPress: () {
      setState(() {
        _selectedCategory = category;
      });
      widget.onChanged(_selectedCategory);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          AnimatedContainer(transformAlignment: Alignment.center,
            duration: const Duration(milliseconds: 200),
            transform: isSelected ? Matrix4.identity().scaled(1.2, 1.2) : Matrix4.identity(),
            child: SvgPicture.asset(
              imagePath,
              height: 30,
              width: 30,
              color: isSelected ? CupertinoColors.activeBlue : Colors.black87,
            ),
          ),
          Text(
            category,
            style: TextStyle(
              fontSize: 13,
              color: isSelected ? CupertinoColors.activeBlue : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}

}
