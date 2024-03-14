import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategorySelector extends StatefulWidget {
  CategorySelector({super.key, required this.onChanged});
  Function(String? selectedCategory) onChanged;

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String? _selectedCategory;

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
      onTap: () {
        setState(() {
          _selectedCategory = isSelected ? null : category;
        });
        widget.onChanged(_selectedCategory);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            SvgPicture.asset(imagePath,
                height: 30,
                width: 30,
                color: isSelected ? CupertinoColors.activeBlue : Colors.black87),
            Text(
              category,
              style: TextStyle(
                  fontSize: 13,
                  color:
                      isSelected ? CupertinoColors.activeBlue : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
