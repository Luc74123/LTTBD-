

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> ShowcanfirmDialog(BuildContext context, String dispMessage) async{
  AlertDialog dialog = AlertDialog(
    title:  const Text("Xác nhận"),
    content: Text(dispMessage),
    actions: [
      ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop("cancel"),
          child: const Text("Hủy")
      ),
      ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop("OK"),
          child: const Text("OK")
      ),
    ],
  );
  String? res = await showDialog(
      barrierDismissible: false, //Phải bấm vào nút hủy hoặc OK
      context: context,
      builder: (context) => dialog,
  );
  return res;
}