import 'package:flutter/material.dart';
import 'package:gialuc63132245_flutter/Widgets/Dropdownbutton.dart';
import 'package:gialuc63132245_flutter/Widgets/My_radio_button.dart';
import 'package:gialuc63132245_flutter/Widgets/wrapper_data.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key, required String title});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? gioiTinh = "Nam";
  String? phepTinh = "Cộng";
  List<String> phepTinhs = ["Cộng", "Trừ", "Nhân", "Chia", "Đạo Hàm"];
  StringWrapper buoiHoc = StringWrapper(value: "Một");
  StringWrapper ny = StringWrapper(value: "Chưa");
  StringWrapper monhoc = StringWrapper(value: "Toán");
  DateTime? ngaysinh = DateTime(2003, 12, 30);
  int index =0;//Index cua
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My Profile"),
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/binhminh.jpg"),
              ),
                accountName: Text("Gia Lục"),
                accountEmail: Text("gialuc@gmail.com")
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InboxPage(),)
                );
              },
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("10"),
            )
          ],
        ),
      ),
      body: _BuildBody(context, index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.home,color: Colors.blue,),
            icon: Icon(Icons.home,color: Colors.grey,),
            label: "Home"
        ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.sms,color: Colors.blue,),
              icon: Icon(Icons.sms,color: Colors.grey,),
              label: "SMS"
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.phone,color: Colors.blue,),
              icon: Icon(Icons.phone,color: Colors.grey,),
              label: "Phone"
          )
        ],
        onTap: (value){
          setState(() {
            index=value;
          });
        }
      ),
    );
  }

  _BuildBody(BuildContext context, int index){
    switch(index){
      case 0: return _buildHome(context);
      case 1: return _build_SMS(context);
      case 2: return _buildPhone(context);
    }
  }
  _buildHome(BuildContext conText){
    return
     SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 400, height: 200,
                child: Image.asset("assets/images/binhminh.jpg"),
              ),
            ),
            SizedBox(height: 15,),
            Text("Họ tên: "),
            Text("Nguyễn Huỳnh Gia Lục",style: TextStyle(fontSize: 28, color: Colors.blue,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 15,),
            Text("Ngày sinh: "),
            Text("02/12/2003", style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal, color: Colors.black),),

            SizedBox(height: 20,),
            Text("Bạn có người yêu chưa"),
            MyGroupRadio(labels: ["Có", "Chưa"], groupValue: ny),
            Text("Bạn thực hành mấy buổi rồi"),

            MyGroupRadio(labels: ["Một", "Hai", "Chưa buổi naào"],
                groupValue: buoiHoc),
            Text("Ngày sinh:"), //ngày sinh
            Row( // phần lịch ngày tháng năm
              children: [
                Expanded(child:  Text("${ngaysinh?.day?? 1}/${ngaysinh?.month??
                    1}/${ngaysinh?.year?? 2023}")),
                IconButton(
                    onPressed: () async{

                      DateTime? d = await showDatePicker(
                        context: context,

                        firstDate: DateTime(1990),
                        lastDate: DateTime(2050),
                      );
                      if(d!=null) // chọn được ngày tháng năm
                        setState(() {
                          ngaysinh = d;
                        });
                    },
                    icon: Icon(Icons.calendar_month)
                ),
                SizedBox(width: 20,)

              ],
            ),

            Text("Bạn ghét nhất môn học gì"),
            MyDropdownButton(
              labels: ["Toán", "Học", "Tiếng Việt", "Anh Văn", "Hóa Học", "CNTT"],
              value: monhoc,
              itemBuilder: (label) => Row(
                children: [
                  Icon(Icons.emoji_food_beverage_outlined),
                  SizedBox(width: 30,),
                  Text(label),
                ],
              ),

            ),
            Text("Giới tính: ", style: TextStyle(fontSize: 20),),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text("Nam"),
                    leading: Radio(
                      value: "nam",//value = groupValue
                      // thì Radio được chọn
                      groupValue: gioiTinh,
                      onChanged: (value) {
                        setState(() {
                          gioiTinh = value as String?;
                        });
                      },

                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text("Nữ"),
                    leading: Radio(
                      value: "nu",//value = groupValue
                      // thì Radio được chọn
                      groupValue: gioiTinh,
                      onChanged: (value) {
                        setState(() {
                          gioiTinh = value as String?;
                        });
                      },

                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),
            Text("Sở thích:"),
            Text("Xem phim, nghe nhạc , cafe với bạn bè, chụp ảnh trong giờ rảnh rỗi", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.black),),
            SizedBox(height: 15,),
            Text("Phép tính giỏi nhất của bạn"),
            DropdownButton<String>(
                isExpanded: true,
                value: phepTinh,
                items: phepTinhs.map(
                        (phepTinh) => DropdownMenuItem(
                      child: Text(phepTinh),
                      value: phepTinh,
                    )
                ).toList(),
                onChanged: (value){
                  setState(() {
                    phepTinh = value;
                  });
                }
            )
          ],
        ),

      ),

    );
  }
  _build_SMS(BuildContext context){
    return
      Center(child: Text("SMS", style: TextStyle(fontSize: 30, color: Colors.yellow , fontWeight: FontWeight.bold),));

  }

  _buildPhone(BuildContext context){
    return
      Center(child: Text("Phone", style: TextStyle(fontSize: 30, color: Colors.blue , fontWeight: FontWeight.bold),));
  }
}

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inbox"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}


