import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import 'package:latlong2/latlong.dart' show LatLng;

import '../../../core/utils/my_gps.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription<Position>? positionStream;

  LocationBloc() : super( const LocationState() ) {

    on<OnStartFollowingUser>((event, emit) => emit( state.copyWith( followingUser: true ) ));
    on<OnStopFollowingUser>((event, emit) => emit( state.copyWith( followingUser: false ) ));

    on<OnNewUserLocationEvent>((event, emit) {
//el ... añade al arrglo un valor al final
      emit(
          state.copyWith(
            lastKnownLocation: event.newLocation,
            myLocationHistory: [ ...state.myLocationHistory, event.newLocation ],
          )
      );

    });

  }

  Future<LatLng> getCurrentPosition() async {
    print("Obteniendo coordenadas");
    final position = await Geolocator.getCurrentPosition();
    LatLng latLog=LatLng( position.latitude, position.longitude );
    print("Obteniendo coordenadas ok $latLog");
    add( OnNewUserLocationEvent( latLog ) );
    return latLog;
  }

  void startFollowingUser() {

    add(OnStartFollowingUser());

    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add( OnNewUserLocationEvent( LatLng( position.latitude, position.longitude ) ) );
    });

  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add( OnStopFollowingUser());
    print('stopFollowingUser');
  }


  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }

}
