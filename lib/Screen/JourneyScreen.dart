import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Games/image_reveal_game/game.dart';
import 'package:untitled1/Games/sequence_game/game.dart';


class JourneyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(375, 812),
      minTextAdapt: true,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Text(
              'Motor Beceriler \n Öğrenme Yolculuğu',
              textAlign: TextAlign.center,

              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Buton - SequenceGame
                  Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: GameButton(
                      text: 'OYUN 1',
                      color: Colors.orange,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ImageRevealGame()),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 2. Buton - BulmacaGame
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20.h, right: 15.w),
                            child: GameButton(
                              text: 'OYUN 2',
                              color: Colors.orange,
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SequenceGame()),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -150.h,
                            right: 5.w,
                            child: Image.asset(
                              'assets/images/Animal_2.png',
                              height: 200.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // 3. Buton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 45.h, left: 30.w),
                            child: GameButton(
                              text: 'OYUN 3',
                              color: Colors.grey,
                              onPressed: () {
                                // Future navigation can be added here
                              },
                            ),
                          ),
                          Positioned(
                            top: -135.h,
                            left: 30.w,
                            child: Image.asset(
                              'assets/images/Animal_3.png',
                              height: 200.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),

                  // 4. Buton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20.h, right: 15.w),
                            child: GameButton(
                              text: 'OYUN 4',
                              color: Colors.grey,
                              onPressed: () {
                                // Future navigation can be added here
                              },
                            ),
                          ),
                          Positioned(
                            top: -130.h,
                            right: 30.w,
                            child: Image.asset(
                              'assets/images/Animal_1.png',
                              height: 200.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 10.h,
                            right: 220.w,
                            child: Image.asset(
                              'assets/images/Animal_4.png',
                              height: 120.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  GameButton({
    required this.text,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(160.w, 100.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}