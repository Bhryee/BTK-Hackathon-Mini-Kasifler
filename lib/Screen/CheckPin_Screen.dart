import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Navigation.dart';

final storage = FlutterSecureStorage();

class CheckPinScreen extends StatefulWidget {
  const CheckPinScreen({super.key});

  @override
  State<CheckPinScreen> createState() => _CheckPinScreenState();
}

String? userId = FirebaseAuth.instance.currentUser?.uid;

class _CheckPinScreenState extends State<CheckPinScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  final List<Color> _colors = [
    Colors.orange,
    Colors.lightGreen,
    Colors.purple.shade200,
    Colors.lightBlue,
  ];
  final List<FocusNode> _focusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _checkPin() async {
    String enteredPin = _controllers.map((controller) => controller.text).join();

    if (userId != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('informations')
            .doc(userId)
            .get();

        if (doc.exists) {
          String savedPin = doc['Pin'];

          if (enteredPin == savedPin) {
            await storage.write(key: "userId", value: userId);

            // NavigationScreen'e userId'yi ilet
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationsScreen(userId: userId!),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Hatalı PIN! Lütfen tekrar deneyin.')),
            );
            _clearPinFields();
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kullanıcı bilgileri bulunamadı.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PIN doğrulama hatası: $e')),
        );
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kullanıcı oturumu açılmamış')),
      );
    }
  }

  void _clearPinFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    print("userId: $userId");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ebeveyn kısmına giriş için 4 haneli pini giriniz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Rubik One',
                  fontSize: 25.sp, // Ölçeklenebilir font boyutu
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.h), // Ölçeklenebilir boşluk
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                      (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w), // Ölçeklenebilir yatay boşluk
                    decoration: BoxDecoration(
                      color: _colors[index],
                      shape: BoxShape.circle,
                    ),
                    width: 50.w, // Ölçeklenebilir genişlik
                    height: 50.h, // Ölçeklenebilir yükseklik
                    child: Center(
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 24.sp, // Ölçeklenebilir font boyutu
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            _focusNodes[index + 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h), // Ölçeklenebilir boşluk
              ElevatedButton(
                onPressed: _checkPin,
                child: Text(
                  "Giriş",
                  style: TextStyle(
                    fontSize: 20.sp, // Ölçeklenebilir font boyutu
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r), // Ölçeklenebilir radius
                  ),
                  fixedSize: Size(250.w, 40.h), // Ölçeklenebilir buton boyutu
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
