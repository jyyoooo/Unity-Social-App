import 'dart:convert';

class UserProfile {
  String? uid;
  String userName;
  String email;
  String gender;
  String profilePhoto;
  String mobile;
  List badges;
  String location;
  String token;
  UserProfile({
    this.uid,
    required this.userName,
    required this.email,
    required this.gender,
    required this.profilePhoto,
    required this.mobile,
    required this.badges,
    required this.location,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'email': email,
      'gender': gender,
      'profilePhoto': profilePhoto,
      'mobile': mobile,
      'badges': badges,
      'location': location,
      'token': token,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] != null ? map['uid'] as String : null,
      userName: map['userName'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      profilePhoto: map['profilePhoto'] as String,
      mobile: map['mobile'] as String,
      badges: List.from((map['badges'] as List)),
      location: map['location'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) => UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
