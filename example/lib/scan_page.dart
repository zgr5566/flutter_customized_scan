import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_customized_scan/scan_view.dart';

class ScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScanPageState();

}

class ScanPageState extends State<ScanPage> {

  late ScanController _controller;
  @override
  void initState() {
    super.initState();

    _controller = ScanController();
    _controller.addCallback((result) => (result){
      //二维码扫描回调
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("扫一扫"),),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child:ScanView(
          controller: _controller,
          child: Container(),
        ),
      ),
    );
  }
}
