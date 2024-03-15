import 'package:flutter/material.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';

import 'badge_widget.dart';

class BadgesGridWidget extends StatelessWidget {
  const BadgesGridWidget({
    super.key,
    required this.allbadges,
    required this.passSelectedBadgeToForm,
  });
  final List<AchievementBadge>? allbadges;
  final Function(AchievementBadge, bool) passSelectedBadgeToForm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: allbadges == null
          ? const Center(child: Text('No Badges found'))
          : GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  childAspectRatio: 20 / 6.5,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                return BadgeWidget(
                  badge: allbadges![index],
                  onBadgeSelected: (badge, isSelected) {
                    return passSelectedBadgeToForm(badge, isSelected);
                  },
                );
              },
              itemCount: allbadges?.length,
            ),
    );
  }
}
