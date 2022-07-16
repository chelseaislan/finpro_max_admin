// @dart=2.9
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String adminId;
  Authenticated({this.adminId});

  @override
  List<Object> get props => [adminId];

  @override
  String toString() => "Authenticated {adminId}";
}

class AuthenticatedButNotSet extends AuthenticationState {
  final String adminId;
  AuthenticatedButNotSet({this.adminId});

  @override
  List<Object> get props => [adminId];
}

class Unauthenticated extends AuthenticationState {}
