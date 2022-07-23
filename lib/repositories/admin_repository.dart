// @dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max_admin/models/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminRepository {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  AdminRepository({
    FirebaseAuth firebaseAuth,
    Firestore firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? Firestore.instance;

  // START OF AUTHENTICATION //
  // to check if the user logs in first time or not
  Future<bool> isFirstTime(String adminId) async {
    bool exist;
    await Firestore.instance
        .collection('admins')
        .document(adminId)
        .get()
        .then((admin) {
      return exist = admin.exists;
    });
    return exist;
  }

  // to log in
  Future<void> signInWithEmail(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // to sign out
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  // check if the app has a signed in admin
  Future<bool> isSignedIn() async {
    final currentAdmin = _firebaseAuth.currentUser();
    return currentAdmin != null;
  }

  Future<String> getAdmin() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<Admin> getProfile(adminId) async {
    Admin _currentAdmin = Admin();
    await _firestore.collection('admins').document(adminId).get().then((admin) {
      _currentAdmin.uidAdmin = admin['adminId'];
      _currentAdmin.nameAdmin = admin['nameAdmin'];
      _currentAdmin.photoAdmin = admin['photoUrlAdmin'];
      _currentAdmin.jobPositionAdmin = admin['jobPositionAdmin'];
    });
    return _currentAdmin;
  }

  Future<void> adminSetup(
    String adminId,
    String nameAdmin,
    File photoAdmin,
    String jobPositionAdmin,
  ) async {
    StorageUploadTask uploadPhotoAdmin;
    uploadPhotoAdmin = FirebaseStorage.instance
        .ref()
        .child('adminPhotos') // create folder userPhotos
        .child(adminId) // create folder with uid as the name
        .child('avatar_$nameAdmin') // name of the file
        .putFile(photoAdmin);

// use Array Profile
    return await uploadPhotoAdmin.onComplete.then((ref) async {
      await ref.ref.getDownloadURL().then((url) async {
        await _firestore.collection('admins').document(adminId).setData({
          'adminId': adminId,
          'nameAdmin': nameAdmin,
          'photoUrlAdmin': url,
          'jobPositionAdmin': jobPositionAdmin,
        });
      });
    });
  }
}
