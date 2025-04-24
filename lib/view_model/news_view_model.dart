

import 'package:flutter/foundation.dart';
import 'package:newsapp/model/categories_news_model.dart';
import 'package:newsapp/model/news_channels_headlines_model.dart';
import 'package:newsapp/repository/news_repository.dart';

class NewsViewModel {
  final _rep= NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadLinesApi(String channelName) async{
     final response =  await _rep.fetchNewsChannelHeadLinesApi(channelName);
     return response;
  }
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    final response =  await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}