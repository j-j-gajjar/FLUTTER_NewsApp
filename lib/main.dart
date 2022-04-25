import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:newsappflutter/core/constants/keys.dart';
import 'package:newsappflutter/data/models/list_of_drawer_items.dart';
import 'package:newsappflutter/presentation/widgets/drop_down_list.dart';
import 'package:newsappflutter/presentation/widgets/loading_widget.dart';
import 'package:newsappflutter/presentation/widgets/news_card_widget.dart';

void main() => runApp(const MyApp());

// Global declares
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

void toggleDrawer() {
  if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
    _scaffoldKey.currentState?.openEndDrawer();
  } else {
    _scaffoldKey.currentState?.openDrawer();
  }
}

// starting point
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic cName;
  dynamic country;
  dynamic catagory;
  dynamic findNews;
  int pageNum = 1;
  bool isPageLoading = false;
  late ScrollController controller;
  int pageSize = 10;
  bool isSwitched = false;
  List news = [];
  bool notFound = false;
  List<int> data = [];
  bool isLoading = false;
  String baseApi = "https://newsapi.org/v2/top-headlines?";

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News',
      theme: isSwitched
          ? ThemeData(
              fontFamily: GoogleFonts.poppins().fontFamily,
              brightness: Brightness.light,
            )
          : ThemeData(
              fontFamily: GoogleFonts.poppins().fontFamily,
              brightness: Brightness.dark,
            ),
      home: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 32),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (country != null)
                    Text("Country = $cName")
                  else
                    Container(),
                  const SizedBox(height: 10),
                  if (catagory != null)
                    Text("Catagory = $catagory")
                  else
                    Container(),
                  const SizedBox(height: 20),
                ],
              ),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(hintText: "Find Keyword"),
                  scrollPadding: const EdgeInsets.all(5),
                  onChanged: (val) => setState(() => findNews = val),
                ),
                trailing: IconButton(
                  onPressed: () async => getNews(searchKey: findNews as String),
                  icon: const Icon(Icons.search),
                ),
              ),
              // Container(
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Padding(
              //           padding: EdgeInsets.only(left: 5),
              //           child: TextFormField(
              //             decoration: InputDecoration(hintText: "Find Keyword"),
              //             scrollPadding: EdgeInsets.all(5),
              //             onChanged: (val) => setState(() => findNews = val),
              //           ),
              //         ),
              //       ),
              //       MaterialButton(
              //         child: Text("Find"),
              //         onPressed: () async => getNews(searchKey: findNews),
              //       ),
              //     ],
              //   ),
              // ),

              ExpansionTile(
                title: const Text("Country"),
                children: [
                  for (int i = 0; i < listOfCountry.length; i++)
                    DropDownList(
                      call: () {
                        country = listOfCountry[i]['code'];
                        cName = listOfCountry[i]['name']!.toUpperCase();
                        getNews();
                      },
                      name: listOfCountry[i]['name']!.toUpperCase(),
                    )
                ],
              ),

              ExpansionTile(
                title: const Text("Catagory"),
                children: [
                  for (int i = 0; i < listOfCatagory.length; i++)
                    DropDownList(
                      call: () {
                        catagory = listOfCatagory[i]['code'];
                        getNews();
                      },
                      name: listOfCatagory[i]['name']!.toUpperCase(),
                    )
                ],
              ),
              ExpansionTile(
                title: const Text("Channel"),
                children: [
                  for (int i = 0; i < listOfNewsChannel.length; i++)
                    DropDownList(
                      call: () =>
                          getNews(channel: listOfNewsChannel[i]['code']),
                      name: listOfNewsChannel[i]['name']!.toUpperCase(),
                    ),
                ],
              ),
              //ListTile(title: Text("Exit"), onTap: () => exit(0)),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("News"),
          actions: [
            IconButton(
              onPressed: () {
                country = null;
                catagory = null;
                findNews = null;
                cName = null;
                getNews(reload: true);
              },
              icon: const Icon(Icons.refresh),
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) => setState(() => isSwitched = value),
              activeTrackColor: Colors.white,
              activeColor: Colors.white,
            ),
          ],
        ),
        body: notFound
            ? const Center(
                child: Text("Not Found", style: TextStyle(fontSize: 30)),
              )
            : news.isEmpty
                ? const Center(
                    child: LoadingWidget(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      country = null;
                      catagory = null;
                      findNews = null;
                      cName = null;
                      await getNews(reload: true);
                    },
                    child: ListView.builder(
                      controller: controller,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: NewsCardWidget(news: news, index: index),
                            ),
                            if (index == news.length - 1 && isLoading)
                              const Center(
                                child: LoadingWidget(),
                              )
                            else
                              const SizedBox(),
                          ],
                        );
                      },
                      itemCount: news.length,
                    ),
                  ),
      ),
    );
  }

  Future<void> getDataFromApi(String url) async {
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      if (jsonDecode(res.body)['totalResults'] == 0) {
        notFound = !isLoading;
        setState(() => isLoading = false);
      } else {
        if (isLoading) {
          final newData = jsonDecode(res.body)['articles'];
          for (final e in newData) {
            news.add(e);
          }
        } else {
          news = jsonDecode(res.body)['articles'] as List<dynamic>;
        }
        setState(() {
          notFound = false;
          isLoading = false;
        });
      }
    } else {
      setState(() => notFound = true);
    }
  }

  Future<void> getNews({
    String? channel,
    String? searchKey,
    bool reload = false,
  }) async {
    setState(() => notFound = false);

    if (!reload && !isLoading) {
      toggleDrawer();
    } else {
      country = null;
      catagory = null;
    }
    if (isLoading) {
      pageNum++;
    } else {
      setState(() => news = []);
      pageNum = 1;
    }
    baseApi = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&";

    baseApi += country == null ? 'country=in&' : 'country=$country&';
    baseApi += catagory == null ? '' : 'category=$catagory&';
    baseApi += 'apiKey=$apiKey';
    if (channel != null) {
      country = null;
      catagory = null;
      baseApi =
          "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&sources=$channel&apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6";
    }
    if (searchKey != null) {
      country = null;
      catagory = null;
      baseApi =
          "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&q=$searchKey&apiKey=58b98b48d2c74d9c94dd5dc296ccf7b6";
    }
    //print(baseApi);
    getDataFromApi(baseApi);
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() => isLoading = true);
      getNews();
    }
  }
}
