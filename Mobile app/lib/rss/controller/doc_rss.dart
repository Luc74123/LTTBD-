import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

String _rssURLVNExpress = "https://vnexpress.net/rss/tin-moi-nhat.rss";
void main() async{
  final response = await http.get(Uri.parse(_rssURLVNExpress));
  if(response.statusCode == 200){
    final xml2Json = Xml2Json();
    xml2Json.parse(utf8.decode(response.bodyBytes));
    String rssJson = xml2Json.toParker();
    // print(rssJon);
    Map<String, dynamic> jsonData = jsonDecode(rssJson);
    var testData = jsonData["rss"]["channel"]["item"][0];
    //print(testData);
    print(testData['title']);
    print(testData['Link']);
    print(testData['description']);
    print(testData['pubDate']);
  }
}

