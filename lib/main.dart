import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:problemator/core/core.dart';

import 'api/repository_api.dart';
import 'blocs/blocs.dart';
import 'blocs/simple_bloc_delegate.dart';
import './main.i18n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_login/app.dart';
import 'package:flutter_firebase_login/simple_bloc_observer.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  Bloc.observer = SimpleBlocDelegate();
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
  final _navigatorKey = GlobalKey<NavigatorState>(;)

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Problemator".i18n,
      theme: ArchSampleTheme.theme,
      navigatorKey: _navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', "US"),
        const Locale('fi', "FI"),
      ],
      builder: (context , child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(listener: 
        (context, state) {
          switch (state.status) {
              case AuthenticationStatus.authenticated:
              _navigator.pushNamedAndRemoveUntil<void>(HomeePage.route(), (route) => false);
              break;

              case AuthenticationStatus.unauthenticated:
              _navigator.pushNamedAndRemoveUntil<void>(LoginPage.route(), (route) => false);
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
