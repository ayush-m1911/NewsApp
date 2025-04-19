import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/model/news_channels_headlines_model.dart';
class NewsRepository {

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadLinesApi()async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=458217a9f7974e489bf6fcdad29e521b';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200)
      {
        final body = jsonDecode(response.body);
         return NewsChannelsHeadlinesModel.fromJson(body);
      }
    throw Exception('Error');
  }
}
