import 'package:cloud_firestore/cloud_firestore.dart';

class Informations {
  final String? id;
  final String? user_email;
  final String? user_password;
  final String? childName;
  final Timestamp? birthDate;
  final String? selectedIconPath;
  final String? Pin;

  Informations({
    this.id,
    this.user_email,
    this.user_password,
    this.childName,
    this.birthDate,
    this.selectedIconPath,
    this.Pin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_email':user_email,
      'user_password': user_password,
      'childName': childName,
      'birthDate': birthDate,
      'IconPath': selectedIconPath,
      'Pin':Pin,
    };
  }

  Informations.fromFirestore(Map<String, dynamic> firestore)
      : id = firestore['id'],
        user_email=firestore['user_email'],
        user_password = firestore['user_password'],
        childName = firestore['childName'],
        birthDate = firestore['birthDate'],
        selectedIconPath = firestore['selectedIconPath'],
        Pin = firestore['Pin'];
}
