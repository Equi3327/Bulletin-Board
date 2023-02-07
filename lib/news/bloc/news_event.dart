part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {}

class GetNewsList extends NewsEvent {
  final String location;
  GetNewsList({required this.location});
  @override
  List<Object> get props => [location];
}
