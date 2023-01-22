import 'package:bloc/bloc.dart';
import 'dart:io';
import 'package:equatable/equatable.dart';

import '../../repository/news_api.dart';
import '../model/news_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<GetNewsList>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(NewsLoading());
        final newsList = await apiRepository.fetchNewsList();
        emit(NewsLoaded(news: newsList));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}
