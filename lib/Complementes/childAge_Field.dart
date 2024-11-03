import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import this for date formatting

class ChildBirthDateField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChildBirthDateFieldState();
  }
}
Timestamp? birthDate; // Moved inside the state class

class _ChildBirthDateFieldState extends State<ChildBirthDateField> {
  // Use a TextEditingController to handle input
  final TextEditingController _dateController = TextEditingController();

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
              controller: _dateController,
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Çocuğun Doğum Tarihi (gg.aa.yyyy)",
                hintStyle: TextStyle(fontSize: ScreenUtil().setSp(19), color: Colors.grey),
                prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15), vertical: ScreenUtil().setHeight(10)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Lütfen doğum tarihini girin"; // Error message for empty input
                } else {
                  // Optionally, you can add more validation for date format here
                  try {
                    DateFormat("dd.MM.yyyy").parseStrict(value); // Check for date format
                  } catch (e) {
                    return "Geçersiz tarih formatı! (gg.aa.yyyy)"; // Error message for invalid date format
                  }
                }
                return null; // No error
              },
              onSaved: (value) {
                // Convert the input string to DateTime
                DateTime? dateTime;
                try {
                  dateTime = DateFormat("dd.MM.yyyy").parse(value!);
                  // Convert DateTime to Timestamp
                  birthDate = Timestamp.fromDate(dateTime);
                } catch (e) {
                  birthDate = null; // Handle the case where parsing fails
                }
              },
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode()); // To dismiss the keyboard
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  // Format the picked date
                  String formattedDate = DateFormat("dd.MM.yyyy").format(pickedDate);
                  _dateController.text = formattedDate; // Update the text field with the formatted date
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
