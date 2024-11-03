import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String? Email;

class eMailField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return eMail();
  }
}

class eMail extends State<eMailField> {
  final FocusNode _focusNode = FocusNode();
  Color _borderColor = Colors.grey.shade200;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _borderColor = _focusNode.hasFocus ? Colors.blue : Colors.grey.shade200;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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
              border: Border.all(color: _borderColor, width: 2), // Dinamik kenarlık rengi
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              focusNode: _focusNode,
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Mail",
                hintStyle: TextStyle(fontSize: ScreenUtil().setSp(19)),
                prefixIcon: Icon(Icons.mail, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen e-posta girin";
                } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                  return "Geçerli bir e-posta adresi giriniz.";
                }
                return null;
              },
              onSaved: (value) {
                Email = value!;
              },
            ),
          ),
        ],
      ),
    );
  }
}
