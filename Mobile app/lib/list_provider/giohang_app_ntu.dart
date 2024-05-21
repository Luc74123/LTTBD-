import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/list_provider/app_state.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
//goi o trang home
class AppStoreNTU extends StatelessWidget {
  const AppStoreNTU({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppStateNTU(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FruitSotreHomePage (),
        ),
    );
  }
}

class FruitSotreHomePage extends StatelessWidget {
  const FruitSotreHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppStateNTU appStateNTU = context.watch<AppStateNTU>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit Store NTU"),

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: badges.Badge(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                      GioHangPage(),)
                );
              },
              showBadge: appStateNTU.sLMH_GioHang>0,
              badgeContent: Text('${appStateNTU.sLMH_GioHang}', style: TextStyle(color: Colors.white),),
              child: Icon(Icons.shopping_cart_outlined),
            ),
          )
        ],
      ),
      body:  ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(appStateNTU.dssp[index]),
              trailing: IconButton(
                onPressed: () {
                  AppStateNTU readState = context.read<AppStateNTU>();
                  readState.them(index);
                },
                icon:appStateNTU.mhCotrongGioHang(index) == false?
                  Icon(Icons.add) :
                  Icon(Icons.check),

              ),
            );
          },
          separatorBuilder: (context, index) => Divider
            (thickness: 1.5,),
          itemCount: appStateNTU.dssp.length,
      ),
    );
  }
}

class GioHangPage extends StatelessWidget {
  const GioHangPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppStateNTU appStateNTU = context.watch<AppStateNTU>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    int id = appStateNTU.gioHang[index];
                    return ListTile(

                      title: Text(appStateNTU.dssp[id]),
                      trailing: IconButton(
                        onPressed: () {
                            AppStateNTU xoaState = context.read<AppStateNTU>();
                            xoaState.xoaMH_trong_GH(index);
                        },
                        icon: Icon(Icons.remove_circle_outline),
                      ),
                    );
                  },
                  
                  separatorBuilder: (context, index) => Divider
                    (thickness: 1.5,),
                  itemCount: appStateNTU.gioHang.length
              )
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Tổng số tiền:"),
                Text("${appStateNTU.sLMH_GioHang * 499990} vnd", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
              ],
            ),
          )
        ],
      ),
    );
  }
}



