import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Informations_service.dart';
import 'informations.dart';

class InformationsProvider with ChangeNotifier {
  final firestoreService = InformationsService();
  String? _id;
  String? _user_email;
  String? _user_password;
  String? _childName;
  Timestamp? _birthDate;
  String? _selectedIconPath;
  String? _Pin;

  String? get id => _id;

  String? get user_email => _user_email;

  String? get user_password => _user_password;

  String? get childName => _childName;

  Timestamp? get birthDate => _birthDate;

  String? get selectedIconPath => _selectedIconPath;

  String? get Pin => _Pin;

  changeuser_email(String value) {
    _user_email = value;
    notifyListeners();
  }

  changeCocukYasi(Timestamp value) {
    _birthDate = value;
    notifyListeners();
  }

  changePassword(String value) {
    _user_password = value;
    notifyListeners();
  }

  changechildName(String value) {
    _childName = value;
    notifyListeners();
  }

  changeselectedIconPath(String value) {
    _selectedIconPath = value;
    notifyListeners();
  }

  changePin(String value) {
    _Pin = value;
    notifyListeners();
  }

  loadValues(Informations informations) {
    _id = informations.id;
    _user_email=informations.user_email;
    _user_password = informations.user_password;
    _childName = informations.childName;
    _birthDate = informations.birthDate;
    _selectedIconPath = informations.selectedIconPath;
    _Pin = informations.Pin;
  }

  void updateUserInformation(Informations updatedInformations) {
    if (updatedInformations.id == null) {
      throw Exception("ID eksik. ID ile güncelleme yapılamaz.");
    }

    firestoreService
        .updateInformations(updatedInformations.id!, updatedInformations)
        .then((_) {
      print("Bilgiler başarıyla güncellendi.");
    }).catchError((e) {
      print("Güncellenirken hata oluştu: $e");
    });
  }

  void saveInformations() {
    String userId = FirebaseAuth
        .instance.currentUser!.uid; // Oturum açmış kullanıcının ID'sini al

    var newInformations = Informations(
      id: userId,
      // Kullanıcı ID'sini belge ID olarak kullan
      user_email:_user_email,
      user_password: _user_password,
      childName: _childName,
      birthDate: _birthDate,
      selectedIconPath: _selectedIconPath,
      Pin: _Pin,
    );

    firestoreService.saveInformations(userId, newInformations).then((_) {
      print("Bilgiler başarıyla kaydedildi.");
    }).catchError((e) {
      print("Kaydedilirken hata oluştu: $e");
    });
  }
}
