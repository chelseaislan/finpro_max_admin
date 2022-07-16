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
      _currentUser.interestedIn = user['interestedIn'];
      _currentUser.dob = user['dob'];
      _currentUser.age = user['age'];
      _currentUser.nickname = user['nickname'];
      _currentUser.currentJob = user['currentJob'];
      _currentUser.jobPosition = user['jobPosition'];
      _currentUser.hobby = user['hobby'];
      _currentUser.accountType = user['accountType'];
      _currentUser.sholat = user['sholat'];
      _currentUser.sSunnah = user['sSunnah'];
      _currentUser.fasting = user['fasting'];
      _currentUser.fSunnah = user['fSunnah'];
      _currentUser.pilgrimage = user['pilgrimage'];
      _currentUser.quranLevel = user['quranLevel'];
      _currentUser.education = user['education'];
      _currentUser.marriageStatus = user['marriageStatus'];
      _currentUser.haveKids = user['haveKids'];
      _currentUser.childPreference = user['childPreference'];
      _currentUser.salaryRange = user['salaryRange'];
      _currentUser.financials = user['financials'];
      _currentUser.personality = user['personality'];
      _currentUser.pets = user['pets'];
      _currentUser.smoke = user['smoke'];
      _currentUser.tattoo = user['tattoo'];
      _currentUser.target = user['target'];
      _currentUser.marriageA = user['marriageA'];
      _currentUser.marriageB = user['marriageB'];
      _currentUser.marriageC = user['marriageC'];
      _currentUser.marriageD = user['marriageD'];
      _currentUser.taarufWith = user['taarufWith'];
      _currentUser.taarufChecklist = user['taarufCheck'];
      _currentUser.blurAvatar = user['blurAvatar'];
      _currentUser.userChosen = user['userChosen'];
      _currentUser.userSelected = user['userSelected'];
      _currentUser.userMatched = user['userMatched'];
    });
    return _currentUser;
  }
}
