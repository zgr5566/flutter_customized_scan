# flutter_customized_scan

这是可以自定义UI的Flutter扫码插件，基于[HUAWEI ScanKit](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides-V5/service-introduction-0000001050041994-V5) SDK。
思路源于[flutter-scankit](https://github.com/arcticfox1919/flutter-scankit)
因为他的项目不能自定义UI，所以我基于他的思路重新做了一个可以自定义UI的插件

## 用法

使用前请自行处理权限问题，可以参照[flutter-scankit](https://github.com/arcticfox1919/flutter-scankit)这个项目进行

```dart
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
```

