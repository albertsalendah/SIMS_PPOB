part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;
final navigationRefreshNotifier = ValueNotifier<bool>(false);

Future<void> initDependencies() async {
  await dotenv.load(fileName: ".env");
  DioClient.dio;
  DioClient().configureDio();
  serviceLocator.registerFactory<Dio>(() => DioClient.dio);
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  _initAuth();
  _initHome();
  _initProfile();
  _initTopUp();
  _initTransaction();
}

//Auth
void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        client: serviceLocator(),
      ),
    )
    ..registerFactory<SessionLocalDataSource>(
      () => SessionLocalDataSourceImpl(
        sharedPreferences: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
        localDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogout(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSession(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthProvider(
        userLogin: serviceLocator(),
        userSignUp: serviceLocator(),
        userLogout: serviceLocator(),
        userSession: serviceLocator(),
      ),
    );
}

//Profile
_initProfile() {
  serviceLocator
    ..registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemotedataSourceImpl(
        client: serviceLocator(),
      ),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetUserProfile(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateUserProfile(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadImage(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ProfileProvider(
        getUserProfile: serviceLocator(),
        updateUserProfile: serviceLocator(),
        uploadImage: serviceLocator(),
      ),
    );
}

//Home
_initHome() {
  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        client: serviceLocator(),
      ),
    )
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetBanner(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetMenu(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => HomeProvider(
        getBanner: serviceLocator(),
        getMenu: serviceLocator(),
      ),
    );
}

//Top Up
_initTopUp() {
  serviceLocator
    ..registerFactory<TopUpRemoteDataSource>(
      () => TopUpRemoteDataSourceImpl(
        client: serviceLocator(),
      ),
    )
    ..registerFactory<TopUpRepository>(
      () => TopUpRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetBalance(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => TopupBalance(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => TopupProvider(
        getBalances: serviceLocator(),
        topupBalances: serviceLocator(),
      ),
    );
}

//Transaction
_initTransaction() {
  serviceLocator
    ..registerFactory<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(
        client: serviceLocator(),
      ),
    )
    ..registerFactory<TransactionRepository>(
      () => TransactionRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ServicePayment(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetTransaction(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => TransactionProvider(
        servicePayment: serviceLocator(),
        getTransaction: serviceLocator(),
      ),
    );
}
