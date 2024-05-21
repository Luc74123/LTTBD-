import 'package:url_launcher/url_launcher.dart';

Future<bool> openPhoneDial (String phoneNumber) async{
  bool check = await canLaunchUrl(Uri.parse('tel:$phoneNumber'));
  if(check == false) return false;
  else return launchUrl(Uri.parse('tel:$phoneNumber'));
}
Future<bool> openSMS(String phoneNumber) async{
  bool check = await canLaunchUrl(Uri.parse('sms:$phoneNumber'));
  if(check == false) return false;
  else return launchUrl(Uri.parse('sms:$phoneNumber'));
}