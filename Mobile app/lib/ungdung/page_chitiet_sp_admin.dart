import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/storage_image_helper.dart';
import 'package:gialuc63132245_flutter/ungdung/models.dart';
import 'package:gialuc63132245_flutter/ungdung/page_capnhat_sp_admin.dart';
import 'package:image_picker/image_picker.dart';

class PageCTSP_Admin extends StatefulWidget {
  const PageCTSP_Admin ({super.key});

  @override
  State<PageCTSP_Admin> createState() => _PageCTSP_Admin();
}

class _PageCTSP_Admin extends State<PageCTSP_Admin> {
  XFile? _xFile;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMota = TextEditingController();

  @override

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Thêm sản phẩm"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: w*0.8,
                height: w*0.8*2/3,
                child: _xFile==null ? Icon(Icons.import_contacts_sharp): Image.file(File(_xFile!.path)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if(_xFile!=null)
                        setState(() {
                          
                        });
                    }, 
                    child: Text("Chọn ảnh")
                ),
              ],
            ),
            TextField(
              controller: txtId,
              decoration: InputDecoration(
                labelText: "Id"
              ),
            ),
            TextField(
              controller: txtTen,
              decoration: InputDecoration(
                  labelText: "Tên"
              ),
            ),
            TextField(
              controller: txtGia,
              decoration: InputDecoration(
                  labelText: "Giá"
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: txtMota,
              decoration: InputDecoration(
                  labelText: "Mô tả"
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //1 Thêm ảnh và lấy đường dẫn

                      if(_xFile!=null){
                        showMySnackBar(context, "Dang them san pham...", 10);
                        uploadImage(
                            imagePath: _xFile!.path,
                            folders: ["Fruit"],
                            fileName: "${txtId.text}.jpg").then(
                                (url){
                                  //2 Thêm
                                  Fruit fruit = Fruit(
                                      id: txtId.text,
                                      ten: txtTen.text,
                                      gia: int.parse(txtGia.text),
                                      mota: txtMota.text,
                                      anh: url,

                                  );
                                  FruitSnapshot.themMoi(fruit);
                                  showMySnackBar(context, "Them san pham ko thanh cong", 3);
                                }
                        ).catchError((error){
                          print("Lỗi gì đây: ${error.toString()}");
                        });
                      }
                      //2 Thêm dữ liệu vào FireStore
                    },
                    child: Text("Thêm")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
