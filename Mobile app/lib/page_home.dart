import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/Form/page_form_mathang.dart';

import 'package:gialuc63132245_flutter/getx/get_counter.dart';
import 'package:gialuc63132245_flutter/json_list/page_list.dart';

import 'package:gialuc63132245_flutter/list_provider/giohang_app_ntu.dart';
import 'package:gialuc63132245_flutter/profile/page_profile.dart';
import 'package:gialuc63132245_flutter/rss/pages/page_rss_simple.dart';
import 'package:gialuc63132245_flutter/test_phone/phone.dart';
import 'package:gialuc63132245_flutter/ungdung/Home_page_fruit.dart';
import 'package:gialuc63132245_flutter/ungdung/page_dssp_admin.dart';

class PageHome extends
StatelessWidget {
  const PageHome({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
        .colorScheme.inversePrimary,
        title: Text("My App"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
          children: [
            _buildButton(context, label: "My Profile",
            destination: const MyProfile(title: 'MyProfile',)),
            _buildButton(context, label: "List view",
            destination:  PageFormMatHang(title: 'PageListView',)),
            _buildButton(context, label: "Fruits Store",
            destination: const AppStoreNTU(title: 'AppStore',)),
            _buildButton(context, label: "Getx",
            destination: PageGetxCounter(title: 'AppStore',)),
            _buildButton(context, label: "Fruit Store NTU",
            destination: PageGetxCounter(title: 'AppStore',)),
            _buildButton(context, label: "Fruit Store App",
            destination:  FruitStoreApp(title: 'Page_Fruit',)),

            _buildButton(context, label: "Photo",
            destination:  PageListPhotosMMT(title: 'PhoTos MTT',)),
            _buildButton(context, label: "RssApp",
            destination:  RssAPP(title: 'RssAPP',)),
            _buildButton(context, label: "FruitStoreAdmin",
            destination:  FruitStoreAdmin(title: 'Danh sách trái cây',)),
            _buildButton(context, label: "Phone",
            destination:  PagePhone(title: 'Điện thoại',)),





          ],
        ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required String label, required Widget destination}) {
    return Container(
            width: 180,
             child: ElevatedButton(
              onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=> destination,)

                  );
              },
              child: Text(label)
          ),
          );
  }
}


