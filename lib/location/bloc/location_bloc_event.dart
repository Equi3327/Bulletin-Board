part of 'location_bloc.dart';

abstract class LocationBlocEvent extends Equatable {
  const LocationBlocEvent();

  @override
  List<Object> get props => [];
}

class GetLocation extends LocationBlocEvent {
  @override
  List<Object> get props => [];
}
