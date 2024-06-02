import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

//imagePath: la duong dan cua file anh, trong qua trinh truy xuat vi tri cua anh de dua len dich vu firebase storage => de no biet la no se lay anh o dau
//folders: la danh cac folder, dung de tao ra cau truc thu muc,
Future<String> uploadImage({required String imagePath,required List<String> folders,required String fileName}) async{
  String dowloadUrl;
  // Tạo đối tượng FirebaseStorage
  FirebaseStorage _storage = FirebaseStorage.instance;//tao ra 1 instance dai dien cua lop firebasestorage, chi can 1 instance dai dien nay de dua du lieu len, xoa du lieu,...

  //1. Thiết lập đường dẫn trên firebase storage
  Reference reference = _storage.ref();//ref(): la mot tham chieu den goc cua firebase storage => reference no dang tham chieu den goc cua firebase storage
  for(String f in folders)// duyet qua tung folder con trong folders
    //reference tai goc cua firebase storage, child(f) no se giup tham chieu con moi dua tren tham chieu hien tai cua no
    reference = reference.child(f);
  reference = reference.child(fileName);

  //2.Thiết lập metadata
  //cung cap them cac thong tin ve file duoc tai len
  final metadata = SettableMetadata(
      contentType: 'image/jpeg',//xac dinh loai noi dung cua file tai len
      customMetadata: {'picked-file-path':imagePath}//thiet lap thong tin ve duong dan hinh anh
  );


  //3. upload ảnh lên fire base storage và trả về đường dẫn
  try{
    if(kIsWeb)//kiem tra co dang chay tren nen tang web khong (tu kIsWeb la tu packet foundation.dart)
      await reference.putData(await XFile(imagePath).readAsBytes(),metadata);
    else
      await reference.putFile(File(imagePath),metadata);
    dowloadUrl = await reference.getDownloadURL();
    return dowloadUrl;//luu tru duong dan luu anh tren firebase storage
  }on FirebaseException catch (e){
    print("Lỗi upload ảnh lên firebase ${e.toString()}");
    return Future.error("lỗi up load file");
  }
}

Future<void> deleteImage({required List<String> folders,required String fileName}) async{
  FirebaseStorage _storage = FirebaseStorage.instance;
  //1. Thiết lập đường dẫn trên firebase storage
  Reference reference = _storage.ref();
  for(String f in folders)
    reference = reference.child(f);
  reference = reference.child(fileName);
  return reference.delete();


}