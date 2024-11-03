import 'package:cloud_firestore/cloud_firestore.dart';
import 'informations.dart';

class InformationsService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveInformations(String userId, Informations informations) {
    return _db
        .collection('informations')
        .doc(userId)
        .set(informations.toMap());
  }

  Stream<List<Informations>> getInformations() {
    return _db.collection('informations').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Informations.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeInformations(String userId) {
    return _db.collection('informations').doc(userId).delete();
  }

  Future<void> updateInformations(String userId, Informations informations) {
    return _db
        .collection('informations')
        .doc(userId)
        .update(informations.toMap());
  }
}
