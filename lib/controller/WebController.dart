import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebController extends ChangeNotifier {
  InAppWebViewController? _controller;
  bool _canBack = false;
  bool _canForward = false;

  bool _bookMarkIcon = false;

  List<String> _allBookMark = [];
  List<String> _allsearchString = [];
  String? _currentsearchString;
  String _currentUrl = "";

  String? _searchUrlData;

  Map allSearchEngine = {};
  String _Browser = 'Google';

  WebController() {
    allSearchEngine = {
      'Google': 'https://www.google.co.in/',
      'Bing': 'https://www.bing.com/',
      'DuckDuckGo': 'https://duckduckgo.com/',
      'Yahoo': 'https://in.search.yahoo.com/?fr2=inr',
      'DogPile': 'https://results.dogpile.com/',
    };
  }

  update() {
    notifyListeners();
  }

  get getsearchUrlData {
    return _searchUrlData;
  }

  setBrowser(String val) {
    _Browser = val;
    _controller!.loadUrl(
        urlRequest: URLRequest(url: Uri.parse(allSearchEngine[_Browser])));
    notifyListeners();
  }

  get getBeowser {
    return _Browser;
  }

  clearSearchData() {
    _searchUrlData = '';
    notifyListeners();
  }

  setSearchData({required String data}) {
    _currentsearchString = data;
    if (_Browser == 'Google') {
      _searchUrlData =
          'https://www.google.com/search?q=$data&sca_esv=565306219&sxsrf=AM9HkKl2LOBgJYOv9xWMQGpzFrxMcHtqsQ%3A1694687249306&ei=EeACZaqjEurAjuMPz-258AI&ved=0ahUKEwjq7__78amBAxVqoGMGHc92Di4Q4dUDCBA&uact=5&oq=$data&gs_lp=Egxnd3Mtd2l6LXNlcnAiB2ZsdXR0ZXIyBBAjGCcyBxAjGIoFGCcyDhAAGIoFGLEDGIMBGJECMg4QABiKBRixAxiDARiRAjIOEAAYigUYsQMYgwEYkQIyDhAAGIoFGLEDGIMBGJECMgsQABiABBixAxiDATIIEAAYgAQYsQMyCxAAGIAEGLEDGIMBMggQABiABBixA0jZQ1C2AljtQHACeAGQAQCYAd0BoAHdDqoBBTAuNy4zuAEDyAEA-AEBqAISwgIKEAAYRxjWBBiwA8ICChAAGIoFGLADGEPCAg4QABjkAhjWBBiwA9gBAcICEBAuGIoFGMgDGLADGEPYAQLCAg0QLhiDARixAxiKBRhDwgIQEC4YgAQYFBiHAhixAxiDAcICCBAuGLEDGIAEwgIHEAAYigUYQ8ICBRAAGIAEwgINEAAYigUYsQMYgwEYQ8ICDRAuGIoFGLEDGIMBGEPCAhwQLhiDARixAxiKBRhDGJcFGNwEGN4EGN8E2AEDwgIHEC4YigUYQ8ICERAuGIMBGMcBGLEDGNEDGIAEwgIWEC4YigUYQxiXBRjcBBjeBBjfBNgBA8ICBxAjGOoCGCfCAhMQLhiKBRjIAxjqAhi0AhhD2AECwgIUEC4YigUYsQMYgwEYxwEY0QMYkQLCAhEQLhiABBixAxiDARjHARjRA8ICBRAuGIAEwgITEC4YigUYsQMYgwEYxwEY0QMYQ8ICCBAAGIoFGJEC4gMEGAAgQYgGAZAGEroGBggBEAEYCboGBggCEAEYCLoGBggDEAEYFA&sclient=gws-wiz-serp';
    } else if (_Browser == 'DogPile') {
      _searchUrlData =
          'https://results.dogpile.com/serp?q=$data&sc=WWpbgfHLYmUL20';
    } else if (_Browser == 'Yahoo') {
      _searchUrlData =
          'https://in.search.yahoo.com/search;_ylt=AwrProk58QJlLJoKx_q6HAx.;_ylc=X1MDMjExNDcyMzAwMgRfcgMyBGZyAwRmcjIDcDpzLHY6c2ZwLG06c2ItdG9wBGdwcmlkA3BKUUswRjJfVGptUTR5T2JhUWo3UUEEbl9yc2x0AzAEbl9zdWdnAzEwBG9yaWdpbgNpbi5zZWFyY2gueWFob28uY29tBHBvcwMwBHBxc3RyAwRwcXN0cmwDMARxc3RybAM3BHF1ZXJ5A2ZsdXR0ZXIEdF9zdG1wAzE2OTQ2OTQ3ODg-?p=$data&fr=sfp&fr2=p%3As%2Cv%3Asfp%2Cm%3Asb-top&iscqry=';
    } else if (_Browser == 'Bing') {
      _searchUrlData =
          'https://www.bing.com/search?q=$data&form=QBLH&sp=-1&lq=0&pq=flut&sc=10-4&qs=n&sk=&cvid=2A20C767F0B541F19793188A096835EA&ghsh=0&ghacc=0&ghpl=';
    } else if (_Browser == 'DuckDuckGo') {
      _searchUrlData = 'https://duckduckgo.com/?t=h_&q=$data&ia=web';
    } else {
      _searchUrlData =
          'https://www.google.com/search?q=$data&sca_esv=565306219&sxsrf=AM9HkKl2LOBgJYOv9xWMQGpzFrxMcHtqsQ%3A1694687249306&ei=EeACZaqjEurAjuMPz-258AI&ved=0ahUKEwjq7__78amBAxVqoGMGHc92Di4Q4dUDCBA&uact=5&oq=$data&gs_lp=Egxnd3Mtd2l6LXNlcnAiB2ZsdXR0ZXIyBBAjGCcyBxAjGIoFGCcyDhAAGIoFGLEDGIMBGJECMg4QABiKBRixAxiDARiRAjIOEAAYigUYsQMYgwEYkQIyDhAAGIoFGLEDGIMBGJECMgsQABiABBixAxiDATIIEAAYgAQYsQMyCxAAGIAEGLEDGIMBMggQABiABBixA0jZQ1C2AljtQHACeAGQAQCYAd0BoAHdDqoBBTAuNy4zuAEDyAEA-AEBqAISwgIKEAAYRxjWBBiwA8ICChAAGIoFGLADGEPCAg4QABjkAhjWBBiwA9gBAcICEBAuGIoFGMgDGLADGEPYAQLCAg0QLhiDARixAxiKBRhDwgIQEC4YgAQYFBiHAhixAxiDAcICCBAuGLEDGIAEwgIHEAAYigUYQ8ICBRAAGIAEwgINEAAYigUYsQMYgwEYQ8ICDRAuGIoFGLEDGIMBGEPCAhwQLhiDARixAxiKBRhDGJcFGNwEGN4EGN8E2AEDwgIHEC4YigUYQ8ICERAuGIMBGMcBGLEDGNEDGIAEwgIWEC4YigUYQxiXBRjcBBjeBBjfBNgBA8ICBxAjGOoCGCfCAhMQLhiKBRjIAxjqAhi0AhhD2AECwgIUEC4YigUYsQMYgwEYxwEY0QMYkQLCAhEQLhiABBixAxiDARjHARjRA8ICBRAuGIAEwgITEC4YigUYsQMYgwEYxwEY0QMYQ8ICCBAAGIoFGJEC4gMEGAAgQYgGAZAGEroGBggBEAEYCboGBggCEAEYCLoGBggDEAEYFA&sclient=gws-wiz-serp';
    }
    _controller!.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(_searchUrlData!),
      ),
    );
  }

  setCurrenturl(String url) {
    _currentUrl = url;
    // notifyListeners();
  }

  addBookMark() {
    if (!_allBookMark.contains(_currentUrl)) {
      _allBookMark.add(_currentUrl);
      _allsearchString.add(_currentsearchString ?? '');
      notifyListeners();
    }
  }

  get allBookMark {
    return _allBookMark;
  }

  removeBookMark({required int index}) {
    _allBookMark.removeAt(index);
    notifyListeners();
  }

  removeSearchString({required int index}) {
    _allsearchString.removeAt(index);
    notifyListeners();
  }

  get allSearchString {
    return _allsearchString;
  }

  initController({required InAppWebViewController controller}) {
    _controller = controller;
    notifyListeners();
  }

  checkStatus() async {
    _canBack = await _controller!.canGoBack();
    _canForward = await _controller!.canGoForward();
    notifyListeners();
  }

  reload() {
    _controller!.reload();
    notifyListeners();
  }

  get canBack {
    checkStatus();
    return _canBack;
  }

  get canForward {
    checkStatus();
    return _canForward;
  }

  back() {
    _controller!.goBack();
    notifyListeners();
  }

  forward() {
    _controller!.goForward();
    notifyListeners();
  }

  setBookMarkIcon({required bool value}) {
    _bookMarkIcon = value;
    notifyListeners();
  }

  get getBookMarkIcons {
    return _bookMarkIcon;
  }

  checkBookMarkIcon({required String url}) {
    if (_allBookMark.contains(url)) {
      setBookMarkIcon(value: true);
    } else {
      setBookMarkIcon(value: false);
    }
  }
}
