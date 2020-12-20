import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:problemator/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:problemator/blocs/gyms/bloc/gyms_bloc.dart';
import 'package:problemator/blocs/user/bloc/user_bloc.dart';
import 'package:problemator/models/gym.dart';

class ChooseGym extends StatelessWidget {
  const ChooseGym({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChooseGym());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          Text("Choose a gym", style: Theme.of(context).textTheme.headline1),
          Text("Showing gyms near to you", style: Theme.of(context).textTheme.headline3),
          BlocBuilder<GymsBloc, GymsState>(
            cubit: BlocProvider.of<GymsBloc>(context),
            builder: (context, state) {
              if (state is GymsLoading) {
                return Text("Loading gyms...");
              } else if (state is GymsLoaded) {
                return TypeAheadField<Gym>(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      style:
                          DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
                      decoration: InputDecoration(border: OutlineInputBorder())),
                  suggestionsCallback: (pattern) {
                    if (pattern == null) {
                      return [];
                    }
                    return state.gyms.where((gym) =>
                        (gym.name != null && gym.name.toLowerCase().indexOf(pattern) != -1));
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.apartment),
                      title: Text(suggestion.name ?? "No name"),
                      //subtitle: Text('\$${suggestion['price']}'),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    context.read<UserBloc>().add(UserEvent(user.copyWith(gymid: suggestion.id)));
                    Navigator.pop(context);
                  },
                );
              }
            },
          ),
        ],
      )),
    );
  }
}
