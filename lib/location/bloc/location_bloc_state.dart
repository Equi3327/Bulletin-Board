part of 'location_bloc.dart';

abstract class LocationBlocState extends Equatable {
  const LocationBlocState();

  @override
  List<Object> get props => [];
}

class LocationBlocInitial extends LocationBlocState {}

class LocationBlocLoading extends LocationBlocState {}

class LocationBlocLoaded extends LocationBlocState {
  final String location;

  const LocationBlocLoaded({required this.location});

  @override
  List<Object> get props => [location];
}

class LocationBlocError extends LocationBlocState {
  final String error;

  const LocationBlocError({required this.error});
  @override
  List<Object> get props => [error];
}
