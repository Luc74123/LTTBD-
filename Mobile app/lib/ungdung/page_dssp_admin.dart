import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:gialuc63132245_flutter/dialogs/dialogs.dart';
import 'package:gialuc63132245_flutter/helper/wiget_connect_firebase.dart';
import 'package:gialuc63132245_flutter/storage_image_helper.dart';
import 'package:gialuc63132245_flutter/ungdung/models.dart';
import 'package:gialuc63132245_flutter/ungdung/page_capnhat_sp_admin.dart';
import 'package:gialuc63132245_flutter/ungdung/page_chitiet_sp_admin.dart';
import 'package:http/http.dart';

class FruitStoreAdmin extends StatelessWidget {
  const FruitStoreAdmin({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      builder: (context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: PageDSSP_Admin(),
      ),
      errorMessage: "Lỗi!!!",
      connectingMessage: "Đang kết nối !!!",
    );
  }
}

class PageDSSP_Admin extends StatelessWidget {
  PageDSSP_Admin({super.key});
  BuildContext? myContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Danh Sách Trái Cây"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: StreamBuilder<List<FruitSnapshot>>(
          stream: FruitSnapshot.getAll(),
          builder: (context, snapshot){
            myContext = context;
            if(snapshot.hasError)
              return Center(child: Text("Lỗi!!!", style: TextStyle(color: Colors.red),),);
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);

            var list = snapshot.data!;
            return ListView.separated(
                itemBuilder: (context, index){
                  var fruitSnap = list[index];
                  return Slidable(
                      endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(

                              icon: Icons.remove_red_eye_rounded,
                              label: "Xem",
                              foregroundColor: Colors.green,
                              onPressed: (context){

                              },
                            ),
                            SlidableAction(
                              icon: Icons.edit,
                              label: "Cập Nhật",
                              foregroundColor: Colors.blue,
                              onPressed: (context){
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        PageCapNhatSp_admin(fruitSnapshot: fruitSnap,),
                                    ));
                              },
                            ),
                            SlidableAction(
                              icon: Icons.delete,
                              label: "Xóa",
                              foregroundColor: Colors.red,
                              onPressed: (context) async{

                                await deleteImage(folders: ["Fruit"], fileName: "${fruitSnap.fruit.id}.jpg");
                                await fruitSnap.xoa();
                              },
                            ),
                          ]
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Image.network(fruitSnap.fruit.anh!)
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("id: ${fruitSnap.fruit.id}"),
                                    Text("Tên: ${fruitSnap.fruit.ten}"),
                                    Text("Giá: ${fruitSnap.fruit.gia}"),
                                    Text("Mô tả: ${fruitSnap.fruit.mota?? ""}"),
                                  ],
                                ),
                              )
                          ),
                        ],
                      )
                  );
                },
                separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                itemCount: list.length
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) =>
              PageCTSP_Admin(),
            ));
        },
      ),
    );
  }
}

