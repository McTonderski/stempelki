import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class DisplayUserQR extends StatefulWidget {
  DisplayUserQR({Key? key}) : super(key: key);

  @override
  State<DisplayUserQR> createState() => _DisplayUserQRState();
}

class _DisplayUserQRState extends State<DisplayUserQR> {
  String uid = "";
  void loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("uid")){
      uid = prefs.get("uid") as String;
    }
  }
  @override
  void initState() {
    loadPrefs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: QrImage(
      data: uid,
      version: QrVersions.auto,
      size: 200.0,
    ),);
  }
}