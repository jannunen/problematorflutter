
  import 'package:equatable/equatable.dart';
  import 'package:meta/meta.dart';
  import 'package:problemator/repository/repository.dart';

  @immutable
  class Dashboard extends Equatable {

    Dashboard();

        @override
    List<Object> get props => [];


/*
    Dashboard copyWith({
    }) {
      return Dashboard(
      );
    }
    */

    static Dashboard fromEntity(DashboardEntity dashboardEntity) {
      return Dashboard( 
      );
    }

    DashboardEntity toEntity() {
      return DashboardEntity(
      );
    }



}