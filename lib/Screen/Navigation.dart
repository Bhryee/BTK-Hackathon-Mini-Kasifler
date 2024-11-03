import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Screen/HomeScreen2.dart';
import 'package:untitled1/Screen/JourneyScreen.dart';
import 'package:untitled1/Screen/LearningJourneyScreen.dart';
import 'package:untitled1/Screen/UserProfileScreen.dart';
import 'package:untitled1/Screen/home_screen.dart';

class NavigationsScreen extends StatefulWidget {
  final String userId;

  const NavigationsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<NavigationsScreen> createState() => _NavigationsScreenState();
}

int _currentIndex = 0;

class _NavigationsScreenState extends State<NavigationsScreen> {
  late PageController pageController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    print("userssss : ${widget.userId}");
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0),
              blurRadius: 10.r,
              offset: Offset(0, -5.h),
            ),
          ],
          border: Border.all(
            color: Colors.grey,
            width: 2.5.w,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey[400],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _currentIndex,
            onTap: navigationTapped,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 28.sp),
                activeIcon: Icon(Icons.person, size: 28.sp),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 28.h,
                  width: 28.w,
                  child: Image.asset(
                    'assets/icons/Chat_icon.png',
                    fit: BoxFit.contain,
                  ),
                ),
                activeIcon: SizedBox(
                  height: 28.h,
                  width: 28.w,
                  child: Image.asset(
                    'assets/icons/Chat_icon_active.png',
                    fit: BoxFit.contain,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_esports_outlined, size: 28.sp),
                activeIcon: Icon(Icons.sports_esports, size: 28.sp),
                label: '',
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          UserProfileScreen(userId: widget.userId),
          HomeScreen(),
          LearningJourneyScreen(),
        ],
      ),
    );
  }
}