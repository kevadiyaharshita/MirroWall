import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gap/gap.dart';
import 'package:mirror_wall/controller/WebController.dart';
import 'package:mirror_wall/controller/searchController.dart';
import 'package:provider/provider.dart';

import '../../utils/style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double w = s.width;
    double h = s.height;

    return Consumer<WebController>(
      builder: (context, pro, _) {
        return WillPopScope(
          onWillPop: () async {
            if (pro.canBack) {
              pro.back();
            }
            return !pro.canBack;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("HomePage"),
              centerTitle: true,
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.bookmark),
                          ),
                          Gap(15),
                          Text("All BookMark"),
                        ],
                      ),
                      value: 'BK',
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.screen_search_desktop),
                          ),
                          Gap(15),
                          Text(
                            "Search Engine",
                          ),
                        ],
                      ),
                      value: 'SE',
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'SE') {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Search Engine",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          children: [
                            TextButton(
                              onPressed: () {
                                pro.setBrowser('Google');
                                pro.clearSearchData();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Google",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                pro.setBrowser('Yahoo');
                                pro.clearSearchData();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Yahoo",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                pro.setBrowser('DogPile');
                                pro.clearSearchData();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "DogPile",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                pro.setBrowser('Bing');
                                pro.clearSearchData();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Bing",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                pro.setBrowser('DuckDuckGo');
                                pro.clearSearchData();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "DuckDuckGo",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ).then((value) => pro.update());
                    }
                    if (value == 'BK') {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            Consumer<WebController>(builder: (context, p, _) {
                          return Container(
                            width: w,
                            height: 700,
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              color: Colors.white,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "All BookMarks",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  ...List.generate(
                                    pro.allBookMark.length,
                                    (index) => ListTile(
                                      title: Text(
                                        '${pro.allSearchString[index]}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        '${pro.allBookMark[index]}',
                                        maxLines: 1,
                                      ),
                                      leading: IconButton(
                                        onPressed: () {
                                          pro.removeBookMark(index: index);
                                          pro.removeSearchString(index: index);
                                          p.update();
                                        },
                                        icon: Icon(
                                          Icons.highlight_remove_outlined,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    }
                  },
                )
              ],
            ),
            body: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(pro.getsearchUrlData ??
                        pro.allSearchEngine[pro.getBeowser]),
                  ),
                  onLoadStart: (controller, uri) {
                    pro.initController(controller: controller);
                  },
                  onLoadStop: (controller, uri) {
                    pro.initController(controller: controller);
                    pro.setCurrenturl(uri.toString());
                  },
                ),
                Positioned(
                  bottom: 50,
                  child: Consumer<searchController>(
                    builder: (context, p, _) {
                      return Visibility(
                        visible: p.searchBarVisibility,
                        child: Container(
                          height: 70,
                          width: w,
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: TextField(
                            onSubmitted: (val) {
                              pro.setSearchData(data: val);
                              p.onVisibilityChange();
                            },
                            decoration: InputDecoration(
                              suffix: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 60,
                  child: Consumer<searchController>(builder: (context, p, _) {
                    return Visibility(
                      visible: p.searchButtonVisisbility,
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 2),
                                  blurRadius: 5),
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(-2, -2),
                                  blurRadius: 5)
                            ]),
                        child: IconButton(
                          onPressed: () {
                            p.onVisibilityChange();
                          },
                          icon: Icon(
                            Icons.search,
                            size: Style.IconSize + 5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: w,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(-2, -2),
                          blurRadius: 5,
                        )
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            pro.setSearchData(data: '');
                          },
                          icon: Icon(
                            Icons.home,
                            size: Style.IconSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            pro.addBookMark();
                          },
                          icon: Icon(
                            Icons.bookmark_add_outlined,
                            size: Style.IconSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            pro.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: Style.IconSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            pro.reload();
                          },
                          icon: Icon(
                            Icons.refresh,
                            size: Style.IconSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            pro.forward();
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: Style.IconSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
