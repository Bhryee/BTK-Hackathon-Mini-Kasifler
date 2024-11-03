import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w), // width'ü cihaz boyutuna göre ölçeklendirir
      child: Row(
        mainAxisAlignment: isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.h, // yükseklik olarak ölçeklendirir
              horizontal: 16.w, // genişlik olarak ölçeklendirir
            ),
            margin: EdgeInsets.only(bottom: 8.h),
            constraints: BoxConstraints(maxWidth: 280.w), // maksimum genişlik de ölçeklenmiş
            decoration: BoxDecoration(
              color: isFromUser
                  ? Color.fromRGBO(120, 182, 44, 1)
                  : Color.fromRGBO(152, 209, 76, 1),
              borderRadius: BorderRadius.circular(20.r), // köşeleri ölçeklenmiş
            ),
            child: MarkdownBody(
              data: text,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  color: isFromUser ? Colors.black87 : Colors.black87,
                  fontSize: 15.sp, // font boyutu cihaz boyutuna göre ölçeklenmiş
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
