// @dart=2.9
import 'dart:io';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:finpro_max_admin/bloc/complete_profile/bloc.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:meta/meta.dart';

// START OF PROFILE SETUP 04 16/41 //
class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  AdminRepository _adminRepository;

  CompleteProfileBloc({@required AdminRepository adminRepository})
      : assert(adminRepository != null),
        _adminRepository = adminRepository;

  @override
  // implement initialState
  CompleteProfileState get initialState =>
      CompleteProfileState.empty(); // CompleteProfileState.empty

  @override
  Stream<CompleteProfileState> mapEventToState(
      CompleteProfileEvent event) async* {
    // implement mapEventToState
    if (event is NameAdminChanged) {
      yield* _mapNameAdmin(event.nameAdmin);
    } else if (event is PhotoAdminChanged) {
      yield* _mapPhotoAdmin(event.photoAdmin);
    } else if (event is JobPositionAdminChanged) {
      yield* _mapJobPositionAdmin(event.jobPositionAdmin);
    } else if (event is Submitted) {
      final uid = await _adminRepository.getAdmin();
      yield* _mapSubmittedToState(
        adminId: uid,
        nameAdmin: event.nameAdmin,
        photoAdmin: event.photoAdmin,
        jobPositionAdmin: event.jobPositionAdmin,
      );
    }
  }

  // create all the 6+3+9 methods
  Stream<CompleteProfileState> _mapNameAdmin(String nameAdmin) async* {
    yield state.update(isNameAdminEmpty: nameAdmin == null);
  }

  Stream<CompleteProfileState> _mapPhotoAdmin(File photoAdmin) async* {
    yield state.update(isPhotoAdminEmpty: photoAdmin == null);
  }

  Stream<CompleteProfileState> _mapJobPositionAdmin(
      String jobPositionAdmin) async* {
    yield state.update(isJobPositionAdminEmpty: jobPositionAdmin == null);
  }

  Stream<CompleteProfileState> _mapSubmittedToState({
    String adminId,
    String nameAdmin,
    File photoAdmin,
    String jobPositionAdmin,
  }) async* {
    yield CompleteProfileState.loading();
    try {
      // Profile Setup 01, urutan harus sama spt profileSetup
      await _adminRepository.adminSetup(
          adminId, nameAdmin, photoAdmin, jobPositionAdmin);
      yield CompleteProfileState.success();
    } catch (_) {
      yield CompleteProfileState.failure();
    }
  }
}
// END OF PROFILE SETUP 04 16/41 //
// STATE -> EVENT -> BLOC (GOING UP)