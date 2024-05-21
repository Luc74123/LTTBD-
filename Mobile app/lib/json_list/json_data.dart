import 'dart:convert';
import 'package:http/http.dart' as http;

// {
// "albumId": 1, so nguyen
// "id": 1,
// "title": "accusamus beatae ad facilis cum similique qui sunt", kieu chuoi
// "url": "https://via.placeholder.com/600/92c952",
// "thumbnailUrl": "https://via.placeholder.com/150/92c952"
// },

class PhotoMMT{
  int albumId, id;
  String title, url, thumbnailUrl;

  PhotoMMT({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'albumId': this.albumId,
      'id': this.id,
      'title': this.title,
      'url': this.url,
      'thumbnailUrl': this.thumbnailUrl,
    };
  }

  factory PhotoMMT.fromJson(Map<String, dynamic> map) {
    return PhotoMMT(
      albumId: map['albumId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      url: map['url'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
    );
  }
}

// lop du leu
Future<List<PhotoMMT>> getHTTP_Content() async{
  Uri uri =Uri.parse("https://jsonplaceholder.typicode.com/photos");
  var response = await http.get(uri);
  if(response.statusCode == 200){
    List<dynamic> list = jsonDecode(response.body) as List;
    List<PhotoMMT> photos = list.map((photoJson) => PhotoMMT.fromJson(photoJson)).toList();
    return photos;

  }
  return Future.error("Lỗi tải dữ liệu");
}