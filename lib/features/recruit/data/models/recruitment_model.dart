import 'package:flutter/material.dart';
import 'package:flutter_location_search/flutter_location_search.dart';

class RecruitmentModel {
  final String title;
  final String description;
  final String category;
  final DateTimeRange duration;
  final LocationData location;
  final int maximumMembers;

  RecruitmentModel(this.maximumMembers, 
      {required this.title,
      required this.description,
      required this.category,
      required this.duration,
      required this.location});
}
