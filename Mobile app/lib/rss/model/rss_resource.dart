import 'dart:convert';
import 'package:http/http.dart' as http;

class RssResource{

  String id, name;
  String startDescriptionRegrex, endDescriptionRegrex;
  String startImageRegrex, endImageRegrex;
  Map<String, String> resourceHeaders;

  RssResource({
    required this.id,
    required this.name,
    required this.startDescriptionRegrex,
    required this.endDescriptionRegrex,
    required this.startImageRegrex,
    required this.endImageRegrex,
    required this.resourceHeaders,
  });

}

List<RssResource> rssResource = [
  RssResource(
      id: "vnexpress", name: "VN Express",
      startDescriptionRegrex: "</a></br>", endDescriptionRegrex: "",
      startImageRegrex: '<img src="', endImageRegrex: '"',
      resourceHeaders: {
        "Trang chủ" : "https://vnexpress.net/rss/tin-moi-nhat.rss",
        "Thế giới" : "https://vnexpress.net/rss/the-gioi.rss",
        "Thời sự" : "https://vnexpress.net/rss/thoi-su.rss",
        "Kinh doanh" : "https://vnexpress.net/rss/thoi-su.rss",
        "Sức khỏe" : "https://vnexpress.net/rss/suc-khoe.rss",
        "Đời sống" : "https://vnexpress.net/rss/gia-dinh.rss",
        "Du lịch" : "https://vnexpress.net/rss/du-lich.rss",
        "Khoa học" : "https://vnexpress.net/rss/khoa-hoc.rss",
        "Giải trí" : "https://vnexpress.net/rss/giai-tri.rss",
        "Thể thao" : "https://vnexpress.net/rss/the-thao.rss"
      }
  ),// VN Express
  RssResource(
      id: "dantri", name: "Dân trí",
      startDescriptionRegrex: "</a></br>", endDescriptionRegrex: "", startImageRegrex: "<img src='", endImageRegrex: '"',
      resourceHeaders: {
        "Trang chủ" : "https://dantri.com.vn/rss/home.rss",
        "Xã hội" : "https://dantri.com.vn/rss/xa-hoi.rss",
        "Giáo dục": "https://dantri.com.vn/rss/giao-duc.rss",
        "Văn Hóa": "https://dantri.com.vn/rss/van-hoa.rss",
        "Du lịch": "https://dantri.com.vn/rss/du-lich.rss",
      }
  ),
  RssResource(
      id: "thanhnien", name: "Thanh Niên",
      startDescriptionRegrex: "</a>", endDescriptionRegrex: "",
      startImageRegrex: "<img src='", endImageRegrex: '"',
      resourceHeaders: {
        "Trang chủ" : "https://thanhnien.vn/rss/home.rss",
        "Thời sự" : "https://thanhnien.vn/rss/thoi-su.rss",
        "Chào ngày mới" : "https://thanhnien.vn/rss/chao-ngay-moi.rss",
        "Thế giới" : "https://thanhnien.vn/rss/the-gioi.rss",
        "Giới trẻ" : "https://thanhnien.vn/rss/gioi-tre.rss",
        "Tiêu dùng thông minh" : "https://thanhnien.vn/rss/tieu-dung-thong-minh.rss",

      }
  ),
  RssResource(
      id: "tuoitre", name: "Tuổi Trẻ",
      startDescriptionRegrex: "</a>", endDescriptionRegrex: "",
      startImageRegrex: '<img src="', endImageRegrex: '"',
      resourceHeaders: {
        "Trang chủ" : "https://tuoitre.vn/rss/tin-moi-nhat.rss",
        "Thế giới" : "https://tuoitre.vn/rss/the-gioi.rss",
        "Kinh Doanh" : "https://tuoitre.vn/rss/kinh-doanh.rss",
        "Xe" : "https://tuoitre.vn/rss/xe.rss",
        "Văn Hóa" : "https://tuoitre.vn/rss/van-hoa.rss",


      }
  ),


];
