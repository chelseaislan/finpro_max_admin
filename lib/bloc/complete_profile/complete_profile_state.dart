// @dart=2.9
import 'package:meta/meta.dart';

// declare first
@immutable
class CompleteProfileState {
  final bool isNameAdminEmpty;
  final bool isPhotoAdminEmpty;
  final bool isJobPositionAdminEmpty;
  final bool isFailure;
  final bool isSubmitting;
  final bool isSuccess;

  // declare what makes form valid
  bool get isFormValid =>
      isNameAdminEmpty && isPhotoAdminEmpty && isJobPositionAdminEmpty;

  CompleteProfileState({
    @required this.isNameAdminEmpty,
    @required this.isPhotoAdminEmpty,
    @required this.isJobPositionAdminEmpty,
    @required this.isFailure,
    @required this.isSubmitting,
    @required this.isSuccess,
  });

  // a. initial state (empty)
  factory CompleteProfileState.empty() {
    return CompleteProfileState(
      isNameAdminEmpty: false,
      isPhotoAdminEmpty: false,
      isJobPositionAdminEmpty: false,
      isFailure: false,
      isSubmitting: false,
      isSuccess: false,
    );
  }
  // b. loading state, submitting true
  factory CompleteProfileState.loading() {
    return CompleteProfileState(
      isNameAdminEmpty: false,
      isPhotoAdminEmpty: false,
      isJobPositionAdminEmpty: false,
      isFailure: false,
      isSubmitting: true,
      isSuccess: false,
    );
  }
  // c. failure state, failure true
  factory CompleteProfileState.failure() {
    return CompleteProfileState(
      isNameAdminEmpty: false,
      isPhotoAdminEmpty: false,
      isJobPositionAdminEmpty: false,
      isFailure: true,
      isSubmitting: false,
      isSuccess: false,
    );
  }
  // d. success state, success true
  factory CompleteProfileState.success() {
    return CompleteProfileState(
      isNameAdminEmpty: false,
      isPhotoAdminEmpty: false,
      isJobPositionAdminEmpty: false,
      isFailure: false,
      isSubmitting: false,
      isSuccess: true,
    );
  }

  CompleteProfileState update({
    bool isNameAdminEmpty,
    bool isPhotoAdminEmpty,
    bool isJobPositionAdminEmpty,
  }) {
    return copyWith(
      isNameAdminEmpty: isNameAdminEmpty,
      isPhotoAdminEmpty: isPhotoAdminEmpty,
      isJobPositionAdminEmpty: isJobPositionAdminEmpty,
      isFailure: false,
      isSubmitting: false,
      isSuccess: false,
    );
  }

  // copy with nullable
  CompleteProfileState copyWith({
    bool isNameAdminEmpty,
    bool isPhotoAdminEmpty,
    bool isJobPositionAdminEmpty,
    bool isFailure,
    bool isSubmitting,
    bool isSuccess,
  }) {
    return CompleteProfileState(
      isNameAdminEmpty: isNameAdminEmpty ?? this.isNameAdminEmpty,
      isPhotoAdminEmpty: isPhotoAdminEmpty ?? this.isPhotoAdminEmpty,
      isJobPositionAdminEmpty:
          isJobPositionAdminEmpty ?? this.isJobPositionAdminEmpty,
      isFailure: isFailure ?? this.isFailure,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// END OF PROFILE SETUP 02 15/41 //