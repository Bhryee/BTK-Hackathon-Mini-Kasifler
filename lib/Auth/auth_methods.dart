import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Complementes/childAge_Field.dart';
import '../Complementes/childName_Field.dart';
import '../Screen/sign_in_screen.dart';
import '../executive/data/informations.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;

  FlutterFireAuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  // Kullanıcı hesabı oluşturma
  Future<User?> createAccount(String email, String password) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user;

      print("Kullanıcı başarıyla oluşturuldu");
      if (user != null) {
        // User belgesini oluşturuyoruz
        await _firestore.collection('users').doc(user.uid).set({
          "user_id": user.uid,
          "user_email": email,
          "user_password": password,
        });

        // Informations belgesini user_id ile oluşturuyoruz
        await _firestore.collection('informations').doc(user.uid).set({
          'id': user.uid,
          "user_email": email,
          "user_password": password,
          'childName': childname,
          'birthDate': birthDate,
          'selectedIconPath': IconPath,
          'Pin':"",
        });
        print("Informations belgesi oluşturuldu");

        return user;
      } else {
        return null;
      }
    }on FirebaseAuthException catch (e) {
      // FirebaseAuth ile ilgili hataları yakalıyoruz
      throw e; // Hatanın daha yukarıda yönetilmesi için tekrar fırlatıyoruz
    } catch (e) {
      throw Exception("Kullanıcı oluşturma hatası: $e");
    }
  }

  // Kullanıcıya özel bilgileri getirme
  Future<Informations?> getUserInformation() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String? userId = _firebaseAuth.currentUser?.uid;

    if (userId != null) {
      DocumentSnapshot doc =
      await _firestore.collection('informations').doc(userId).get();
      if (doc.exists) {
        return Informations.fromFirestore(doc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  // Kullanıcı bilgilerini güncelleme
  Future<void> updateUserInformation(Informations informations) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String? userId = _firebaseAuth.currentUser?.uid;

    if (userId != null) {
      await _firestore
          .collection('informations')
          .doc(userId)
          .update(informations.toMap());
    }
  }
}
