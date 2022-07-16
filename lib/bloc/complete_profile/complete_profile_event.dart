// @dart=2.9
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// START OF PROFILE SETUP 03 16/41 //
// define 33 profile events
abstract class CompleteProfileEvent extends Equatable {
  const CompleteProfileEvent();

  @override
  List<Object> get props => [];
}

class NameAdminChanged extends CompleteProfileEvent {
  final String nameAdmin;
  NameAdminChanged({@required this.nameAdmin});
  @override
  List<Object> get props => [nameAdmin];
}

class PhotoAdminChanged extends CompleteProfileEvent {
  final File photoAdmin;
  PhotoAdminChanged({@required this.photoAdmin});
  @override
  List<Object> get props => [photoAdmin];
}

class JobPositionAdminChanged extends CompleteProfileEvent {
  final String jobPositionAdmin;
  JobPositionAdminChanged({@required this.jobPositionAdmin});
  @override
  List<Object> get props => [jobPositionAdmin];
}

// declare all the 6 default + (3) additional variables + 9 lists
class Submitted extends CompleteProfileEvent {
  final String nameAdmin, jobPositionAdmin;
  final File photoAdmin;

  Submitted({
    @required this.nameAdmin,
    @required this.photoAdmin,
    @required this.jobPositionAdmin,
  });

  @override
  List<Object> get props => [nameAdmin, photoAdmin, jobPositionAdmin];
}

// END OF PROFILE SETUP 03 16/41 //