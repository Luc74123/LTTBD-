import 'package:cloud_firestore/cloud_firestore.dart';

class Fruit{
  String id, ten;
  int gia;
  String? anh;
  String? mota;
  Fruit({required this.id, required this.ten,
    required this.gia, this.anh, this.mota});

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'ten': this.ten,
      'gia': this.gia,
      'anh': this.anh,
      'mota': this.mota,
    };
  }

  factory Fruit.fromJson(Map<String, dynamic> map) {
    return Fruit(
      id: map['id'] as String,
      ten: map['ten'] as String,
      gia: map['gia'] as int,
      anh: map['anh'] as String,
      mota: map['mota'] as String,
    );
  }
}

class FruitSnapshot {
  Fruit fruit;
  DocumentReference ref;

  FruitSnapshot({
    required this.fruit,
    required this.ref,
  });

  factory FruitSnapshot.fromMap(DocumentSnapshot docSnap) {
    return FruitSnapshot(
      fruit: Fruit.fromJson(docSnap.data() as Map<String, dynamic>),
      ref: docSnap.reference,
    );
  }
  static Future<DocumentReference> themMoi(Fruit fruit) async{
    return FirebaseFirestore.instance.collection("Fruit").add(fruit.toJson());
  }

  Future<void> capNhat(Fruit fruit) async{
    return ref.update(fruit.toJson());
  }

  Future<void> xoa() async{
    return ref.delete();
  }

  // truy van du lieu thoi gian thuc
  static Stream<List<FruitSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("Fruit").snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => FruitSnapshot.fromMap(docSnap)
        ).toList());
  }
  //Truy van du lieu 1 lan
  static Future<List<FruitSnapshot>> getAll2() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("Fruit").get();
    return qs.docs.map(
            (docSnap) => FruitSnapshot.fromMap(docSnap)
    ).toList();
  }
}

class GioHang_item{
  String idSP;
  int sl;
  GioHang_item({required this.idSP, required this.sl});
}

Map<String, String> images = {
  "Tao": "https://blog.onelife.vn/wp-content/uploads/2023/07/373374a7-1-6.png",
  "Nho": "https://traicayhoabien.com/wp-content/uploads/2021/06/NHOXANH-nho-xanh-2-120.jpg",
  "Quyt": "https://traicay141.vn/upload/hinhthem/quytduong1111024x1024-6703.jpg",
  "Cam": "https://caogam.vn/sites/default/files/anh_bai_viet/tac-dung-cua-qua-cam-doi-voi-suc-khoe.jpg",
  "Mit": "https://cdn.chonongsanonline.com/uploads/all/bdDD4yggkRBWJu8xrUfTr97vrtFQpmYtSULlfH3l.jpg",
  "Buoi": "https://cayxanhdaiviet.vn/wp-content/uploads/2020/03/cay-buoi.jpg",
  "Oi": "https://cdn.baodongthap.vn/database/image/2015/12/02/cong-dung-bat-ngo2.jpg",
  "Thanh long": "https://congthuong-cdn.mastercms.vn/stores/news_dataimages/2023/022023/16/17/in_article/thanh-long-ruot-do20230216170904.png?rt=20230216170905",
  "Chom chom": "https://cdn.tgdd.vn/2022/07/CookDishThumb/tong-hop-10-cach-lam-banh-hanh-nhan-nuong-bang-lo-nuong-thom-thumb-620x620-1.jpg",
  "Du du": "https://hatgiongphuongnam.com/asset/upload/image/hat-giong-du-du-ruot-vang-1.2_.jpg?v=20190410",
};

class AppData{
  final List<Fruit> _dssp = [
    Fruit(id: "01", ten: "Táo", gia: 40000, anh: images["Tao"], mota: "Táo đỏ khác táo xanh"),
    Fruit(id: "02", ten: "Nho", gia: 60000, anh: images["Nho"], mota: "Nho ăn cho đẹp da"),
    Fruit(id: "03", ten: "Quýt", gia: 30000, anh: images["Quyt"], mota: "quýt ngọt"),
    Fruit(id: "04", ten: "Cam", gia: 45000, anh: images["Cam"], mota: "Cam để ép nước"),
    Fruit(id: "05", ten: "Mít", gia: 200000, anh: images["Mit"], mota: "Mít chia cho hàng xóm"),
    Fruit(id: "06", ten: "Bưởi", gia: 20000, anh: images["Buoi"], mota: "Bưởi để đơm"),
    Fruit(id: "07", ten: "Ổi", gia: 380000, anh: images["Oi"], mota: "không thích ăn ổi"),
    Fruit(id: "08", ten: "Thanh long", gia: 37500, anh: images["Thanh long"], mota: "Giải cứu thanh long"),
    Fruit(id: "09", ten: "Chôm chôm", gia: 79000, anh: images["Chom chom"], mota: "Chôm chôm đỏ"),
    Fruit(id: "10", ten: "Đu đủ", gia: 17000, anh: images["Du du"], mota: "đu đủ không thích ăn"),
  ];
  List<Fruit> get dssp => _dssp;
}