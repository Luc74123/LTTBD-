import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/json_list/json_data.dart';
import 'package:flutter/cupertino.dart';

class PageListPhotosMMT extends StatelessWidget {
  const PageListPhotosMMT({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PageListPhotosMMT"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: FutureBuilder<List<PhotoMMT>?>(
          future: getHTTP_Content(),
          builder: (context, snapshot){
            if(snapshot.hasError)
              return Center(child:Text("Lai bi loi "),);
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
            List<PhotoMMT> list = snapshot.data!;
            return GridView.extent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: list.map((photo) => Image.network(photo.url!)).toList(),

            );
          },
        )
    );
  }
}




 
