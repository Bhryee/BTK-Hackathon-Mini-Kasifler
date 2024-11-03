import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Complementes/girisbutton.dart';

class UserProfileScreen extends StatelessWidget {

  final String userId;

  const UserProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get userId from arguments
   // final String userId = ModalRoute.of(context)!.settings.arguments as String;
    // ScreenUtil'u başlat
    ScreenUtil.init(
      context,
     // designSize: Size(360, 690), // Tasarım boyutu
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('informations')
            .doc(userId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Bir hata oluştu"));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("Kullanıcı bulunamadı"));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String iconUrl = userData['selectedIconPath'];
          String name = userData['childName'];
          Timestamp birthDateTimestamp = userData['birthDate'];

          DateTime birthDate = birthDateTimestamp.toDate();
          DateTime today = DateTime.now();
          Duration ageDifference = today.difference(birthDate);
          int age = ageDifference.inDays ~/ 365;

          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(30)),
                      // Yukarıda daha az boşluk
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Colors.blueAccent,
                            backgroundImage: AssetImage(iconUrl),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // Metni yukarı hizala
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Yaş: $age",
                                  style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold),
                                  // Kalın yapıldı
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 20.h), // Yukarıda boşluk
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(20)),
                      Text(
                        "Öğrenme Serüvenim",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign:
                            TextAlign.left, // Ortada değil, solda hizalanacak
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      // Boşluk azaltıldı
                      _buildColoredContainer(
                          "Motor Becerileri", Colors.orange,"assets/images/5.png"),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      // Boşluk azaltıldı
                      _buildColoredContainer("Problem Çözme ve\nAnaletik Düşünme", Colors.blue,"assets/images/7.png"),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      // Boşluk azaltıldı
                      _buildColoredContainer("Empati", Colors.purple,"assets/images/6.png"),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildColoredContainer(String text, Color color,String image) {
    return Container(
      height: ScreenUtil().setHeight(150),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(16.0.w),
      child: Stack(
        // Stack widget'ı kullanıldı
        children: [
          Align(
            alignment: Alignment.topLeft, // Metni yukarı sola hizala
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight, // Resmi sağ alta hizala
            child: Image.asset(
              image, // Resim dosyasının yolu
              width: 125.w, // Resim genişliği
              height: 125.h, // Resim yüksekliği
              fit: BoxFit.cover, // Resmin boyutunu kapsasın
            ),
          ),
        ],
      ),
    );
  }
}
