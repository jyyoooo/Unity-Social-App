import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'location_model.dart';

class RecruitmentPost {
  final String? id;
  final bool isApproved;
  final String title;
  final String description;
  final String category;
  final int maximumMembers;
  final DateTimeRange duration;
  final Location location;
  final List<String> badges;
  final List<String?> members;
  final Map<String, double>? donations;
  final String host;
  // final String createdAt;
  // final String updatedAt;

  RecruitmentPost(
      {this.id,
      this.isApproved = false,
      required this.title,
      required this.description,
      required this.category,
      required this.maximumMembers,
      required this.duration,
      required this.location,
      required this.badges,
      this.members = const [],
      this.donations,
      required this.host});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isApproved': isApproved,
      'title': title,
      'description': description,
      'category': category,
      'maximumMembers': maximumMembers,
      'duration': {
        'start': duration.start.millisecondsSinceEpoch,
        'end': duration.end.millisecondsSinceEpoch
      },
      'location': location.toMap(),
      'badges': badges,
      'members': members,
      'donations': donations,
      'host': host
    };
  }

  factory RecruitmentPost.fromMap(DocumentSnapshot map) {
    final membersList = map['members'] as List<dynamic>? ?? [];
    final members =
        membersList.map<String?>((member) => member as String?).toList();

    return RecruitmentPost(
      id: map.id,
      isApproved: map['isApproved'] as bool? ?? false,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      category: map['category'] as String? ?? '',
      maximumMembers: map['maximumMembers'] as int? ?? 0,
      duration: DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(map['duration']['start']),
        end: DateTime.fromMillisecondsSinceEpoch(map['duration']['end']),
      ),
      location: Location.fromMap(map['location']),
      badges: List<String>.from(map['badges'] ?? []),
      members: members,
      donations: map['donations'] as Map<String, double>? ?? {},
      host: map['host'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RecruitmentPost.fromJson(String source) =>
      RecruitmentPost.fromMap(json.decode(source));
}
