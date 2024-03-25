import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  FilterButton(
      {super.key,
      required this.selectedFilter,
      required this.filters,
      this.constraints = const Size(115, 150)});

  final String selectedFilter;
  List<PopupMenuEntry<dynamic>> filters;
  Size constraints;

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
                Text(selectedFilter),
                const SizedBox(width: 5),
                const Icon(CupertinoIcons.chevron_down,
                    size: 15, color: Colors.grey)
              ],
            )),
      ),
      itemBuilder: (ctx) => filters,
    );
  }
}
