import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news/bloc/news_bloc.dart';
import 'package:news_app/repository/remote_config_service.dart';

import '../../news/model/news_model.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  void initState() {
    NewsBloc().add(GetNewsList());
    super.initState();
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
            Text(
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
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: const Icon(Icons.list),
                            trailing: Text(
                              "News",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text("List item $index"));
                      });
                } else if (state is NewsLoading) {
                  return const CircularProgressIndicator();
                } else if (state is NewsLoaded) {
                  return _buildCard(context, state.news);
                } else if (state is NewsError) {
                  return Container(
                    child: Text("Error"),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCard(BuildContext context, News news) {
  return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: const Icon(Icons.list),
            trailing: Text(
              news.source,
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
            title: Text("List item $index"));
      });
}
