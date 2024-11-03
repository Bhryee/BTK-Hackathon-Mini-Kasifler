import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Complementes/email_field.dart';
import 'package:untitled1/Complementes/loginButton.dart';
import 'package:untitled1/Complementes/password_field.dart';
import '../Complementes/childAge_Field.dart';
import '../Complementes/childName_Field.dart';

final Formkey = GlobalKey<FormState>();
String IconPath = "";

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final TextEditingController childNameController = TextEditingController();
  final TextEditingController childAgeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: Formkey,
          child: Stack(
            children: [
              _buildHeader(),
              _buildForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: ScreenUtil().setHeight(70),
      left: ScreenUtil().setWidth(20),
      right: ScreenUtil().setWidth(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Yeni Hesap Oluşturun",
            style: TextStyle(
              color: Colors.blue,
              fontSize: ScreenUtil().setSp(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Text(
            "Çocuğunuzun öğrenme süreci açmış olduğunuz hesap üzerinden kaydedilecektir.",
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(170)),
            eMailField(),
            SizedBox(height: ScreenUtil().setHeight(15)),
            PasswordField(isSignup: true),
            SizedBox(height: ScreenUtil().setHeight(15)),
            ChildNameField(), // Controller'ı geçiriyoruz
            SizedBox(height: ScreenUtil().setHeight(15)),
            ChildBirthDateField(),
            SizedBox(height: ScreenUtil().setHeight(10)),
            _buildProfilePhotoSelection(),
            SizedBox(height: ScreenUtil().setHeight(10)),
            _buildIcon(), // Ikon seçimi kısmı
            SizedBox(height: ScreenUtil().setHeight(10)),
            LoginButton(formKey: Formkey), // Controller'ı buraya ekliyoruz
            SizedBox(height: ScreenUtil().setHeight(10)),
            _buildAccountQuestion(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePhotoSelection() {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(25)),
      // Use ScreenUtil for responsive padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profil fotoğrafı seçin",
            style: TextStyle(
              color: Color.fromRGBO(12, 179, 235, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCircleAvatar("assets/images/Icon1.png"),
          _buildCircleAvatar("assets/images/Icon2.png"),
          _buildCircleAvatar("assets/images/Icon3.png"),
          _buildCircleAvatar("assets/images/Icon4.png"),
        ],
      ),
    );
  }

  Widget _buildCircleAvatar(String assetPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          IconPath = assetPath; // Seçilen ikon yolunu güncelle
        });
      },
      child: Opacity(
        opacity: IconPath.isEmpty || IconPath == assetPath ? 1.0 : 0.5,
        // Seçilen ikon opak, diğerleri yarı saydam
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: CircleAvatar(
            backgroundImage: AssetImage(assetPath),
            radius: 35,
          ),
        ),
      ),
    );
  }

  Widget _buildAccountQuestion(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Zaten hesabın var mı?", style: TextStyle(color: Colors.black)),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, '/login'); // Login sayfasına yönlendirme
            },
            child: Text("Giriş Yap", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
