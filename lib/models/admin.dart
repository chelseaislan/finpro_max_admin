// @dart=2.9

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
  final List<String> titles = [
    "Registered Users",
    "Verified Male Users",
    "Verified Female Users",
    "Users Married using MM",
  ];
}
