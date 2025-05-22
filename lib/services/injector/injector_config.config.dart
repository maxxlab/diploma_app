// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tourist_app/bloc/auth/auth_bloc.dart' as _i399;
import 'package:tourist_app/repositories/area_repository.dart' as _i234;
import 'package:tourist_app/repositories/auth_repository.dart' as _i223;
import 'package:tourist_app/repositories/events_repository.dart' as _i742;
import 'package:tourist_app/repositories/poi_repository.dart' as _i481;
import 'package:tourist_app/repositories/user_repository.dart' as _i575;
import 'package:tourist_app/screens/home/poi/bloc/poi_bloc.dart' as _i459;
import 'package:tourist_app/screens/map/bloc/map_bloc.dart' as _i372;
import 'package:tourist_app/screens/map/directions/bloc/directions_bloc.dart'
    as _i955;
import 'package:tourist_app/screens/map/services/map_service.dart' as _i284;
import 'package:tourist_app/screens/map/widgets/events/bloc/events_bloc.dart'
    as _i219;
import 'package:tourist_app/services/directions_service.dart' as _i860;
import 'package:tourist_app/services/logger/app_logger.dart' as _i69;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i284.MapService>(() => _i284.MapService());
    gh.factory<_i860.DirectionsService>(() => _i860.DirectionsService());
    gh.singleton<_i69.AppLogger>(() => _i69.AppLogger());
    gh.factory<_i955.DirectionsBloc>(
        () => _i955.DirectionsBloc(gh<_i860.DirectionsService>()));
    gh.factory<_i223.AuthRepository>(() => _i223.AuthRepositoryImpl(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.factory<_i742.EventsRepository>(
        () => _i742.EventsRepositoryImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i481.POIRepository>(
        () => _i481.POIRepositoryImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i399.AuthBloc>(
        () => _i399.AuthBloc(gh<_i223.AuthRepository>()));
    gh.factory<_i575.UserRepository>(() => _i575.UserRepositoryImpl(
          gh<_i974.FirebaseFirestore>(),
          gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i234.AreaRepository>(
        () => _i234.AreaRepositoryImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i372.MapBloc>(() => _i372.MapBloc(
          gh<_i481.POIRepository>(),
          gh<_i234.AreaRepository>(),
          gh<_i284.MapService>(),
        ));
    gh.factory<_i219.EventsBloc>(
        () => _i219.EventsBloc(gh<_i742.EventsRepository>()));
    gh.factory<_i459.POIBloc>(() => _i459.POIBloc(gh<_i481.POIRepository>()));
    return this;
  }
}
