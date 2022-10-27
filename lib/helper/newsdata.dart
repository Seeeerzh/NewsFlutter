import 'dart:convert';

import 'package:http/http.dart';
import 'package:news/models/newsmodel.dart';

class News {

  // save json data inside this
  List<ArticleModel> datatobesavedin = [];


  Future<void> getNews() async {

    var response = await get(Uri.parse("http://newsapi.org/v2/top-headlines?country=us&apiKey=YourApi"));
    var jsonData = jsonDecode(response.body);


    if (jsonData['status'] == 'ok') {

      jsonData['articles'].forEach((element) {


        if (element['urlToImage']!=null && element['description']!=null) {

          // initliaze our model class

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );


          datatobesavedin.add(articleModel);


        }


      });

    }




  }

}

// fetching news by  category
class CategoryNews {

  List<ArticleModel> datatobesavedin = [];


  Future<void> getNews(String category) async {

    var response = await get(Uri.parse('http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=YourApi'));
    var jsonData = jsonDecode(response.body);


    if (jsonData['status'] == 'ok') {

      jsonData['articles'].forEach((element) {


        if (element['urlToImage']!=null && element['description']!=null) {

          // initliaze our model class

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );


          datatobesavedin.add(articleModel);


        }


      });

    }




  }

}