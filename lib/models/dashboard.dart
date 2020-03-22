
  import 'package:equatable/equatable.dart';
  import 'package:meta/meta.dart';
  import 'package:problemator/repository/repository.dart';
  import 'package:problemator/repository/dashboard_entity.dart';

  @immutable
  class Dashboard extends Equatable {
    final String id;
    final String etunimi;
    final String sukunimi;
    final String avgrade;
    final int ascents;
    final int sportAscents;
    final int boulderToday;
    final int boulderMonth;
    final int sportToday;
    final int sportMonth;

    Dashboard(
      {this.id,
      this.etunimi,
      this.sukunimi,
      this.avgrade,
      this.ascents,
      this.sportAscents,
      this.boulderToday,
      this.boulderMonth,
      this.sportToday,
      this.sportMonth
      });

        @override
    List<Object> get props => [id, etunimi, sukunimi,
     avgrade, ascents, sportAscents, boulderToday, 
     boulderMonth, sportToday, sportToday];



    Dashboard copyWith({
      id,
      etunimi,
      sukunimi,
      avgrade,
      ascents,
      sportAscents,
      boulderToday,
      boulderMonth,
      sportToday,
      sportMonth

    }) {
      return Dashboard(
        id: id,
        etunimi: etunimi,
        sukunimi: sukunimi,
        avgrade: avgrade,
        ascents: ascents,
        sportAscents: sportAscents,
        boulderToday: boulderToday,
        boulderMonth: boulderMonth,
        sportToday: sportToday,
        sportMonth: sportMonth

      );
    }
    

    static Dashboard fromEntity(DashboardEntity dashboardEntity) {
      return Dashboard( 
        id: dashboardEntity.climber.id,
        etunimi: dashboardEntity.climber.etunimi,
        sukunimi: dashboardEntity.climber.sukunimi,
        avgrade: dashboardEntity.climbinfo.alltime.boulder.avgrade,
        ascents: dashboardEntity.climbinfo.alltime.boulder.ascents,
        sportAscents: dashboardEntity.climbinfo.alltime.sport.ascents,
        boulderToday: dashboardEntity.climbinfo.today.boulder.ascents,
        boulderMonth: dashboardEntity.climbinfo.month.boulder.ascents,
        sportToday: dashboardEntity.climbinfo.today.sport.ascents,
        sportMonth: dashboardEntity.climbinfo.month.sport.ascents,
      );
    }

    DashboardEntity toEntity() {
      return DashboardEntity(
       /* id: id,
        name: etunimi,
        sukunimi: sukunimi,
        avgrade: avgrade  */
      );
    }
}