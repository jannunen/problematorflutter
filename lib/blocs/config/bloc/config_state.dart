part of 'config_bloc.dart';

class ConfigState extends Equatable {
  final Config config;
  const ConfigState(this.config);

  @override
  List<Object> get props => [config];
}

class ConfigStateInitial extends ConfigState {
  ConfigStateInitial() : super(Config(darkMode: true));
}

class ConfigStateChanged extends ConfigState {
  final Config config;
  ConfigStateChanged(this.config) : super(config);
}

class RestartedAppState extends ConfigState {
  RestartedAppState() : super(Config());
}
