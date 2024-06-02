
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/helper/firebase_options.dart';
//import 'package:gialuc_firebase/firebase_options.dart';


class MyFirebaseConnect extends StatefulWidget {
  final String errorMessage;
  final String connectingMessage;
  final Widget Function(BuildContext context) builder;

  const MyFirebaseConnect({Key? key,
    required this.errorMessage,
    required this.connectingMessage,
    required this.builder ,}) : super(key: key);

  @override
  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool ketNoi = false;
  bool loi = false;
  @override

  _KhoiTaoFirebase(){ // phuong thuc bat dong bo
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
            (value) {
              setState(() {
                ketNoi = true;
              });
            }
    ).catchError((error){
      setState(() {
        loi = true;
      });
    }
    ).whenComplete(()  {
      print("Kết thúc việc khởi tạo Firebase");
    }
    );
  }
  Widget build(BuildContext context) {
    if(loi){
      return
          Container(
            color: Colors.white,
            child: Center(
              child: Text(widget.errorMessage,
                style: TextStyle(fontSize: 16, color: Colors.red,),
                textDirection: TextDirection.ltr,
              ),
            ),
          );
    }else
      if(ketNoi == false){
        return
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(widget.connectingMessage,
                      style: TextStyle(fontSize: 16,),
                      textDirection: TextDirection.ltr,
                    )
                  ],
                ),
              ),
            );
      }
      else{
        return
            widget.builder(context);
      }

  }

  @override
  void initState(){
    super.initState();
    _KhoiTaoFirebase();
  }
}
