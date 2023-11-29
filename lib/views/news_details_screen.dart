
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsImage, newsTitle, newsDate, author, newsDesc, newsContent, newsSource;
  const NewsDetailsScreen({Key? key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.newsDesc,
    required this.newsContent,
    required this.newsSource,
  }): super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format= DateFormat('MMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height * 1;
    final width= MediaQuery.of(context).size.width * 1;
    DateTime dateTime= DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: height* 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                fit: BoxFit.cover,
                placeholder: (context, url)=> Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Container(
            height: height* 0.6,
            margin: EdgeInsets.only(top: height*0.4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle, style: GoogleFonts.poppins(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w700),),
                SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Expanded(child: Text(widget.newsSource, style: GoogleFonts.poppins(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w500),)),
                    Text(format.format(dateTime), style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),),
                  ],
                ),
                SizedBox(height: height*0.03,),
                Text(widget.newsDesc, style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
