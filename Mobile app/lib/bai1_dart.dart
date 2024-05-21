class SinhVien{
  String id, ten;
  String? ngaySinh, queQuan;

  SinhVien({required this.id,required this.ten,required this.ngaySinh,required this.queQuan});

  @override
  String toString() {
    return 'SinhVien{id: $id, ten: $ten, ngaySinh: $ngaySinh, queQuan: $queQuan}';
  }
}

class QL_SinhVien{
  List<SinhVien> list = [];
  void add(SinhVien sv){
    list.add(sv);
  }
  void inDS(){
    for(SinhVien sv in list)
      print(sv.toString());
  }
}
void main(){
  SinhVien sv1 = SinhVien(id: "01", ten: "thanh thao", ngaySinh: "01/01/2003", queQuan: "khanh hoa");
  SinhVien sv2 = SinhVien(id: "02", ten: "van a", ngaySinh: "02/02/2003", queQuan: "khanh hoa");
  QL_SinhVien ql_sinhVien = QL_SinhVien();
  ql_sinhVien.add(sv1);
  ql_sinhVien.add(sv2);
  ql_sinhVien.inDS();
}