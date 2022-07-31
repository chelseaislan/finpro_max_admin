import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max_admin/models/planner_detail.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PlannerRepository {
  final Firestore _firestore;

  PlannerRepository({
    FirebaseStorage firebaseStorage,
    Firestore firestore,
  }) : _firestore = firestore ?? Firestore.instance;

  // method to send a message 37/41
  Future uploadPlanner({PlannerDetail plannerDetail}) async {
    DocumentReference directoryReference =
        _firestore.collection('directories').document();

    // 1B await the photo download url for the other user
    await directoryReference.setData({
      'adminId': plannerDetail.adminId,
      'title': plannerDetail.plannerTitle,
      'desc': plannerDetail.plannerDesc,
      'website': plannerDetail.plannerWebsite,
      'phone': plannerDetail.plannerPhone,
      'mapUrl': plannerDetail.plannerMapUrl,
      'location': plannerDetail.plannerLocation,
      'province': plannerDetail.province,
    });
  }

  Stream<QuerySnapshot> getPlanners() {
    return _firestore
        .collection('directories')
        .orderBy('title', descending: false)
        .snapshots();
  }
}
