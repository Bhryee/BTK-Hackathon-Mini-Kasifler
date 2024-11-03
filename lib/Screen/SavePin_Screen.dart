import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Screen/Navigation.dart';

final storage = FlutterSecureStorage();

class SavePinScreen extends StatefulWidget {
  const SavePinScreen({super.key});

  @override
  State<SavePinScreen> createState() => _SavePinScreenState();
}

class _SavePinScreenState extends State<SavePinScreen> {
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

  String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> _savePin() async {
    String pin = _controllers.map((controller) => controller.text).join();

    if (userId != null) {
      try {
        await FirebaseFirestore.instance.collection('informations').doc(userId).update({
          'Pin': pin,
        });

        // Store userId securely for future sessions
        await storage.write(key: "userId", value: userId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("PIN başarıyla kaydedildi")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationsScreen(userId: userId!),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PIN kaydetme hatası: $e')),
        );
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ebeveyn kısmına kayıt için 4 haneli pini giriniz.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Rubik One',
                  fontSize: 25.sp, // Changed from const to non-const
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                      (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: _colors[index],
                      shape: BoxShape.circle,
                    ),
                    width: 50.w,
                    height: 50.h,
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
                          fontSize: 24.sp,
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
              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: _savePin,
                child: Text(
                  "Kaydet",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  fixedSize: Size(250.w, 40.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
