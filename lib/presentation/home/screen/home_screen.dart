import 'package:flutter/material.dart';

import '../../../data/api_repository.dart';
import '../../../model/article_model.dart';
import '../../../model/category_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/drawer_list.dart';
import '../../../shared/functions.dart';
import '../../../shared/widgets/side_drawer.dart';
import '../widgets/news_article_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onThemeChanged});

  final ValueChanged<bool> onThemeChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController controller;
  bool isThemeLight = true;
  ApiRepository api = ApiRepository(apiKey: apiKey);

  List<Article> news = [];
  bool _isLoading = true;

  final int pageSize = 10;
  int currentPage = 0;

  String searchKey = '';
  SelectableItem selectedCountry = countries.first;
  SelectableItem selectedCategory = const SelectableItem(type: ListType.category);
  SelectableItem selectedChannel = const SelectableItem(type: ListType.channel);

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
    getNews(selectedCountry.code, selectedCategory.code, channel: selectedChannel.code, searchKey: searchKey);
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() => _isLoading = true);
      getNews(selectedCountry.code, selectedCategory.code, channel: selectedChannel.code, searchKey: searchKey);
    }
  }

  void onRefresh() {
    selectedCountry = countries.first;
    selectedCategory = const SelectableItem(type: ListType.country);
    selectedChannel = const SelectableItem(type: ListType.channel);
    currentPage = 0;
    news.clear();

    getNews(selectedCountry.code, selectedCategory.code, channel: selectedChannel.code, searchKey: searchKey);
  }

  Future<void> getNews(String country, String category, {String? channel, String? searchKey}) async {
    setState(() => _isLoading = true);

    currentPage++;

    await api.requestData(api.topHeadlines(pageSize, country, category, currentPage, channel: channel, searchKey: searchKey)).then((response) {
      news.addAll((response['articles'] as List).map<Article>((article) => Article.fromJson(article as Map<String, dynamic>)).toList());
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('News'),
        actions: [
          IconButton(
            onPressed: () => onRefresh(),
            icon: const Icon(Icons.refresh),
          ),
          Switch(
            value: isThemeLight,
            onChanged: (bool value) => setState(() {
              isThemeLight = value;
              widget.onThemeChanged(value);
            }),
            activeTrackColor: Colors.white,
            activeColor: Colors.white,
          ),
        ],
      ),
      drawer: SideDrawer(
        onItemSelected: (SelectableItem item) {
          toggleDrawer(_scaffoldKey);

          if (item.type == ListType.channel) {
            selectedChannel = item;
          } else if (item.type == ListType.country) {
            selectedCountry = item;
          } else if (item.type == ListType.category) {
            selectedCategory = item;
          }
          getNews(selectedCountry.code, selectedCategory.code, channel: selectedChannel.code, searchKey: searchKey);
        },
        onSearchChanged: (String searchKey) {
          this.searchKey = searchKey;
          getNews(selectedCountry.code, selectedCategory.code, channel: selectedChannel.code, searchKey: searchKey);
        },
      ),
      body: news.isNotEmpty || !_isLoading
          ? news.isNotEmpty
              ? _buildList
              : const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                )
          : const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
            ),
    );
  }

  Widget get _buildList => ListView.builder(
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NewsArticleTile(
                article: news[index],
              ),
              if (index == news.length - 1 && _isLoading)
                SizedBox(
                  height: 100,
                  child: const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.yellow,
                    ),
                  ),
                )
            ],
          );
        },
        itemCount: news.length,
      );
}
