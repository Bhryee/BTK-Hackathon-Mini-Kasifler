import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Complementes/Game_button.dart';

class LearningJourneyScreen extends StatelessWidget {
  const LearningJourneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Text(
                'OYUNLAR',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/HomeScreen2");
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF66D5FD),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/Game_chat.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Uygulama için özel olarak tasarlanmış oyunlar üzerine eğitilmiş bir model ile sohbet et!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              GameButton(
                imagePath: 'assets/images/Game_photo.png',
                label: 'FOTOĞRAF KEŞFETME',
                color: const Color.fromRGBO(248, 145, 164, 1),
                description:
                    '1 yaşındaki çocukların motor becerilerini geliştirmek adına ekrandaki kutucuklara dokunarak kutuların altındaki resmi keşfetmelerini sağlar. Bu tür interaktif resim oyunları 1 yaşındaki çocukların el-göz koordinasyonunu geliştirirken dokunmatik ekranda parmak hareketleriyle ince motor becerilerinin ve görsel takip yeteneklerinin güçlenmesini sağlar.',
              ),
              SizedBox(height: 20.h),
              GameButton(
                  imagePath: 'assets/images/Game_photo2.png',
                  label: 'SIRALAMA OYUNU',
                  color: const Color.fromRGBO(102, 213, 253, 1),
                  description: ''),
              SizedBox(height: 20.h),
              GameButton(
                  imagePath: 'assets/images/Game_photo3.png',
                  label: 'YAPBOZ',
                  color: const Color.fromRGBO(152, 209, 76, 1),
                  description: ''),
              SizedBox(height: 20.h),
              GameButton(
                  imagePath: 'assets/images/Game_photo4.png',
                  label: 'NESNE BULMA',
                  color: const Color.fromRGBO(254, 178, 67, 1),
                  description: ''),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
