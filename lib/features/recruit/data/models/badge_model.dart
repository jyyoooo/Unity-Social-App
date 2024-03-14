// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AchievementBadge {
  final String? id;
  final IconData icon;
  final String title;
  final String description;
  AchievementBadge({
    this.id,
    required this.icon,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'icon': icon.codePoint,
      'title': title,
      'description': description,
    };
  }

  factory AchievementBadge.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AchievementBadge(
      id: snapshot.id,
      icon: IconData(data['icon'] as int, fontFamily: 'MaterialIcons'),
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
