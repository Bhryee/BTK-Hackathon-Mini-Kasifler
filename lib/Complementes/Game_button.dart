import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameButton extends StatefulWidget {
  final String imagePath;
  final String label;
  final String description;
  final Color color;

  GameButton({
    required this.imagePath,
    required this.label,
    required this.description,
    required this.color,
  });

  @override
  _GameButtonState createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  bool _expanded = false;

  void _toggleExpand() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpand,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: _expanded ? calculateHeight(widget.description) : 80.h,
        width: 300.w,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 10.h),
                    child: SizedBox(
                      width: 60.w,
                      height: 60.h,
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Text(
                        widget.label,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              if (_expanded)
                Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateHeight(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 14.sp),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: 310.w);

    return 100.h + textPainter.height + 20.h;
  }
}