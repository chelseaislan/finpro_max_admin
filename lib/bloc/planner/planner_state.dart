// @dart=2.9
// 38/41 01

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class PlannerState extends Equatable {
  const PlannerState();

  @override
  List<Object> get props => [];
}

class PlannerInitialState extends PlannerState {}

class PlannerLoadingState extends PlannerState {}

class PlannerLoadedState extends PlannerState {
  final Stream<QuerySnapshot> plannerStream;
  const PlannerLoadedState({this.plannerStream});

  @override
  List<Object> get props => [plannerStream];
}
