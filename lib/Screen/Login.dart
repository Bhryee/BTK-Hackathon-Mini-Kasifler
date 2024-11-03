import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Complementes/email_field.dart';
import 'package:untitled1/Complementes/password_field.dart';
import '../Complementes/girisbutton.dart';

final GlobalKey<FormState> formAnahtari = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: ScreenUtil().setHeight(-50),
              left: ScreenUtil().setWidth(-7),
              child: Image.asset(
                "assets/images/login.png",
                height: ScreenUtil().setHeight(450),
                width: ScreenUtil().setWidth(MediaQuery.of(context).size.width),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Form(
                  key: formAnahtari,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: ScreenUtil().setHeight(400)),
                      Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                        child: Text(
                          "Hesabınıza Giriş Yapınız",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      eMailField(),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      PasswordField(isSignup: false),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      GirisButton(),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      _buildAccountQuestion(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountQuestion(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hesabın yok mu?", style: TextStyle(color: Colors.black)),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/signIn");
            },
            child: Text("Kayıt Ol", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
