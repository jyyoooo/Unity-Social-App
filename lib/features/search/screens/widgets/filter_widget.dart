import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {super.key,
      required this.selectedFilter,
      required this.filters,
      this.constraints = const Size(115, 150),
      this.textColor = Colors.black});

  final String selectedFilter;
  final List<PopupMenuEntry<dynamic>> filters;
  final Size constraints;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      enableFeedback: true,
      tooltip: 'filter',
      constraints: BoxConstraints.tight(constraints),
      elevation: 1,
      splashRadius: 12,
      offset: const Offset(5, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Card(
        elevation: .8,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        child: Padding(
            padding: const EdgeInsets.all(7),
            child: Row(
              children: [
                Text(
                  selectedFilter,
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(width: 5),
                const Icon(CupertinoIcons.chevron_down,
                    size: 15, color: CupertinoColors.systemGrey)
              ],
            )),
      ),
      itemBuilder: (ctx) => filters,
    );
  }
}
