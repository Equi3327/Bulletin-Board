import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:news_app/news/repositories/news_repository.dart';
import '../model/news_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<GetNewsList>((event, emit) async {
      try {
        emit(NewsLoading());
        final newsList = await NewsRepository().fetchNewsList();
        emit(NewsLoaded(newsList: newsList));
      } catch (e) {
        // ignore: avoid_print
        emit(NewsError(e.toString()));
      }
    });
  }
}
