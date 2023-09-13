import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebController extends ChangeNotifier {
  InAppWebViewController? controller;
  String data = 'https://www.google.co.in/';

  setUri({required String uri}) {
    this.data = data;
    controller!.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(
            'https://www.google.com/search?q=${data}&oq=&aqs=chrome.2.35i39i362l8.3835j0j15&sourceid=chrome&ie=UTF-8'),
      ),
    );
    notifyListeners();
  }

  bool goBack = false;
  bool goForward = false;

  initController({required InAppWebViewController controller}) {
    this.controller = controller;
    notifyListeners();
  }

  canGoBack() async {
    goBack = await controller!.canGoBack();
    notifyListeners();
  }

  canGoForward() async {
    goBack = await controller!.canGoForward();
    notifyListeners();
    notifyListeners();
  }

  checkAvailability() {
    canGoBack();
    canGoForward();
    notifyListeners();
  }

  get back {
    controller!.goBack();
  }

  get forward {
    controller!.goForward();
  }
}
