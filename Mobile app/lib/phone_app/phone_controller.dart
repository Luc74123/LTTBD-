import 'package:get/get.dart';
import 'package:gialuc63132245_flutter/phone_app/phone_model.dart';

class AppDataController extends GetxController{
  List<Phone> _dssp = [];

  List<Phone> get dssp => _dssp;
  //static thi no se cho ban truy cap vao thanh phan static ma khong can khoi tao doi tuong,
  // vd:co the goi truc tiep AppDataController.instance nhu vay ma khong can phai khoi tao doi tuong AppDataController

  static AppDataController get instance => Get.find<AppDataController>();

  @override
  void onReady() {
    super.onReady();
    docDL();
  }
  Future<void> docDL() async{
    var list = await PhoneSnapshot.getAll2();
    _dssp = list.map((phoneSnap) => phoneSnap.phone).toList();
    update(["phone_app"]);
  }
}
//Quản lý và tạo controller
class AppDataBindings extends Bindings{

  @override
  void dependencies() {
    Get.put(AppDataController());

  }
}
