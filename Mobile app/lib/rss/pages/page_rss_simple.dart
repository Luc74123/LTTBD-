
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gialuc63132245_flutter/rss/controller/rss_controller_simple.dart';
import 'package:gialuc63132245_flutter/rss/pages/webview.dart';

class RssAPP extends StatelessWidget {
  const RssAPP ({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: RssBlingds(),
      home: PageRssSimple(),
    );
  }
}

class PageRssSimple extends StatelessWidget {
  const PageRssSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SimpleControllerRss.instance.resourceName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GetBuilder<SimpleControllerRss>(
        id: "listRss",
        init: SimpleControllerRss.instance,
        builder: (controller) {
          var list = controller.rssList;
          return ListView.separated(
              itemBuilder: (context, index) {
                var rss = list[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap:() {
                        Get.to(MyPage(
                            url: rss.link!,
                            nameResource: SimpleControllerRss.instance.resourceName)
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Image(image: NetworkImage(rss.imageUrl!)),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(rss.title!),
                            flex: 2,
                          ),
                        ],
                      ),
                    ),
                    Text(rss.description!)
                  ],
                );
              },
              separatorBuilder: (context, index) => Divider(thickness: 1.5),
              itemCount: list.length
          );
        },
      ),
    );
  }
}

