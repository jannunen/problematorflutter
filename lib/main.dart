import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/repository/authentication_repository.dart';
import 'package:problemator/repository/user_repository.dart';
import 'package:problemator/screens/home/home.dart';
import 'package:problemator/screens/login/view/login_page.dart';
import 'package:problemator/screens/splash.dart';
import 'package:problemator/ui/theme/theme.dart';

import 'blocs/blocs.dart';
import 'blocs/config/config_bloc.dart';
import 'blocs/simple_bloc_delegate.dart';
import './main.i18n.dart';
import 'package:firebase_core/firebase_core.dart';

import 'blocs/user/bloc/user_bloc.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  UserBloc userBloc = UserBloc();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(userBloc: userBloc);
  runApp(Problemator(
    authenticationRepository: authenticationRepository,
    userRepository: userRepository,
    userBloc: userBloc,
  ));
}

class Problemator extends StatelessWidget {
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
  final UserBloc userBloc;
  Problemator({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
    this.userBloc,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key) {
    userBloc.listen((user) {
      // Invoke config state change
      int i = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (context) => authenticationRepository),
          RepositoryProvider<UserRepository>(create: (context) => userRepository)
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UserBloc>(create: (_) => userBloc..add(UserEvent(User.empty))),
            BlocProvider<AuthenticationBloc>(
                create: (BuildContext context) => AuthenticationBloc(
                      authenticationRepository: authenticationRepository,
                      userBloc: BlocProvider.of<UserBloc>(context),
                    )),
            BlocProvider<ConfigBloc>(
                create: (BuildContext context) =>
                    ConfigBloc(authenticationBloc: BlocProvider.of<AuthenticationBloc>(context))
                      ..add(RestartAppEvent())),
            /*
            BlocProvider<ProblemsBloc>(
                create: (BuildContext context) =>
                    ProblemsBloc(problemsRepository: ProblemsRepository())),
                    */
          ],
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  // The widget is stateful because we need to store the navigatorkey
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;

  ThemeData activeTheme = appThemeData[AppTheme.Dark];
  /*
  if (!state.config.darkMode) {
    activeTheme = appThemeData[AppTheme.Light];
  }
  */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Problemator".i18n,
      theme: activeTheme,
      navigatorKey: _navigatorKey,
      supportedLocales: [
        const Locale('en', "US"),
        const Locale('fi', "FI"),
      ],
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(HomePage.route(), (route) => false);
                break;

              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(LoginPage.route(), (route) => false);
                break;

              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
