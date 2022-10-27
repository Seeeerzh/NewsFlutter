import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'models/ArticleScreen.dart';
import 'categorypage.dart';
import 'helper/categorydata.dart';
import 'helper/newsdata.dart';
import 'models/categorymodel.dart';
import 'models/newsmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // get our categories list

  List<CategoryModel> categories = <CategoryModel>[];

  // get our newslist first

  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.datatobesavedin;
    setState(() {
      _loading = false;
    });


  }


  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(onPressed:(){}, icon: Icon(Icons.menu), color: Colors.white,) ,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // this is to bring the row text in center
          children: <Widget>[

            Text("Flutter ",
              style: TextStyle(
                  color: Colors.white
              ),
            ),

            Text("News",
              style: TextStyle(
                  color: Colors.amber
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: NavBar() ,

      // category widgets
       body: _loading ? Center(
         child: CircularProgressIndicator(

         ),

       ): SingleChildScrollView(
           child: Container(
             color: Colors.black,
             child: Column(

               children: <Widget>[
                Container(
                  height: 70.0,
                  padding: EdgeInsets.symmetric(horizontal: 12.0),

                  child: ListView.builder(

                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                      },

                  ),
                ),

                 Container(
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



               ],
             ),
           ),
         ),
       );

  }

  BottomNavigationBar NavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      currentIndex: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withAlpha(10),
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(left: 50),
            child: IconButton(onPressed:(){
             
            } ,
            icon: const Icon(Icons.home, color: Colors.white,),)), label: 'Home'),
          BottomNavigationBarItem(
          icon: IconButton(onPressed:(){} ,icon: const Icon(Icons.search, color: Colors.white),), label: 'Search'),
          BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(right: 50),
            child: IconButton(onPressed:(){
              print('No profile yet');
            } ,icon: const Icon(Icons.person, color: Colors.white),)), label: 'Profile')
      ],
    );
  }
}


class CategoryTile extends StatelessWidget {
  final String? categoryName, imageUrl;
  CategoryTile({this.categoryName, this.imageUrl});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Navigator.push(context, MaterialPageRoute(
        builder: (context) => CategoryFragment(
          category: categoryName!.toLowerCase(),
        ),
        ));

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[


            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: imageUrl!, width: 170, height: 90, fit: BoxFit.cover,)),


            Container(
              alignment: Alignment.center,
              width: 170, height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,


              ),
              child: Text(categoryName!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),),
            ),

          ],
        ),
      ),
    );
  }
}

// creating template for news

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
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(imageUrl: urlToImage!, width: 380, height: 200, fit: BoxFit.cover,)),
                  ),
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

