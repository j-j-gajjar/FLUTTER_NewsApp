import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../model/article_model.dart';
import '../../../shared/extension.dart';
import '../../news/screen/article_news.dart';

class NewsArticleTile extends StatelessWidget {
  const NewsArticleTile({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: () => context.navigateTo(ArticleNews(newsUrl: article.url ?? '')),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 240,
                      child: Stack(
                        children: [
                          if ((article.urlToImage ?? '').isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                placeholder: (BuildContext context, String url) => const SizedBox(),
                                errorWidget: (BuildContext context, String url, error) => const SizedBox(),
                                imageUrl: article.urlToImage ?? '',
                                fit: BoxFit.cover,
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
                                  article.source!.name ?? '',
                                  style: context.theme.titleSmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Text(
                      article.title ?? '',
                      style: context.theme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
