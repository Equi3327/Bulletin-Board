import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news/bloc/news_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/news_model.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late NewsBloc newsBloc;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(GetNewsList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top Headlines",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitial) {
                  return const Center(
                    child: Text("News Initial"),
                  );
                } else if (state is NewsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NewsLoaded) {
                  List<News> newsList = state.newsList;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: newsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          _launchUrl(newsList[index].url);
                        },
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Text(
                                    newsList[index].description,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.network(
                                  newsList[index].urlToImage,
                                  width: 75,
                                  height: 75,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is NewsError) {
                  return Center(
                    child: Text(state.message.toString()),
                  );
                } else {
                  return const Center(
                    child: Text("Don't know"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
