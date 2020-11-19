import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/blocs/user/bloc/user_bloc.dart';
import 'package:problemator/models/config.dart';
import 'package:problemator/models/user.dart';
import 'package:problemator/utils/shared_objects.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final UserBloc userBloc;
  final AuthenticationBloc authenticationBloc;

  ConfigBloc({this.authenticationBloc, this.userBloc}) : super(ConfigStateInitial()) {
    userBloc.listen((user) {
      if (user != User.empty) {
        add(ConfigValueChanged(state.config.copyWith(user: user)));
      }
    });
  }

  @override
  Stream<ConfigState> mapEventToState(
    ConfigEvent event,
  ) async* {
    if (event is RestartAppEvent) {
      final Config conf = await _loadConfig();
      yield (ConfigStateChanged(conf));
    } else if (event is RefreshConfigEvent) {
      // Read the config and refresh
      final Config conf = await _loadConfig();
      yield (ConfigStateChanged(conf));
    } else if (event is ConfigValueChanged) {
      final Config inConf = event.config;
      final Config oldConf = state.config;
      final Config newConf =
          oldConf.copyWith(darkMode: inConf.darkMode, user: inConf.user, token: inConf.token);
      yield (ConfigStateChanged(newConf));
      _saveConfig(newConf);
    }
  }

  Future<Config> _loadConfig() async {
    // Construct a config objula
    String userString = SharedObjects.prefs.getString('user');
    User user = null;
    if (userString != null) {
      try {
        Map<String, dynamic> gymJson = jsonDecode(userString);
        user = User.fromJson(gymJson);
      } catch (error) {
        // assume gym info not in correct format...
        SharedObjects.prefs.setString('gym', null);
      }
    }
    String token = SharedObjects.prefs.getString('auth_token');
    bool darkMode = SharedObjects.prefs.getBool('darkMode') ?? true;
    return Config(user: user, token: token, darkMode: darkMode);
  }

  Future<void> _saveConfig(Config config) async {
    User user = config.user;
    if (user != null) {
      final json = user.toJson();
      String jsonString = jsonEncode(json);
      SharedObjects.prefs.setString('user', jsonString);
    }
    SharedObjects.prefs.setString('auth_token', config.token);
    SharedObjects.prefs.setBool('darkMode', config.darkMode);
  }
}
