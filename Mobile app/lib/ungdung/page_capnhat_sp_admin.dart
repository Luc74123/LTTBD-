import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/storage_image_helper.dart';
import 'package:gialuc63132245_flutter/ungdung/models.dart';
import 'package:image_picker/image_picker.dart';



class PageCapNhatSp_admin extends StatefulWidget {
  FruitSnapshot fruitSnapshot;
  PageCapNhatSp_admin ({required this.fruitSnapshot, super.key});

  @override
  State<PageCapNhatSp_admin> createState() => _PageCapNhatSp_admin();
}

class _PageCapNhatSp_admin extends State<PageCapNhatSp_admin> {
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
                // SV image.network
                child: _xFile==null ? Image.network(widget.fruitSnapshot.fruit.anh!)
                    :Image.file(File(_xFile!.path)),
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
                    onPressed: () async {
                      //1 Thêm ảnh và lấy đường dẫn
                      String? imageurl;
                      Fruit fruit = Fruit(
                        id: txtId.text,
                        ten: txtTen.text,
                        gia: int.parse(txtGia.text),
                        mota: txtMota.text,
                      );
                      showMySnackBar(context, "Đang cập nhật sp...", 10);
                      if(_xFile!=null){
                        imageurl = await uploadImage(
                            imagePath: _xFile!.path,
                            folders: ["Fruit"],
                            fileName: "${txtId.text}.jpg"
                        );
                        if(imageurl!=null){
                          fruit.anh=imageurl;
                          _capNhatSP(fruit);
                        }
                        else
                          showMySnackBar(context, "Cập nhật sp không thành công...", 3);
                      }else{
                        fruit.anh = widget.fruitSnapshot.fruit.anh;
                        _capNhatSP(fruit);
                      }
                      //2 Thêm dữ liệu vào FireStore
                    },
                    child: Text("Cập nhật")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    txtId.text = widget.fruitSnapshot.fruit.id;
    txtTen.text = widget.fruitSnapshot.fruit.ten;
    txtGia.text = widget.fruitSnapshot.fruit.gia.toString();
    txtMota.text = widget.fruitSnapshot.fruit.mota?? "";
  }
  _capNhatSP(Fruit fruit) async{
    widget.fruitSnapshot.capNhat(fruit).then(
          (value) => showMySnackBar(
          context, "Cập nhật thành công sản phẩm: ${txtTen.text}", 3
      ),
    ).catchError((error){
      showMySnackBar(context,"Cập nhật không thành công sản phẩm: ${txtTen.text}",3);
    }
    );
  }
}
showMySnackBar(BuildContext context, String thongBao, int giay){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(thongBao),
      duration: Duration(seconds: giay),
    ),
  );
}




