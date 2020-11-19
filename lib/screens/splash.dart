import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_small.png',
              key: const Key('splash_bloc_image'),
              width: 150,
            ),
            Text("Every problem counts", style: Theme.of(context).textTheme.headline5),
          ],
        ),
      ),
    );
  }
}
