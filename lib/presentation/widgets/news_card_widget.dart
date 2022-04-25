import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsappflutter/presentation/screens/artical_news_screen/artical_news.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({Key? key, required this.news, required this.index})
      : super(key: key);

  final List<dynamic> news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => ArticalNews(
                newsUrl: news[index]['url'] as String,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  if (news[index]['urlToImage'] == null)
                    Container()
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        placeholder: (context, url) {
                          print(news[index]['urlToImage'] as String);
                          return Container();
                        },
                        errorWidget: (context, url, error) {
                          print(error);
                          return SizedBox(
                            child: Text(error.toString()),
                          );
                        },
                        imageUrl: news[index]['urlToImage'] as String,
                      ),
                    ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Text(
                          "${news[index]['source']['name']}",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Text(
                "${news[index]['title']}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
