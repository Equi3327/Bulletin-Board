import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/news_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    Key? key,
    required this.newsList,
  }) : super(key: key);

  final List<News> newsList;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return CarouselSlider.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index, realIndex) => GestureDetector(
        onTap: () {
          _launchUrl(newsList[index].url);
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.0,
              ),
            ),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  newsList[index].urlToImage,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  frameBuilder: (BuildContext context, Widget child, int? frame,
                      bool wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported,
                      size: 200,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Flexible(
                child: Text(
                  newsList[index].title,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 11, 35, 145),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Flexible(
                child: Text(
                  newsList[index].description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      options: CarouselOptions(
        height: height * 0.8,
        enlargeCenterPage: true,
        autoPlay: false,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

//
//ListView.builder(
  //    shrinkWrap: true,
   //   physics: const ClampingScrollPhysics(),
//itemCount: newsList.length,
 //     itemBuilder: (BuildContext context, int index) {
     //   return GestureDetector(
     //     onTap: () async {
       //     _launchUrl(newsList[index].url);
         // },
          // child: Card(
          //   child:ClipRRect(
          //     borderRadius: BorderRadius.circular(20.0,),
          //     child: Container(),
          //   ), 
          //   // Container(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Flexible(
            //         child: Text(
            //           newsList[index].description,
            //           textAlign: TextAlign.justify,
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       SizedBox(
            //         width: 200.0,
            //         height: 100.0,
            //         child: Image.network(
            //           newsList[index].urlToImage,
            //           errorBuilder: (context, error, stackTrace) {
            //             return const Icon(
            //               Icons.image_not_supported,
            //               size: 50,
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
    //       ),
    //     );
    //   },
    // );