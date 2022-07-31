// @dart=2.9
// 32/41 01

import 'package:meta/meta.dart';

class PlannerDetail {
  String adminId,
      plannerTitle,
      plannerDesc,
      plannerWebsite,
      plannerPhone,
      plannerMapUrl,
      plannerLocation,
      province;
  PlannerDetail({
    @required this.adminId,
    @required this.plannerTitle,
    @required this.plannerDesc,
    @required this.plannerWebsite,
    @required this.plannerPhone,
    @required this.plannerMapUrl,
    @required this.plannerLocation,
    @required this.province,
  });
}
