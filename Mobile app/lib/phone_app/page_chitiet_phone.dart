import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gialuc63132245_flutter/phone_app/phone_model.dart';
import 'package:gialuc63132245_flutter/phone_app/models_upload_image.dart';

//Trang them moi so dien thoai
class PageCTPhone extends StatefulWidget {
  const PageCTPhone({super.key});

  @override
  State<PageCTPhone> createState() => _PageCTPhoneState();
}

class _PageCTPhoneState extends State<PageCTPhone> {
  XFile? _xFile;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtSdt = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Thêm mới số điện thoại", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: w*0.8,
                height: w*0.8*2/3,
                child: _xFile ==null ? Icon(Icons.image): Image.file(File(_xFile!.path)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async{
                      _xFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery
                      );
                      if(_xFile!=null)
                        setState(() {

                        });
                    },
                    child: Text("Chọn ảnh")
                )
              ],
            ),
            TextField(
              controller: txtId,
              decoration: InputDecoration(
                labelText: "Id",
              ),
              keyboardType: TextInputType.number,

            ),
            TextField(
              controller: txtTen,
              decoration: InputDecoration(
                labelText: "Tên",

              ),

            ),
            TextField(
              controller: txtSdt,
              decoration: InputDecoration(
                labelText: "Số Điện Thoại",
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: txtMoTa,
              decoration: InputDecoration(
                labelText: "Mô Tả",

              ),

            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //1 Thêm ảnh và lấy đường dẫn
                    if(_xFile!=null){
                      uploadImage(
                          imagePath: _xFile!.path,
                          folders: ["phone_app/"],
                          fileName: "${txtId.text}.jpg"
                      ).then(
                            (url) {
                          //2 Thêm dữ liệu vào FirebaseStore
                          Phone phone = Phone(
                            id: txtId.text,
                            ten: txtTen.text,
                            sdt: txtSdt.text,
                            mota: txtMoTa.text,
                            image: url,

                          );
                          PhoneSnapshot.themMoi(phone);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Bạn đã them số điện thoại thành công"),
                                duration: Duration(seconds: 2),
                              )
                          );
                        },
                      ).catchError((error){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Lỗi thêm sdt"),
                              duration: Duration(seconds: 2),
                            )
                        );
                        print("Lỗi: ${error.toString()}");
                      });
                    }
                  },
                  child: Text("Thêm"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
