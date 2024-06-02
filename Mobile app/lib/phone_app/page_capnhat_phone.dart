import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gialuc63132245_flutter/phone_app/phone_model.dart';
import 'package:gialuc63132245_flutter/phone_app/models_upload_image.dart';
// Trang cap nhap lai thong tin
class PageCapNhapPhone extends StatefulWidget {
  PhoneSnapshot phoneSnapshot;
  PageCapNhapPhone({super.key, required this.phoneSnapshot});

  @override
  State<PageCapNhapPhone> createState() => _PageCapNhapPhoneState();
}

class _PageCapNhapPhoneState extends State<PageCapNhapPhone> {
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
        title: Text("Chỉnh sửa thông tin", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: w*0.8,
                height: w*0.8*2/3,
                child: _xFile ==null ? Image.network(widget.phoneSnapshot.phone.image!): Image.file(File(_xFile!.path)),
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
                  hintText: "Mời nhập id"

              ),

            ),
            TextField(
              controller: txtTen,
              decoration: InputDecoration(
                  labelText: "Tên",
                  hintText: "Mời nhập tên"

              ),

            ),
            TextField(
              controller: txtSdt,
              decoration: InputDecoration(
                labelText: "So dien thoai",
                hintText: "Mời nhập vào số điện thoại",
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: txtMoTa,
              decoration: InputDecoration(
                  labelText: "Mô Tả",
                  hintText: "Mời nhập thông tin mô tả"

              ),

            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String? imageUrl;
                    //1 Thêm ảnh và lấy đường dẫn
                    Phone phone = Phone(
                      id: txtId.text,
                      ten: txtTen.text,
                      sdt: txtSdt.text,
                      mota: txtMoTa.text,

                    );
                    showSnackBar(context, "Đang cập nhật thong tin sdt..", 10);
                    if(_xFile!=null){
                      imageUrl = await uploadImage(
                          imagePath: _xFile!.path,
                          folders: ["phone_app/"],
                          fileName: "${txtId.text}.jpg"
                      );
                      if(imageUrl!=null){
                        phone.image = imageUrl;
                        _capNhatTT(phone);
                      }
                      else{
                        showSnackBar(context, "Cập nhật so dien thoai khong thành công", 3);
                      }
                    }else{
                      phone.image = widget.phoneSnapshot.phone.image;
                      _capNhatTT(phone);
                    }

                  },
                  child: Text("Cập nhật"),
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
    txtId.text = widget.phoneSnapshot.phone.id;
    txtTen.text = widget.phoneSnapshot.phone.ten;
    txtSdt.text = widget.phoneSnapshot.phone.sdt;
    txtMoTa.text = widget.phoneSnapshot.phone.mota??"";

  }
  _capNhatTT(Phone phone) async{
    widget.phoneSnapshot.capNhat(phone).then(
          (value) => showSnackBar(context, "Cập nhật sdt thành công", 3),
    ).catchError((error){
      showSnackBar(context, "Cập nhật không thành công", 3);
    });

  }
}

showSnackBar (BuildContext context, String thongBao, int giay){
  ScaffoldMessenger.of(context).clearMaterialBanners();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(thongBao),
      duration: Duration(seconds: giay),),

  );
}
