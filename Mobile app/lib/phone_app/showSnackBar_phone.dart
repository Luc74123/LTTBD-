import 'package:flutter/material.dart';

Future<String?> showConfirmDialog(BuildContext context, String disMessage)async{
  AlertDialog dialog = AlertDialog(
    title: const Text("Xác nhận"),
    content: Text(disMessage),
    actions: [
      ElevatedButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop("cancel"),
        child: const Text("Hủy"),
      ),
      ElevatedButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop("ok"),
        child: const Text("Ok"),
      ),
    ],
  );
  String? res = await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => dialog,
  );
  return res;
}