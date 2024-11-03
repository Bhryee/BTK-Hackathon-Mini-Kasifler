import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordField extends StatefulWidget {
  final bool isSignup; // Oturum oluşturma mı, giriş mi olduğunu belirler

  PasswordField({required this.isSignup}); // Yapıcıda bu durumu alır

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

String? Password;

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      child: Column(
        children: [
          // İlk Şifre Alanı
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              obscureText: _isPasswordHidden,
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Şifre",
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                suffixIcon: IconButton(
                  icon: _isPasswordHidden
                      ? Icon(Icons.visibility_off, color: Colors.grey)
                      : Icon(Icons.visibility, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                errorStyle: TextStyle(fontSize: 16),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Lütfen şifre girin';
                }
                if (value.length < 6) {
                  return 'Şifre en az 6 karakter olmalıdır';
                }
                return null;
              },
              onChanged: (value) { // Şifre her değiştiğinde güncellenir
                Password = value;
              },
            ),
          ),

          SizedBox(height: ScreenUtil().setHeight(20)),
          // Şifreyi Onaylama Alanı (Sadece oturum oluşturma için)
          if (widget.isSignup) ...[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                obscureText: _isConfirmPasswordHidden,
                style: TextStyle(fontSize: ScreenUtil().setSp(19)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Şifreyi Onaylayın",
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  suffixIcon: IconButton(
                    icon: _isConfirmPasswordHidden
                        ? Icon(Icons.visibility_off, color: Colors.grey)
                        : Icon(Icons.visibility, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  errorStyle: TextStyle(fontSize: 16),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen şifreyi onaylayın';
                  }
                  if (value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır';
                  }
                  if (value != Password) {
                    return 'Şifreler eşleşmiyor';
                  }
                  return null;
                },
                onChanged: (value) { // Onay şifresi her değiştiğinde güncellenir
                  confirmPassword = value;
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
