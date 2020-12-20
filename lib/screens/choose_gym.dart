import 'package:flutter/material.dart';

class ChooseGym extends StatelessWidget {
  const ChooseGym({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChooseGym());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          Text("Choose a gym", style: Theme.of(context).textTheme.headline1),
          Text("Showing gyms near to you", style: Theme.of(context).textTheme.headline3),
        ],
      )),
    );
  }
}
