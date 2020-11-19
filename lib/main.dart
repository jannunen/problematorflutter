import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/repository/authentication_repository.dart';
import 'package:problemator/screens/home/home.dart';
import 'package:problemator/screens/login/view/login_page.dart';
import 'package:problemator/screens/splash.dart';
import 'package:problemator/ui/theme/theme.dart';

import 'api/repository_api.dart';
import 'blocs/blocs.dart';
import 'blocs/simple_bloc_delegate.dart';
import './main.i18n.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) {
        return ProblemsBloc(
          problemsRepository: ProblemsRepositoryFlutter(),
        )..add(LoadProblems());
      },
      child: Problemator(authenticationRepository: AuthenticationRepository()),
    ),
  );
}

class Problemator extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  Problemator({Key key, @required this.authenticationRepository})
      : assert(authenticationRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider(
            create: (_) => AuthenticationBloc(authenticationRepository: authenticationRepository),
            child: AppView()));
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
