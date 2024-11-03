import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String? childname;

class ChildNameField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return childName();
  }
}

class childName extends State<ChildNameField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Çocuğun Adı",
                hintStyle: TextStyle(fontSize: 19),
                prefixIcon: Icon(Icons.star_border, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Lütfen isim girin"; // Bu mesajı döndürün
                } else {
                  return null; // Hata mesajını kaldırdık
                }
              },
              onSaved: (value) {
                childname = value!;
              },
            ),
          ),
        ],
      ),
    );
  }
}
