import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_flutter/models/news_channel_headlines_model.dart';
import 'package:news_app_flutter/view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:news_app_flutter/views/categories_screen.dart';
import 'package:news_app_flutter/views/news_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList{bbcNews, aryNews,cnn, independent, the_washington_post ,reuters, al_jazeera_english ,business_insider, espn, axios, abc_news, cbs_news}

class _HomeScreenState extends State<HomeScreen> {

  final format= DateFormat('MMM dd, yyyy');
  NewsViewModel newsViewModel= NewsViewModel();
  FilterList? selectedMenu;
  String name= 'bbc-news';
  @override
  Widget build(BuildContext context) {

    final width= MediaQuery.of(context).size.width * 1;
    final height= MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen(),));
          },
          icon: Image.asset('assets/images/category_icon.png', height: 30, width: 30,),
        ),
        centerTitle: true,
        title: Text('News', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert, color: Colors.black,),
            onSelected: (FilterList item){
              if(FilterList.bbcNews.name== item.name){
                name= 'bbc-news';
              }
              if(FilterList.aryNews.name== item.name){
              name= 'ary-news';
              }
              if(FilterList.cnn.name== item.name){
                name= 'cnn';
              }
              if(FilterList.independent.name== item.name){
                name= 'independent';
              }
              if(FilterList.the_washington_post.name== item.name){
                name= 'the-washington-post';
              }
              if(FilterList.reuters.name== item.name){
                name= 'reuters';
              }
              if(FilterList.al_jazeera_english.name== item.name){
                name= 'al-jazeera-english';
              }
              if(FilterList.business_insider.name== item.name){
                name= 'business-insider';
              }
              if(FilterList.espn.name== item.name){
                name= 'espn';
              }
              if(FilterList.axios.name== item.name){
                name= 'axios';
              }
              if(FilterList.abc_news.name== item.name){
                name= 'abc-news';
              }
              if(FilterList.cbs_news.name== item.name){
                name= 'cbs-news';
              }
              setState(() {
                selectedMenu= item;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
            PopupMenuItem<FilterList>(
              value: FilterList.bbcNews,
                child: Text('BBC News')),
              PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                  child: Text('Ary News')),
              PopupMenuItem<FilterList>(
                  value: FilterList.cnn,
                  child: Text('CNN News')),
              PopupMenuItem<FilterList>(
                  value: FilterList.independent,
                  child: Text('Independent News')),
              PopupMenuItem<FilterList>(
                  value: FilterList.the_washington_post,
                  child: Text('The Washington Post')),
              PopupMenuItem<FilterList>(
                  value: FilterList.reuters,
                  child: Text('Reuters News')),
              PopupMenuItem<FilterList>(
                  value: FilterList.al_jazeera_english,
                  child: Text('Al-Jazeera News')),
              PopupMenuItem<FilterList>(
                  value: FilterList.business_insider,
                  child: Text('Business Insider')),
              PopupMenuItem<FilterList>(
                  value: FilterList.espn,
                  child: Text('Espn News')),
              PopupMenuItem<FilterList>(
                  value: FilterList.axios,
                  child: Text('Axios News')),
              PopupMenuItem<FilterList>(
                  value: FilterList.abc_news,
                  child: Text('ABC News')),
              PopupMenuItem<FilterList>(
                  value: FilterList.cbs_news,
                  child: Text('CBS News')),
          ],)
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height:height * 0.55,
            width: width,
            //color: Colors.grey,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
                future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
                builder: (BuildContext context, snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.amber,
                      ),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DateTime datetime= DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsScreen(
                              newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                              newsTitle: snapshot.data!.articles![index].title.toString(),
                              newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                              author: snapshot.data!.articles![index].author.toString(),
                              newsDesc: snapshot.data!.articles![index].description.toString(),
                              newsContent: snapshot.data!.articles![index].content.toString(),
                              newsSource: snapshot.data!.articles![index].source!.name.toString()),));
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height* 0.6,
                                width: width* 0.9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: height* 0.02,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(child: spinkit,),
                                    errorWidget: (context, url, error)=> Icon(Icons.error_outline, color: Colors.red,),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    height: height* 0.22,
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width* 0.7,
                                          child: Text(snapshot.data!.articles![index].title.toString(),
                                            maxLines: 2,overflow:TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700),),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: width* 0.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString(),overflow:TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blue),),

                                              Text(format.format(datetime),overflow:TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },);
                  }
                }),
         ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
                future: newsViewModel.fetchCategoriesNewsApi('General'),
                builder: (BuildContext context, snapshot){
                  if(snapshot.connectionState== ConnectionState.waiting){
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DateTime dateTime= DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  height: height * 0.18,
                                  width: width * 0.3,
                                  placeholder: (context, url) => Container(child: spinkit,),
                                  errorWidget: (context, url, error)=> Icon(Icons.error_outline, color: Colors.red,),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    height: height* 0.18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!.articles![index].title.toString(),maxLines: 3,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                          ),),
                                        Spacer(),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w600,
                                                ),),

                                              Text(format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),))
                            ],
                          ),
                        );
                      },);
                  }
                }),
          ),
        ],
      )
    );
  }
}

const spinkit= SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
