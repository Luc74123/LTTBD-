import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/App_state/changenotifier.dart';
import 'package:provider/provider.dart';


class CounterProvider extends StatelessWidget {
  const CounterProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterState(),
      child: PageCounter(),
    );
  }
}

class PageCounter extends StatelessWidget {
  const PageCounter({super.key});

  @override
  Widget build(BuildContext context) {
    // var counterState = context.watch<CounterState>();
    int? v;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ví dụ Provider"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          // can giua truc doc
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                var c = context.read<CounterState>();
                c.tang();
              },
              child: Text("+", style: TextStyle(fontSize: 20),),

            ),
            // Text("0",style: TextStyle(fontSize: 30),),
            Consumer<CounterState>(
              child: Text("$v", style: TextStyle(fontSize: 20, color: Colors.red),),
              builder: (context, value, child) {
                v = value.count;
                print("Gia tri v: $v");
                return Column(
                  children: [
                    Text("${value.count}", style: TextStyle(fontSize: 20,),),
                    child!
                  ],
                );
              } ,
            ),
            ElevatedButton(
                onPressed: (){
                  var c = context.read<CounterState>();
                  c.giam();
                },
                child: Column(
                  children: [
                    Text("-", style: TextStyle(fontSize: 20),),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}