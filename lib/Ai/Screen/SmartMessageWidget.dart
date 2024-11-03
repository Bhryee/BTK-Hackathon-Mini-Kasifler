import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:untitled1/Screen/JourneyScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartMessageWidget extends StatelessWidget {
  const SmartMessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
    this.navigateToPage,
  });

  final String text;
  final bool isFromUser;
  final Widget? navigateToPage;

  @override
  Widget build(BuildContext context) {
    final String lowerText = text.toLowerCase();
    final NavigationInfo navInfo = _getNavigationInfo(lowerText);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment:
            isFromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 12.w,
            ),
            constraints: BoxConstraints(maxWidth: 280.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0CB3EB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(isFromUser ? 0 : 8.r),
              ),
            ),
            child: MarkdownBody(
              data: text,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                  height: 1.3,
                ),
              ),
            ),
          ),
          if (navInfo.shouldShowButton)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0CB3EB),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () => _handleNavigation(context, navInfo.targetPage),
                child: Text(
                  navInfo.buttonText,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handleNavigation(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  NavigationInfo _getNavigationInfo(String lowerText) {
    if (!isFromUser) {
      if (lowerText.contains('oyun')) {
        // This uses `lowerText` directly
        return NavigationInfo(
          shouldShowButton: true,
          buttonText: 'Oyuna Git',
          targetPage: JourneyScreen(),
        );
      }
    }
    return NavigationInfo(
      shouldShowButton: false,
      buttonText: '',
      targetPage: const SizedBox(),
    );
  }
}

class NavigationInfo {
  final bool shouldShowButton;
  final String buttonText;
  final Widget targetPage;

  NavigationInfo({
    required this.shouldShowButton,
    required this.buttonText,
    required this.targetPage,
  });
}
