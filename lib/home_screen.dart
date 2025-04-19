import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/model/news_channels_headlines_model.dart';
import 'package:newsapp/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width* 1;
    final height = MediaQuery.sizeOf(context).height* 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {  },
          icon: Image.asset('assets/category_icon.png' ,
            height: 30,
            width: 30,
          ),
        ),
        title: Text('               News', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
      ),
      body: ListView( // This centers its child both vertically and horizontally
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadLinesApi(),
              builder: (BuildContext context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                   return Center(
                     child: SpinKitCircle(
                       size: 50,
                       color: Colors.blue,
                     ),
                   );
                } else {
                   return ListView.builder(
                       itemCount: snapshot.data!.articles!.length ,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context, index){

                         DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                         return SizedBox(
                           child: Stack(
                             alignment: Alignment.center,
                             children: [
                               Container(
                                 height: height * 0.6,
                                 width:width*.9,
                                 padding: EdgeInsets.symmetric(
                                   horizontal: height * 0.02
                                 ),
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(15),

                                 child: CachedNetworkImage(
                                     imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                     fit: BoxFit.cover,
                                     placeholder: (context, url)=> Container(child: spinKit2,),
                                     errorWidget: (context, url ,error) => Icon(Icons.error_outline, color: Colors.red,),
                                 ),
                               ),
                               ),
                               Positioned(
                                 bottom: 20,
                                 child: Card(
                                   elevation: 5,
                                   color: Colors.white,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   child: Container(
                                     alignment: Alignment.bottomCenter,
                                     padding: EdgeInsets.all(15),
                                     height: height*0.22,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Container(
                                           width : width * 0.7,
                                           child: Text(snapshot.data!.articles![index].title.toString(),
                                               maxLines: 3 ,
                                               overflow: TextOverflow.ellipsis,
                                               style:
                                             GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                                           ),
                                         ),
                                         Spacer(),
                                         Container(
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text(snapshot.data!.articles![index].source!.name.toString(),
                                                 maxLines: 3 ,
                                                 overflow: TextOverflow.ellipsis,
                                                 style:
                                                 GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                                               ),
                                               Text('                                  '),
                                               Text(format.format(dateTime),
                                                 maxLines: 3 ,
                                                 overflow: TextOverflow.ellipsis,
                                                 style:
                                                 GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                 
                                     ),
                                   ),
                                 ),
                               )
                             ],

                           ),
                         );
                       }

                   );
                }
              },
            ),
          )
        ],
      ),
    );
  }
  final spinKit2 = SpinKitFadingCircle(
    color: Colors.amber,
    size: 50,
  );
}


