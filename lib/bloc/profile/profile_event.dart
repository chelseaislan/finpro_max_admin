// @dart=2.9

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class ProfileLoadedEvent extends ProfileEvent {
  final String adminId;
  ProfileLoadedEvent({this.adminId});
  @override
  List<Object> get props => [adminId];
}
