import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/user_repository.dart';
import '../logger/app_logger.dart';

@InjectableInit()
void $initGetIt(GetIt getIt, {String? environment}) {
  // Blocs
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthRepository>()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(getIt(), getIt())
  );
  getIt.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(getIt(), getIt())
  );

  // Services
  getIt.registerSingleton<AppLogger>(AppLogger());
}