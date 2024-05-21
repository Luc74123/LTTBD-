import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/test_phone/model_phone.dart';

class PagePhone extends StatelessWidget {
  const PagePhone({super.key, required String title});

  
  @override
  Widget build(BuildContext context) {
    TextEditingController txPhone = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Phone"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    
        children: [
          Text("Số Điện Thoại"),
          TextField(
            controller: txPhone,
            decoration: InputDecoration(
              labelText: "Số điện thoại"
            ),
            keyboardType: TextInputType.phone,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    openPhoneDial("${txPhone.text}");
                  },
                  child: Text("Phone")
              ),
              SizedBox(width: 9),

              ElevatedButton(
                  onPressed: () {

                  },
                  child: Text("SMS")
              )
            ],
          )


        ],
      ),
    );
  }

}





