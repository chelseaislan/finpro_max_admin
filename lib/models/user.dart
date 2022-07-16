// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// all the details of the user model
class User {
  // 13 main
  String uid;
  String name; // only for this account's profile
  String gender; // no need to be shown
  String interestedIn; // no need to be shown
  String photo;
  String photoKtp;
  String photoOtherID;
  Timestamp dob;
  int age;
  String location;
  String nickname;
  String currentJob;
  String jobPosition;
  String hobby;
  // 6 religion
  String sholat;
  String sSunnah;
  String fasting;
  String fSunnah;
  String pilgrimage;
  String quranLevel;
  // 6 status
  String education;
  String marriageStatus;
  String haveKids;
  String childPreference;
  String salaryRange;
  String financials;
  // 5 personal
  String personality;
  String pets;
  String smoke;
  String tattoo;
  String target;
  // 4 marriage checklist dates
  Timestamp marriageA; // Parents 1
  Timestamp marriageB; // Parents 2
  Timestamp marriageC; // lamaran
  Timestamp marriageD; // acara pernikahan
  // others
  String accountType;
  String taarufWith;
  int taarufChecklist;
  bool blurAvatar;
  List<dynamic> userChosen; // for search page
  String userSelected; // for search nickname, prev list dynamic
  String userMatched; // backup

  User({
    // 34 props - 13 main 1 uid
    this.uid,
    this.name, // only for this account's profile
    this.gender, // no need to be shown
    this.interestedIn, // no need to be shown
    this.photo,
    this.photoKtp,
    this.photoOtherID,
    this.dob,
    this.age,
    this.location,
    this.nickname,
    this.currentJob,
    this.jobPosition,
    this.hobby,
    // 6 religion
    this.sholat,
    this.sSunnah, //
    this.fasting,
    this.fSunnah, //
    this.pilgrimage,
    this.quranLevel,
    // 6 details
    this.education,
    this.marriageStatus, //
    this.haveKids, //
    this.childPreference,
    this.salaryRange, //
    this.financials,
    // 4 personal
    this.personality, //
    this.pets, //
    this.smoke, //
    this.tattoo, //
    // 4 marriage checklists
    this.marriageA,
    this.marriageB,
    this.marriageC,
    this.marriageD,
    // others
    this.accountType,
    this.taarufWith,
    this.taarufChecklist,
    this.blurAvatar,
    this.userChosen,
    this.userSelected,
    this.userMatched,
  });
}

// Move the 9 lists to user model

class DropdownList {
  final List sholatList = [
    "➊ 5 times, punctual",
    "➋ 5 times, random hours",
    "➌ Sometimes skips",
    "➍ Mostly skips",
    "➎ Never",
  ];

  final List sSunnahList = [
    "➊ Always",
    "➋ Sometimes",
    "➌ Rarely",
    "➍ Never",
  ];

  final List fastingList = [
    "➊ Completed without skips",
    "➋ Completed, rare skips",
    "➌ Completed, occasional skips",
    "➍ Never",
  ];

  final List fSunnahList = [
    "➊ Always",
    "➋ Sometimes",
    "➌ Rarely",
    "➍ Never",
  ];

  final List pilgrimageList = [
    "➊ Hajj & Umroh, many times",
    "➋ Hajj & Umroh, one time",
    "➌ Hajj only",
    "➍ Umroh only",
    "➎ Planned to do one of those",
    "➏ Never",
  ];

  final List quranLevelList = [
    "➊ Iqra 1-3",
    "➋ Iqra 4-6",
    "➌ Early Learner",
    "➍ Intermediate",
    "➎ Hafidz",
  ];

  // Part 2

  final List eduList = [
    "➊ SD",
    "➋ SMP",
    "➌ SMA",
    "➍ Diploma",
    "➎ S1",
    "➏ S2/S3",
  ];

  final List marriageStatusList = [
    //
    "➊ Single",
    "➋ Married with 1 partner",
    "➌ Married with 2 or 3 partners",
    "➍ Widowed",
  ];

  final List haveKidsList = [
    //
    "➊ Yes, more than 2",
    "➋ Yes, 1 or 2",
    "➌ No",
  ];

  final List childPrefList = [
    "➊ 1 or 2 kids",
    "➋ 3 or 4 kids",
    "➌ More than 4 kids",
    "➍ 0 kids",
  ];

  final List salaryRangeList = [
    "➊ Below Rp 3 mio.",
    "➋ Rp 3-6 mio.",
    "➌ Rp 6-10 mio.",
    "➍ Rp 10-15 mio.",
    "➎ Rp 15-20 mio.",
    "➏ Rp 20-30 mio.",
    "➐ Rp 30-50 mio.",
    "➑ Above Rp 50 mio.",
  ];

  final List financialsList = [
    "➊ High-risk debts",
    "➋ Medium-risk debts",
    "➌ Low-risk debts",
    "➍ I've repaid all my debts",
  ];

  final List personalityList = [
    "➊ Extroverted",
    "➋ In the middle",
    "➌ Introverted",
  ];

  final List petsList = [
    "➊ Cats, dogs, or rabbits",
    "➋ Chirping love birds",
    "➌ Chickens",
    "➍ Reptiles",
    "➎ No",
  ];

  final List smokeList = [
    "➊ Regular cigarettes",
    "➋ Vape",
    "➌ No",
  ];

  final List tattooList = [
    "➊ Yes",
    "➋ No",
  ];

  final List targetList = [
    "➊ 2 weeks from now",
    "➋ 1 month from now",
    "➌ 2 months from now",
    "➍ 3 months from now",
  ];

  // headers & hints

  final List ddHeadersA = [
    "How punctual are you in doing prayers?",
    "Do you perform sunnah prayer?",
    "Do you completed your fasting last Ramadan?",
    "Do you perform sunnah fasting?",
    "Have you done pilgrimages?",
    "How proficient are you in reading Quran?",
  ];

  final List ddHintsA = [
    "Prayers List",
    "Sunnah Prayers List",
    "Fasting List",
    "Sunnah Fasting List",
    "Pilgrimage List",
    "Quran Reading Level",
  ];

  final List ddIconsA = [
    const Icon(Icons.star_border_outlined),
    const Icon(Icons.star_border_outlined),
    const Icon(Icons.food_bank_outlined),
    const Icon(Icons.food_bank_outlined),
    const Icon(Icons.airplane_ticket_outlined),
    const Icon(Icons.bookmark_added_outlined),
  ];

  final List ddHeadersB = [
    "Choose your latest education:",
    "What is your current marriage status?",
    "Do you already have kids? (Biological or adopted kids)",
    "How many kids do you want after marriage?",
    "How much is your monthly salary during your current job?",
    "Are you currently in debt?",
  ];

  final List ddHintsB = [
    "Latest Education",
    "Marriage Status",
    "Number of Kids",
    "Children Preference",
    "Salary Range",
    "Debt Status",
  ];

  final List ddIconsB = [
    const Icon(Icons.school_outlined),
    const Icon(Icons.star_border_outlined),
    const Icon(Icons.child_friendly_outlined),
    const Icon(Icons.child_friendly_outlined),
    const Icon(Icons.onetwothree_outlined),
    const Icon(Icons.credit_score_outlined),
  ];

  final List ddHeadersC = [
    "What kind of person are you?",
    "Are you into pets?",
    "Do you smoke?",
    "Do you have your body tattoed?",
    "When is the target of your future marriage?",
  ];

  final List ddHintsC = [
    "Personality Type",
    "Pets List",
    "Smoker or Not",
    "Tattoed or Not",
    "Marriage Target",
  ];

  final List ddIconsC = [
    const Icon(Icons.person_outlined),
    const Icon(Icons.pets_outlined),
    const Icon(Icons.smoking_rooms_outlined),
    const Icon(Icons.bolt_outlined),
    const Icon(Icons.punch_clock_outlined),
  ];

  final List completeHeaders = [
    "Full Legal Name",
    "Nickname",
    "Date of Birth",
    "Gender",
    "Current Company",
    "Job Position",
    "Current Location",
    "Hobby",
    "Prayer Punctuality",
    "Sunnah Prayer Status",
    "Ramadan Fasting Status",
    "Sunnah Fasting Status",
    "Pilgrimage Status",
    "Quran Proficiency",
    "Latest Education",
    "Marriage Status",
    "Number of Previous Kids",
    "Children Preference",
    "Salary Range",
    "Debt Ratio",
    "Personality Type",
    "Pets Status",
    "Smoking Status",
    "Tattoo Status",
    "Marriage Target",
  ];

  final List selectedUserHeaders = [
    "Nickname",
    "Gender",
    "Current Company",
    "Job Position",
    "Current Location",
    "Hobby",
    "Prayer Punctuality",
    "Sunnah Prayer Status",
    "Ramadan Fasting Status",
    "Sunnah Fasting Status",
    "Pilgrimage Status",
    "Quran Proficiency",
    "Latest Education",
    "Marriage Status",
    "Number of Previous Kids",
    "Children Preference",
    "Salary Range",
    "Debt Ratio",
    "Personality Type",
    "Pets Status",
    "Smoking Status",
    "Tattoo Status",
    "Marriage Target",
  ];
}

class Admin {
  String uidAdmin, nameAdmin, photoAdmin, jobPositionAdmin;

  Admin(
      {this.uidAdmin, this.nameAdmin, this.photoAdmin, this.jobPositionAdmin});
}
