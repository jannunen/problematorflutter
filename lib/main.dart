import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/api/api_client.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/blocs/config/bloc/config_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_bloc.dart';
import 'package:problemator/blocs/gyms/bloc/gyms_bloc.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/blocs/problem/bloc/problem_bloc.dart';
import 'package:problemator/repository/authentication_repository.dart';
import 'package:problemator/repository/user_repository.dart';
import 'package:problemator/screens/home/home.dart';
import 'package:problemator/screens/login/view/login_page.dart';
import 'package:problemator/screens/splash.dart';
import 'package:problemator/ui/theme/theme.dart';
import 'package:problemator/utils/shared_objects.dart';

import 'blocs/authentication/bloc/authentication_bloc.dart';
import 'blocs/blocs.dart';
import 'blocs/simple_bloc_delegate.dart';
import './main.i18n.dart';

import 'blocs/user/bloc/user_bloc.dart';
import 'models/user.dart';

void main() async {
  // allow all certificates because HandshakeException 
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  SharedObjects.prefs = await CachedSharedPreferences.getInstance();
  runApp(App());
}

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository userRepository = UserRepository();
  UserBloc userBloc = UserBloc();
  final ApiClient apiClient = ApiClient();
  AuthenticationRepository authenticationRepository;
  AuthenticationBloc _authenticationBloc;
  ProblemsRepository _problemsRepository;
  ConfigBloc configBloc;

  @override
  void initState() {
    super.initState();
    authenticationRepository = AuthenticationRepository(userBloc: userBloc, apiClient: apiClient);
    _authenticationBloc =
        AuthenticationBloc(authenticationRepository: authenticationRepository, userBloc: userBloc);
    //_authenticationBloc.add(AuthenticationUserChanged(User.empty));
    _problemsRepository = ProblemsRepository(apiClient: apiClient, userBloc: userBloc);
    configBloc = ConfigBloc(authenticationBloc: _authenticationBloc, userBloc: userBloc);
    configBloc.add(RestartAppEvent());
  }

  @override
  Widget build(BuildContext context) {
    return _buildAppView(context);
  }

  Widget _buildAppView(BuildContext context) {
    ThemeData activeTheme = appThemeData[AppTheme.Dark];
    /*
  if (!state.config.darkMode) {
    activeTheme = appThemeData[AppTheme.Light];
  }
  */
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (context) => authenticationRepository),
          RepositoryProvider<UserRepository>(create: (context) => userRepository),
          RepositoryProvider<ProblemsRepository>(create: (context) => _problemsRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ConfigBloc>(create: (_) => configBloc),
            BlocProvider<AuthenticationBloc>(
                create: (_) => _authenticationBloc..add(AuthenticationUserChanged(User.empty))),
            BlocProvider<UserBloc>(create: (_) => userBloc),
            BlocProvider<ProblemBloc>(
                create: (context) => ProblemBloc(
                    problemsRepository: RepositoryProvider.of<ProblemsRepository>(context))),
            BlocProvider<ProblemsBloc>(
                create: (context) => ProblemsBloc(
                    problemBloc: BlocProvider.of<ProblemBloc>(context),
                    problemsRepository: RepositoryProvider.of<ProblemsRepository>(context))),
          ],
          child: MaterialApp(
            title: "Problemator".i18n,
            theme: activeTheme,
            initialRoute: '/',
            supportedLocales: [
              const Locale('en', "US"),
              const Locale('fi', "FI"),
            ],
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
              if (state.status == AuthenticationStatus.unauthenticated) {
                return LoginPage();
              } else if (state.status == AuthenticationStatus.authenticated) {
                return MultiBlocProvider(providers: [
                  BlocProvider<GymsBloc>(
                      create: (context) => GymsBloc(
                            problemsRepository: RepositoryProvider.of<ProblemsRepository>(context),
                          )),
                  BlocProvider<FilteredProblemsBloc>(
                      lazy: false,
                      create: (context) => FilteredProblemsBloc(
                          problemsBloc: BlocProvider.of<ProblemsBloc>(context))),
                  BlocProvider<HomeBloc>(
                    create: (context) => HomeBloc(
                      problemsRepository: RepositoryProvider.of<ProblemsRepository>(context),
                      userBloc: BlocProvider.of<UserBloc>(context),
                      problemBloc: BlocProvider.of<ProblemBloc>(context),
                      problemsBloc: BlocProvider.of<ProblemsBloc>(context),
                      gymsBloc: BlocProvider.of<GymsBloc>(context),
                    )..add(InitializeHomeScreenEvent()),
                  ),
                ], child: HomePage());
              } else {
                // Make splash screen stay around at least 2 secs
                Future.delayed(Duration(seconds: 2)).then((value) {
                  //_authenticationBloc.add(AuthenticationUserChanged(User.empty));
                  //context.read<ConfigBloc>().add(RestartAppEvent());
                });
                return SplashPage();
              }
            }),
          ),
        ));
  }
}

// allow all certificates because HandshakeException 
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
