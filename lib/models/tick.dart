import 'package:equatable/equatable.dart';

class Tick extends Equatable {
  final String koira;

  Tick(this.koira);

  @override
  List<Object> get props => [koira];
}

