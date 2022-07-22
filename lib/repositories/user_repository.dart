// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max_admin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  UserRepository({
    FirebaseAuth firebaseAuth,
    Firestore firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? Firestore.instance;

  Future<User> getProfile(userId) async {
    User _currentUser = User();
    await _firestore.collection('users').document(userId).get().then((user) {
      _currentUser.uid = user['uid'];
      _currentUser.photo = user['photoUrl'];
      _currentUser.photoKtp = user['photoKtp'];
      _currentUser.photoOtherID = user['photoOtherID'];
      _currentUser.name = user['name'];
      _currentUser.location = user['location'];
      _currentUser.gender = user['gender'];
      _currentUser.dob = user['dob'];
      _currentUser.age = user['age'];
      _currentUser.nickname = user['nickname'];
      _currentUser.currentJob = user['currentJob'];
      _currentUser.jobPosition = user['jobPosition'];
      _currentUser.accountType = user['accountType'];
      _currentUser.blurAvatar = user['blurAvatar'];
    });
    return _currentUser;
  }
}
