import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth_methods.dart';
import 'email_field.dart';
import 'password_field.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  LoginButton({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(45)),
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            try {
              String password = Password ?? ""; // Password değişkenini alıyoruz
              String email = Email ?? ""; // Email değişkenini alıyoruz

              // createAccount metoduna gerekli tüm argümanları geçiyoruz
              await context
                  .read<FlutterFireAuthService>()
                  .createAccount(email, password);

              formKey.currentState!.reset();

              Navigator.pushNamed(context, "/SavePinScreen");
            } on FirebaseAuthException catch (e) {
              // Hata koduna göre kullanıcıya uygun bir mesaj gösteriyoruz
              String errorMessage = _getErrorMessage(e.code);
              _showErrorSnackBar(
                  context, errorMessage); // SnackBar ile hata mesajı gösterme
            } catch (e) {
              _showErrorSnackBar(context, "Bir hata oluştu: $e");
            }
          }
        },
        child: Text("Kayıt Ol"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 12.0),
          textStyle: TextStyle(
            fontSize: ScreenUtil().setSp(20),
            fontWeight: FontWeight.bold,
          ),
          fixedSize:
              Size(ScreenUtil().setWidth(250), ScreenUtil().setHeight(45)),
        ),
      ),
    );
  }

  // Hata mesajlarını belirleyen bir fonksiyon
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return "Bu e-posta adresi zaten kullanımda.";
      case 'invalid-email':
        return "Geçersiz e-posta formatı.";
      case 'weak-password':
        return "Parola çok zayıf. Daha güçlü bir parola seçin.";
      default:
        return "Bilinmeyen bir hata oluştu. Lütfen tekrar deneyin.";
    }
  }

  // SnackBar ile hata mesajını gösteren bir fonksiyon
  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
