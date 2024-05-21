import 'dart:math';

Future<int> LateNum() async{
    int num = await Future.delayed(
        Duration(
      seconds:3,
    ),
    () => Random().nextInt(100),
    );
    return num;
}


void main(){
  //BT4

  List<String> list = [
    "Nha Trang", "Hà Nội", "Huế", "Vũng Tàu", "TP HCM"
  ];
  List<int> cd = list.map((e) => e.length).toList();
  print(list);
  print(cd);

  cd.forEach((element) {
    print(element*element);
  });
  //BT5
  //cách 1

  //cach 2
  print("Doi chut....");
  LateNum().then((value)=> print(value));
  print("Tam biet");
}