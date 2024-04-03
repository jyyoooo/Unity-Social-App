import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';

class BadgeWidget extends StatefulWidget {
  const BadgeWidget(
      {super.key, required this.badge, required this.onBadgeSelected});
  final AchievementBadge badge;
  final Function(AchievementBadge, bool) onBadgeSelected;

  @override
  State<BadgeWidget> createState() => _BadgeWidgetState();
}

class _BadgeWidgetState extends State<BadgeWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          setState(() {
            isSelected ? isSelected = false : isSelected = true;
            widget.onBadgeSelected(widget.badge, isSelected);
          });
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  maxRadius: 20,
                  child: isSelected
                      ? const Icon(Icons.check,
                          color: CupertinoColors.activeBlue)
                      : Icon(widget.badge.icon, size: 22)),
            ),
            const SizedBox(width: 4),
            Text(widget.badge.title,
                style: TextStyle(
                    color:
                        isSelected ? CupertinoColors.activeBlue : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
