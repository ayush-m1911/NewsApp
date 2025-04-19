

import 'package:newsapp/model/news_channels_headlines_model.dart';
import 'package:newsapp/repository/news_repository.dart';

class NewsViewModel {
  final _rep= NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadLinesApi() async{
     final response = _rep.fetchNewsChannelHeadLinesApi();
     return response;
  }
}