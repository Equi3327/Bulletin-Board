import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:news_app/repository/location_service.dart';

part 'location_bloc_event.dart';
part 'location_bloc_state.dart';

class LocationBloc extends Bloc<LocationBlocEvent, LocationBlocState> {
  LocationBloc({required LocationServices locationServices})
      : super(LocationBlocInitial()) {
    on<GetLocation>((event, emit) async {
      emit(LocationBlocLoading());
      try {
        final LocationData? locationData = await locationServices.getLocation();
        if (locationData != null) {
          final placemark =
              await locationServices.getPlaceMark(locationData: locationData);
          var country = placemark?.country ?? "us";
          emit(LocationBlocLoaded(location: country));
        }
      } catch (e) {
        emit(LocationBlocError(error: e.toString()));
        throw ("Error in getting location: ${e.toString()}");
      }
    });
  }
}
