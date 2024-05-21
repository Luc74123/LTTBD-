
import 'dart:math';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gialuc63132245_flutter/getx/get_counter.dart';
import 'package:gialuc63132245_flutter/helper/wiget_connect_firebase.dart';
import 'package:gialuc63132245_flutter/list_provider/giohang_app_ntu.dart';
import 'package:gialuc63132245_flutter/ungdung/controlllers.dart';

import 'package:gialuc63132245_flutter/ungdung/models.dart';
import '../helper/wiget_connect_firebase.dart';


class FruitStoreApp extends StatelessWidget {
  const FruitStoreApp({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      errorMessage: "Lỗi kết nối Firebase",
      connectingMessage: "Đang kết nối...",
      builder:(context) => GetMaterialApp(
        initialBinding: FruitStoreBindings(),
        debugShowCheckedModeBanner: false,
        home: PageHome(),
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
        title: Text("Fruit Market"), backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      ),
      body: GetBuilder<SimpleControllerSP>(
        id: "ListSP",
        builder: (controller) {
          return GridView.extent(
            maxCrossAxisExtent: 300,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: controller.dssp.map(
                    (sp) => GestureDetector(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PageChiTiet(sp),)
                  ),
                  child: Card(
                    elevation: 0.5,
                    child: Column(
                      children: [
                        Expanded(
                            child: sp.anh != null ? AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(sp.anh!)
                            ):Icon(Icons.image_not_supported)
                        ),
                        Text(sp.ten),
                        Text("${sp.gia}", style: TextStyle(color: Colors.red),)
                      ],
                    ),
                  ),
                )
            ).toList(),
          );
        },
      ),
    );
  }
}

class PageChiTiet extends StatelessWidget {
  Fruit sp;
  PageChiTiet(this.sp,{super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width*0.9;
    double rating = Random().nextInt(21)/10.0+3;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          GetBuilder<SimpleControllerSP>(
            id: "gioHang",
            builder: (controller) {
              return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: badges.Badge(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => GioHangPage())
                      );},
                    child: badges.Badge(
                      showBadge: controller.slMHGH > 0 ,
                      child: Icon(Icons.shopping_cart_outlined),
                      badgeContent: Text("${controller.slMHGH}"),
                    ),
                  ));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w,
                child: sp.anh != null? Image.network(sp.anh!):Icon(Icons.hide_image_rounded),
              ),
              Text(sp.ten, style: TextStyle(fontSize: 20),),
              Row(
                children: [
                  Text("${sp.gia} Vnđ", style: TextStyle(color: Colors.red, fontSize: 20),),
                  SizedBox(width: 20),
                  Text("${sp.gia*1.5} Vnđ", style: TextStyle(fontSize: 20, decoration: TextDecoration.lineThrough),),
                ],
              ),
              Row(
                children: [
                  Text("${sp.mota}", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                ],
              ),
              Row(
                children: [
                  RatingBar.builder(
                    //tapOnlyMode: true,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Text("${rating}", style: TextStyle(fontSize: 20, color: Colors.red),),
                  SizedBox(width: 15,),
                  Text("đánh giá", style: TextStyle(fontSize: 20),),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SimpleControllerSP.controller.themVaoGH(sp, updateWidgetIds: ["gioHang"]);
        },
        child: Icon(Icons.add_shopping_cart, color: Colors.purple,),
      ),
    );
  }
}

class GioHangPage extends StatelessWidget {
  const GioHangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gio hang"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      ),
    );
  }
}