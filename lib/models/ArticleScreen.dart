import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/models/newsmodel.dart';

class ArticleScreen extends StatefulWidget {
  final ArticleModel? article;

  const ArticleScreen({ Key? key, this.article}) : super(key: key);
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // this is to bring the row text in center
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(right:50),
              
            ),



          ],
        ),
      ),
        body: Stack(
          children: [
            ListView(
              children: [
                Stack(
                  children: [
                    /*Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(widget.article!.urlToImage),
                        ),
                      ),
                    ),*/

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          
                          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: widget.article!.urlToImage.toString(), width: 580, height: 400, fit: BoxFit.cover,)),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Icon(
                        Icons.more_vert,
                        size: 40,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.article!.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      
                      Text(
                        widget.article!.description,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
//                      fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.black,
                      ),*/
                      Icon(
                        Icons.share,
                        size: 30,
                        color: Colors.black,
                      ),
                      /*Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 30,
                      ),*/
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}