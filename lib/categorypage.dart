import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'helper/newsdata.dart';
import 'models/ArticleScreen.dart';
import 'models/newsmodel.dart';

class CategoryFragment extends StatefulWidget {

  String category;
  CategoryFragment({required this.category});
  @override
  _CategoryFragmentState createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {


  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  getNews() async {
    CategoryNews newsdata = CategoryNews();
    await newsdata.getNews(widget.category);
    articles = newsdata.datatobesavedin;
    setState(() { // important method otherwise you would have to perform hot relod always
      _loading = false;
    });


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // this is to bring the row text in center
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(right:50),
              child: Text(widget.category.toUpperCase(),
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),



          ],
        ),
      ),
      bottomNavigationBar: NavBar() ,


      // category widgets
      body: _loading ? Center(
        child: CircularProgressIndicator()
      ): SingleChildScrollView(

               child: Container(
                  child: ListView.builder(
                    itemCount:  articles.length,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true, // add this otherwise an error
                    itemBuilder: (context, index) {

                      return NewsTemplate(
                        urlToImage: articles[index].urlToImage,
                        title: articles[index].title,
                        description: articles[index].description,
                      );


                    } ,
                  ),
                ),




            ),

        );

  }
}



class NewsTemplate extends StatelessWidget {
 
  final String? title, description, url, urlToImage;
  const NewsTemplate({this.title, this.description, this.urlToImage, this.url,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ArticleScreen(
                  article: ArticleModel(
                    description: description.toString(),
                    title: title.toString(),
                    url: url.toString(),
                    urlToImage: urlToImage.toString(), 
                  )
                )));
      },

      child: Flexible(
        flex: 1,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            
             width: MediaQuery.of(context).size.width - 40,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: Offset(3, 3),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(imageUrl: urlToImage!, width: 380, height: 200, fit: BoxFit.cover,)),
                ),
            
                SizedBox(height: 8),
            
                Flexible(child: Text(title!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),)),
            
                SizedBox(height: 8),
            
                /*Text(description!, style: TextStyle( fontSize: 15.0, color: Colors.grey[800]),),*/
            
            
            
            
            
              ],
            
            
            
            ),
          ),
        ),
      ),
    );
  }
}

BottomNavigationBar NavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(10),
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(left: 50),
            child: IconButton(onPressed:(){
             
            } ,
            icon: const Icon(Icons.home),)), label: 'Home'),
          BottomNavigationBarItem(
          icon: IconButton(onPressed:(){} ,icon: const Icon(Icons.search),), label: 'Search'),
          BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(right: 50),
            child: IconButton(onPressed:(){
              print('No profile yet');
            } ,icon: const Icon(Icons.person),)), label: 'Profile')
      ],
    );
  }
