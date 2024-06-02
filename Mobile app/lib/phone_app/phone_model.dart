
import 'package:cloud_firestore/cloud_firestore.dart';

class Phone{
  String id,ten, sdt;
  String? mota, image;

  Phone({required this.id, required this.ten, required this.sdt, this.mota, this.image});

  Map<String, dynamic> toJson() {//toJson chuyen doi doi tuong Phone thanh map cap key-value
    return {
      'id': this.id,
      'ten': this.ten,
      'sdt': this.sdt,
      'mota': this.mota,
      'image': this.image,
    };
  }

  factory Phone.fromJson(Map<String, dynamic> map) {//tao lai doi tuong Phone tu cap Key-value lay tu document tren firestore
    return Phone(
      id: map['id'] as String,
      ten: map['ten'] as String,
      sdt: map['sdt'] as String,
      mota: map['mota'] as String,
      image: map['image'] as String,
    );
  }
}
// Lớp truy cập dữ liệu
class PhoneSnapshot{
  Phone phone;
  // Tham chiếu đến địa chỉ firebase firestore
  DocumentReference ref;

  PhoneSnapshot({
    required this.phone,
    required this.ref,
  });
  //PhoneSnapShot: la no lay du lieu duoc tao tren firestore va chuyen du lieu do thanh mot doi tuong Phone va co duong dan den document do
  //kieu nhu la: khi tao collection thi no bat nhap vao cac cap key-value tren firestore, thi minh chuyen du lieu do thanh doi tuong PhoneSnapshot
  factory PhoneSnapshot.fromSnapshot(DocumentSnapshot docSnap){//documenSnapShot la 1 truy van tren firestore tren firebase, dung fromSnapshot de tao ra doi tuong PhoneSnapshot tu du lieu cua documentSnapShot tren firebase
    return PhoneSnapshot(//docsnap no se chua du lieu document tren firestore
      //tao mot doi tuong phone tu cap key-value bang fromJson
      phone: Phone.fromJson(docSnap.data() as Map<String, dynamic>),//lay du lieu document tren firestore va no chuyen cap key-value tren do thanh mot doi tuong Phone
      ref: docSnap.reference,//du tham chieu den vi tri document tren firestore
      //giup PhoneSnapShot biet duoc duong dan den document de no dung cho viec them xoa sua tren document do
    );
  }
  //Thêm Mới
  static Future<DocumentReference> themMoi(Phone phone) async{
    //firebasefirestore.instance cho phep truy cap vao co so du lieu cua firestore database
    //collection("Phones"): truy cap vao collection tren firestore la Phones
    return FirebaseFirestore.instance.collection("Phones").add(phone.toJson());
  }
  //Cập nhật
  Future<void> capNhat(Phone phone) async{
    return ref.update(phone.toJson());
  }
  //Xóa
  Future<void> xoa( Phone phone) async{
    return ref.delete();
  }
  //Truy vấn dữ liệu theo thời gian thực
  //tra ve 1 Stream la danh sach cac PhoneSnapShot
  static Stream<List<PhoneSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Phones").snapshots();//snapshots() tra ve 1 querysnapshot khi co su thay doi tren firestore
    return sqs.map(//sqs dang giu danh sach cac querysnapshot, va lay tung querysnapshot la qs
            (qs) => qs.docs.map(//truy cap den tung document tuong ung voi moi querysnapshot va map tung document thanh mot doi tuong PhoneSnapshot
                (docSnap) => PhoneSnapshot.fromSnapshot(docSnap)).toList()
    );
  }
  //Truy vấn dữ liệu một lần
  static Future<List<PhoneSnapshot>> getAll2() async{
    QuerySnapshot sqs = await FirebaseFirestore.instance.collection("Phones").get();
    return sqs.docs.map(
            (docSnap) => PhoneSnapshot.fromSnapshot(docSnap)).toList();
  }
}