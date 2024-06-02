import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:gialuc63132245_flutter/helper/wiget_connect_firebase.dart';
import 'package:gialuc63132245_flutter/phone_app/page_capnhat_phone.dart';
import 'package:gialuc63132245_flutter/phone_app/showSnackBar_phone.dart';


import 'package:gialuc63132245_flutter/phone_app/page_chitiet_phone.dart';
import 'package:gialuc63132245_flutter/phone_app/phone_model.dart';
import 'package:gialuc63132245_flutter/phone_app/models_upload_image.dart';
import 'package:url_launcher/url_launcher.dart';
//Trang thong tin Danh ba(trang chu) + Trang xem chi tiet (detail)
class PhonePage extends StatelessWidget {
  const PhonePage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      errorMessage: "Lỗi",
      connectingMessage: "Đang kết nối",
      builder: (context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: PageDSPhone(),
      ),
    );
  }
}

class PageDSPhone extends StatelessWidget {
  PageDSPhone({super.key});
  BuildContext? myContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DANH BẠ", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<PhoneSnapshot>>(
          stream: PhoneSnapshot.getAll(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text("Lỗi rồi"),);
            }
            if(!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),);
            List<PhoneSnapshot> list = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) {
                PhoneSnapshot ps = list[index];

                return Slidable(
                  endActionPane: ActionPane(
                    extentRatio: 0.6,
                    motion: const ScrollMotion(),


                    children: [
                      //Detail
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder:
                                  (context) => PageDetail(phoneSnapshot: ps),
                              )
                          );
                        },
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.info,
                        label: 'Detail',
                      ),

                      //Edit
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder:
                                  (context) => PageCapNhapPhone(phoneSnapshot: ps),
                              )
                          );
                        },
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),

                      //xoa
                      SlidableAction(
                        onPressed: (context) async{
                          // String? result = await showConfirmDialog(context, "Bạn có chắc chắn muốn xóa không?");
                          // if(result == "ok"){
                          await deleteImage(folders: ["phone_app"], fileName: "${ps.phone.id}.jpg");
                          await ps.xoa( ps.phone);
                          //}

                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        //c1: anh to theo expanded
                        //child: Image.network(fs.fruit.image!, ),
                        //c2: dung ListTile de CircleAvatar cai image.network
                        child: Image.network(ps.phone.image!, ),
                        // child: ListTile(
                        //   leading: CircleAvatar(
                        //     radius: 40,
                        //     child: ClipOval(
                        //       child: Image.network(fs.fruit.image!, width: 50, height: 50, fit: BoxFit.cover,),
                        //        ),
                        //        //child: Image.network(fs.fruit.image!,),
                        //      ),
                        //    ),
                      ),

                      Expanded(
                        flex: 2 ,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Tên: ${ps.phone.ten}", style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  Text("sdt: ${ps.phone.sdt}"),
                                ],
                              ),
                              Icon(Icons.phone),
                            ],

                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(thickness: 1.5,),
              itemCount: list.length,
            );

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PageCTPhone())
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



//trang xem chi tiet(Detail)
class PageDetail extends StatelessWidget {
  final PhoneSnapshot phoneSnapshot;

  const PageDetail({Key? key, required this.phoneSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${phoneSnapshot.phone.ten}",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                child: ClipOval(//cat cac widget con theo hinh oval, do no la con cua Circle nen no se cat theo Circle
                    child: Image.network("${phoneSnapshot.phone.image}",
                      fit: BoxFit.cover,//thiet lap phu anh theo Oval ma khong bi bien dang
                      width: 200,
                      height: 200,
                    )
                ),
              ),
              SizedBox(height: 20,),
              Text("${phoneSnapshot.phone.ten}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${phoneSnapshot.phone.sdt} ",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    //Icon(Icons.message, color: Colors.blue,),
                    ElevatedButton(
                      onPressed: () {
                        openSMS(phoneSnapshot.phone.sdt);
                      },
                      child: Icon(Icons.message),
                    ),
                    Icon(Icons.phone, color: Colors.blue,),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              //mo ta
              Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.black,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.info, color: Colors.blue,),
                      Text("${phoneSnapshot.phone.mota} ",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.phone),
        onPressed: (){
          openPhoneDial(phoneSnapshot.phone.sdt);
        },
      ),
    );
  }
}
Future<bool> openPhoneDial(String phoneNumber) async{
  bool check = await canLaunchUrl(Uri.parse('tel:$phoneNumber'));
  if(check ==false) return false;
  else return launchUrl(Uri.parse('tel:$phoneNumber'));
}

Future<bool> openSMS(String phoneNumber) async{
  bool check = await canLaunchUrl(Uri.parse('sms:$phoneNumber'));
  if(check ==false) return false;
  else return launchUrl(Uri.parse('sms:$phoneNumber'));
}

