import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/Complementes/password_field.dart';
import '../Screen/Login.dart';
import '../Screen/Navigation.dart';
import 'email_field.dart';

final storage = FlutterSecureStorage();
String? errorMessage;
String? userId;

class GirisButton extends StatefulWidget {
  @override
  _GirisButtonState createState() => _GirisButtonState();
}

class _GirisButtonState extends State<GirisButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (errorMessage != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              errorMessage!,
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
          ),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              if (formAnahtari.currentState!.validate()) {
                formAnahtari.currentState!.save();
                try {
                  String password = Password ?? "";
                  String email = Email ?? "";

                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  userId = userCredential.user?.uid;
                  await storage.write(key: "userId", value: userId);

                  errorMessage = null;
                  formAnahtari.currentState!.reset();
                  // NavigationScreen'e userId'yi ilet
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigationsScreen(userId: userId!),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    if (e.code == 'user-not-found') {
                      errorMessage =
                          "Bu e-posta ile kayıtlı bir kullanıcı bulunamadı.";
                    } else if (e.code == 'wrong-password') {
                      errorMessage = "Yanlış şifre girdiniz.";
                    } else {
                      errorMessage =
                          "E-posta ya da şifre hatalı. Lütfen tekrar deneyin.";
                    }
                  });
                }
              } else {
                setState(() {
                  errorMessage = null;
                });
              }
            },
            child: Text(
              "Giriş Yap",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              fixedSize: Size(
                ScreenUtil().setWidth(250),
                ScreenUtil().setHeight(40),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
