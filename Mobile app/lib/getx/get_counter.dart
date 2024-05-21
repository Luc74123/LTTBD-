import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  final _counter = 0.obs; // biến reactive RxInt
  int get counter => _counter.value;

  void tang(){
    _counter.value++;
    //_counter.refresh(); Không cần gọi vì int là kiểu dữ liệu primitive
  }
  void giam(){
    _counter.value--;
  }

}

class PageGetxCounter extends StatelessWidget {
   PageGetxCounter ({super.key, required String title});
  final c = Get.put(Controller()); // no bi loi thi xoa từ "const" trên PageGetxCounter
   final d = Get.put(Controller(), tag: "tag");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Getx"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  c.tang();
                  d.tang();
                },
                child: Text("+", style: TextStyle(fontSize: 20),),
            ),
            GetX<Controller>(
                builder: (controller) => Text("Getx c: ${controller.counter}", style: TextStyle(fontSize: 20),),
            ),
            GetX<Controller>(
                tag: "tag",
                builder: (controller) => Text("Getx d: ${controller.counter}", style: TextStyle(fontSize: 20),),
            ),
            Obx(() => Text("Obx c: ${c.counter}", style: TextStyle(fontSize: 20),),),
            Obx(() => Text("Obx d: ${d.counter}", style: TextStyle(fontSize: 20),),),
            ElevatedButton(
                onPressed: () {
                  c.giam();

                },
                child: Text("-"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(PageHome(),);
        },
        child: Icon(Icons.call),
      ),
    );
  }
}

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}

