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
  final List<String>? members;
  final Map<String, double>? donations;
  final String host;

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
      this.members,
      this.donations,
      required this.host
      });

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
    return RecruitmentPost(
      id: map.id,
      isApproved: map['isApproved'] as bool,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      maximumMembers: map['maximumMembers'] as int,
      duration: DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(map['duration']['start']),
        end: DateTime.fromMillisecondsSinceEpoch(map['duration']['end']),
      ),
      location: Location.fromMap(map['location']),
      badges: List.from((map['badges'])),
      members: map['members'] ?? [],
      donations: map['donations'] ?? {},
      host: map['host']
    );
  }
}
