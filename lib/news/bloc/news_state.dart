part of 'news_bloc.dart';

abstract class NewsState extends Equatable {}

class NewsInitial extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsLoaded extends NewsState {
  final News news;
  NewsLoaded({required this.news});

  @override
  // TODO: implement props
  List<Object?> get props => [news];
}

class NewsError extends NewsState {
  final String? message;
  NewsError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
