import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/controller/WebController.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WebController>(
      builder: (context, pro, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("HomePage"),
            centerTitle: true,
            actions: [],
          ),
          body: Column(
            children: [
              TextField(
                onSubmitted: (val) {
                  pro.setUri(uri: val);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        'https://www.google.com/search?q=${pro.data}&oq=&aqs=chrome.2.35i39i362l8.3835j0j15&sourceid=chrome&ie=UTF-8'),
                  ),
                  onLoadStart: (controller, uri) {
                    pro.initController(controller: controller);
                    print("hello : ${uri}");
                  },
                  onLoadStop: (controller, uri) {
                    pro.initController(controller: controller);
                    print("Stop: ${uri}");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
