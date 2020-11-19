part of 'config_bloc.dart';
abstract class ConfigEvent extends Equatable {
  const ConfigEvent([List props = const <dynamic>[]]) : super();
}

class ConfigValueChanged extends ConfigEvent {
  final Config config;
  const ConfigValueChanged(this.config) : super();

  @override
  List<Object> get props => [config];
}

class RestartAppEvent extends ConfigEvent {
  String toString() => 'RestartApp';

  @override
  List<Object> get props => ['restart'];
}

class RefreshConfigEvent extends ConfigEvent {
  String toString() => 'RefreshConfig';

  @override
  List<Object> get props => ['refresh'];
}