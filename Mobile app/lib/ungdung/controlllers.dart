import 'package:get/get.dart';
import 'models.dart';

class SimpleControllerSP extends GetxController{
  List<Fruit> _dssp = [];
  List<GioHang_item> _gioHang = [];

  List<Fruit> get dssp => _dssp;
  List<GioHang_item> get gioHang => _gioHang;
  int get slMHGH => _gioHang.length;

  static SimpleControllerSP get controller => Get.find<SimpleControllerSP>();

  @override
  void onReady(){
    super.onReady();
    docDL();
  }

  Future<void> docDL() async{
    var list = await FruitSnapshot.getAll2();
    _dssp = list.map((fruitSnap) => fruitSnap.fruit).toList();
    update(["listSP"]);
  }

  void themVaoGH(Fruit sp, {List<String>? updateWidgetIds}){
    for(GioHang_item item in gioHang)
      if(item.idSP == sp.id){
        item.sl++;
        return;
      }
    gioHang.add(GioHang_item(idSP: sp.id, sl: 1));
    update(updateWidgetIds);
  }

// @override
// void onInit() {
//   _dssp = AppData().dssp;
//   update(["ListSP"]);
// }
}

class FruitStoreBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SimpleControllerSP());
  }
}