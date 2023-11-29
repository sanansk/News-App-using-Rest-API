import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app_flutter/models/categories_news_model.dart';
import 'package:news_app_flutter/models/news_channel_headlines_model.dart';

class NewsRepository{
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String newsChannel) async{
    String url= 'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=f5d6787e407d45e99d5a08bb21d00b5f';
    final response =await http.get(Uri.parse(url));
    print(response.statusCode.toString());
    print(response);
    if(response.statusCode==200){
      final body= jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    else{
      throw Exception('Error');
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    String url= 'https://newsapi.org/v2/everything?q=${category}&apiKey=f5d6787e407d45e99d5a08bb21d00b5f';
    final response =await http.get(Uri.parse(url));
    print(response.statusCode.toString());
    print(response);
    if(response.statusCode==200){
      final body= jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    else{
      throw Exception('Error');
    }
  }
}