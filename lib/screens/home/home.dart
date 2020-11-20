import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/blocs/user/bloc/user_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () =>
                context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: BlocBuilder(
            cubit: BlocProvider.of<HomeBloc>(context),
            builder: (context, state) {
              if (state is HomeLoading) {
                return CircularProgressIndicator();
              } else if (state is HomeLoaded) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //Avatar(photo: user.photo),
                    Text("You've been authenticated"),
                    const SizedBox(height: 4.0),
                    Text(user.email, style: textTheme.headline6),
                    const SizedBox(height: 4.0),
                    Text(user.name ?? '', style: textTheme.headline5),
                  ],
                );
              }
              return Container(child: Text("Unknown state" + state.toString()));
            }),
      ),
    );
  }
}
