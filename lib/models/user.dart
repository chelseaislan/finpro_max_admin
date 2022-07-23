// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

// all the details of the user model
class User {
  // 13 main
  String uid;
  String name; // v
  String gender; // s
  String photo; // v
  String photoKtp; // v
  String photoOtherID; // v
  Timestamp dob; // v
  int age; // v
  String location;
  String nickname; // v
  String currentJob; // v
  String jobPosition; // v
  String accountType; // v & s
  bool blurAvatar; // v

  User({
    this.uid,
    this.name, // only for this account's profile
    this.gender, // no need to be shown
    this.photo,
    this.photoKtp,
    this.photoOtherID,
    this.dob,
    this.age,
    this.location,
    this.nickname,
    this.currentJob,
    this.jobPosition,
    this.accountType,
    this.blurAvatar,
  });
}

class Admin {
  String uidAdmin, nameAdmin, photoAdmin, jobPositionAdmin;

  Admin(
      {this.uidAdmin, this.nameAdmin, this.photoAdmin, this.jobPositionAdmin});
}

class DropdownList {
  final List<String> provinceList = [
    "Banten",
    "Jabodetabek",
    "Jawa Barat",
    "Jawa Tengah",
    "DIY",
    "Jawa Timur",
  ];
}
