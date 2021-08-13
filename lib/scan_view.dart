import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ScanView extends StatefulWidget {
  Widget child;
  ScanController? controller;

  ScanView({required this.child, this.controller});

  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  late NativeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NativeController((result) => _dealCallback(result));
  }

  _dealCallback(String? result){
   if(widget.controller != null && widget.controller!.callback != null){
     widget.controller!.callback!.call(result);
   }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getCameraPreView(),
        widget.child,
      ],
    );
  }

  Widget _getCameraPreView() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: "CustomizedScanView",
          onPlatformViewCreated: _onpPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: "CustomizedScanView",
          onPlatformViewCreated: _onpPlatformViewCreated,
        );
      default:
        return Container();
    }
  }

  _onpPlatformViewCreated(int id) {
    _controller.onCreate(id);
  }
}

class NativeController {
  late MethodChannel _channel;
  Function(String? result) _callback;
  Future<dynamic> Function(MethodCall call)? handler;

  NativeController(this._callback);

  onCreate(int id) {
    handler = (call) => _dealMethodCall(call);
    _channel = MethodChannel("flutter_customized_scan_$id");
    _channel.setMethodCallHandler(handler);
  }

  void invokeMethod(String method, [dynamic arguments]) {
    try {
      _channel.invokeMethod(method, arguments);
    } catch (e) {}
  }

  _dealMethodCall(MethodCall methodCall) {
    if (methodCall.method == "result") {
      Object? argument = methodCall.arguments;
      if (argument is String) {
        String result = argument;
        _callback(result);
      }
    }
  }
}

class ScanController {
  Function(String? result)? callback;

  addCallback(Function(String? result) callback) {
    this.callback = callback;
  }
}
