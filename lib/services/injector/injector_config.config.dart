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
import 'package:tourist_app/bloc/connectivity/connectivity_bloc.dart' as _i595;
import 'package:tourist_app/repositories/area_repository.dart' as _i234;
import 'package:tourist_app/repositories/auth_repository.dart' as _i223;
import 'package:tourist_app/repositories/events_repository.dart' as _i742;
import 'package:tourist_app/repositories/favotite_poi_repository.dart' as _i549;
import 'package:tourist_app/repositories/poi_repository.dart' as _i481;
import 'package:tourist_app/repositories/report_repository.dart' as _i703;
import 'package:tourist_app/repositories/review_repository.dart' as _i686;
import 'package:tourist_app/repositories/user_repository.dart' as _i575;
import 'package:tourist_app/screens/home/poi/bloc/poi_bloc.dart' as _i459;
import 'package:tourist_app/screens/map/bloc/map_bloc.dart' as _i372;
import 'package:tourist_app/screens/map/directions/bloc/directions_bloc.dart'
    as _i955;
import 'package:tourist_app/screens/map/services/map_service.dart' as _i284;
import 'package:tourist_app/screens/map/widgets/events/bloc/events_bloc.dart'
    as _i219;
import 'package:tourist_app/screens/map/widgets/report/bloc/report_bloc.dart'
    as _i285;
import 'package:tourist_app/screens/map/widgets/reviews/bloc/reviews_bloc.dart'
    as _i273;
import 'package:tourist_app/screens/profile/bloc/favorite_poi_bloc.dart'
    as _i753;
import 'package:tourist_app/screens/profile/bloc/profile_bloc.dart' as _i918;
import 'package:tourist_app/services/caching_service.dart' as _i409;
import 'package:tourist_app/services/connectivity_service.dart' as _i36;
import 'package:tourist_app/services/directions_service.dart' as _i860;
import 'package:tourist_app/services/image_picker_service.dart' as _i1021;
import 'package:tourist_app/services/logger/app_logger.dart' as _i69;
import 'package:tourist_app/services/user_service.dart' as _i915;

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
    gh.factory<_i409.CachingService>(() => _i409.CachingService());
    gh.factory<_i36.ConnectivityService>(() => _i36.ConnectivityService());
    gh.factory<_i1021.ImagePickerService>(() => _i1021.ImagePickerService());
    gh.singleton<_i69.AppLogger>(() => _i69.AppLogger());
    gh.factory<_i595.ConnectivityBloc>(
        () => _i595.ConnectivityBloc(gh<_i36.ConnectivityService>()));
    gh.factory<_i860.DirectionsService>(
        () => _i860.DirectionsService(gh<_i36.ConnectivityService>()));
    gh.factory<_i955.DirectionsBloc>(() => _i955.DirectionsBloc(
          gh<_i860.DirectionsService>(),
          gh<_i36.ConnectivityService>(),
        ));
    gh.factory<_i223.AuthRepository>(() => _i223.AuthRepositoryImpl(
          gh<_i59.FirebaseAuth>(),
          gh<_i974.FirebaseFirestore>(),
        ));
    gh.factory<_i915.UserService>(
        () => _i915.UserService(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i742.EventsRepository>(
        () => _i742.EventsRepositoryImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i549.FavoritePOIRepository>(
        () => _i549.FavoritePOIRepositoryImpl(
              gh<_i974.FirebaseFirestore>(),
              gh<_i59.FirebaseAuth>(),
            ));
    gh.factory<_i481.POIRepository>(
        () => _i481.POIRepositoryImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i399.AuthBloc>(
        () => _i399.AuthBloc(gh<_i223.AuthRepository>()));
    gh.factory<_i703.ReportRepository>(() => _i703.ReportRepositoryImpl(
          gh<_i974.FirebaseFirestore>(),
          gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i753.FavoritePOIBloc>(
        () => _i753.FavoritePOIBloc(gh<_i549.FavoritePOIRepository>()));
    gh.factory<_i686.ReviewRepository>(
        () => _i686.ReviewRepositoryImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i575.UserRepository>(() => _i575.UserRepositoryImpl(
          gh<_i974.FirebaseFirestore>(),
          gh<_i59.FirebaseAuth>(),
        ));
    gh.factory<_i273.ReviewsBloc>(
        () => _i273.ReviewsBloc(gh<_i686.ReviewRepository>()));
    gh.factory<_i234.AreaRepository>(
        () => _i234.AreaRepositoryImpl(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i372.MapBloc>(() => _i372.MapBloc(
          gh<_i481.POIRepository>(),
          gh<_i234.AreaRepository>(),
          gh<_i284.MapService>(),
        ));
    gh.factory<_i219.EventsBloc>(
        () => _i219.EventsBloc(gh<_i742.EventsRepository>()));
    gh.factory<_i918.ProfileBloc>(() => _i918.ProfileBloc(
          gh<_i575.UserRepository>(),
          gh<_i1021.ImagePickerService>(),
        ));
    gh.factory<_i459.POIBloc>(() => _i459.POIBloc(gh<_i481.POIRepository>()));
    gh.factory<_i285.ReportBloc>(
        () => _i285.ReportBloc(gh<_i703.ReportRepository>()));
    return this;
  }
}
