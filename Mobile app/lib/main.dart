import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/App_state/page_counter.dart';
import 'package:gialuc63132245_flutter/list_provider/giohang_app_ntu.dart';
import 'package:gialuc63132245_flutter/page_home.dart';
import 'package:gialuc63132245_flutter/profile/page_profile.dart';
import 'package:get/get.dart';
import 'Form/page_form_mathang.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PageHome(title: "PageHome"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController nameController = TextEditingController();

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Text("$_counter"),
            ElevatedButton(onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },child: Icon(Icons.call)),
            ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(
                      content: Text("This is snackbar"),
                      duration: Duration(seconds: 5),
                      action: SnackBarAction(label: "close", onPressed: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                      },),
                  ));
                },
                child: Text("Show snackbar")),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "name", hintText: "Nhap ten vao day"),
            ),
            ElevatedButton(
                onPressed: () {
                  print("${nameController.text}");
                },
                child: Text("Submit")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),//this trailing comma makes auto-formatting nicer for build methos
    );
  }
}