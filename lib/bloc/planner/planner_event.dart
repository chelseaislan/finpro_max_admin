// @dart=2.9
// 38/41 02

import 'package:equatable/equatable.dart';
import 'package:finpro_max_admin/models/planner_detail.dart';

abstract class PlannerEvent extends Equatable {
  const PlannerEvent();

  @override
  List<Object> get props => [];
}

class UploadPlannerEvent extends PlannerEvent {
  final PlannerDetail plannerDetail;

  const UploadPlannerEvent({this.plannerDetail});

  @override
  List<Object> get props => [plannerDetail];
}

class PlannerStreamEvent extends PlannerEvent {
  // final String adminId;
  // const PlannerStreamEvent({this.adminId});

  @override
  List<Object> get props => [];
}
