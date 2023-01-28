part of 'news_bloc.dart';

abstract class NewsState extends Equatable {}

class NewsInitial extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoaded extends NewsState {
  final List<News> newsList;
  NewsLoaded({required this.newsList});

  @override
  List<Object> get props => [newsList];
}

class NewsError extends NewsState {
  final String? message;
  NewsError(this.message);

  @override
  List<Object?> get props => [message];
}
