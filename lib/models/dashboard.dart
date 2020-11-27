import 'dart:collection';

import 'package:problemator/models/models.dart';

class Dashboard {
  /*
  Mysettings mysettings;
  List<Locations> locations;
  Climber climber;
  Locinfo locinfo;
  Climbinfo climbinfo;
  List<CompetitionInfo> upcoming;
  List<CompetitionInfo> ongoing;
  PointModifiers pointModifiers;
  */
  List<Tick> ticksToday;
  Spread spread;
  HashMap<String, Grade> grades;
  List<Problem> problems;

  Dashboard({
    this.ticksToday,
    this.spread,
    this.problems,
    this.grades,
    /*
        this.mysettings,
      this.locations,
      this.climber,
      this.locinfo,
      this.climbinfo,
      this.grades,
      this.upcoming,
      this.ongoing,
      this.pointModifiers
      */
  });
  Dashboard.fromJson(Map<String, dynamic> json) {
    grades = new HashMap<String, Grade>();
    problems = new List<Problem>();
    if (json['problems'] != null) {
      json['problems'].forEach((v) {
        problems.add(Problem.fromJson(v));
      });
    }
    if (json['grades'] != null) {
      json['grades'].forEach((key, value) {
        grades[value['id']] = Grade(
          id: value['id'],
          name: value['name'],
          sort: value['sort'],
          tapecolour: value['tapecolour'],
          vscale: value['vscale'],
          score: value['score'],
          chartcolor: value['chartcolor'],
          southAfrica: value['south_africa'],
          yds: value['yds'],
          uiaa: value['uiaa'],
          australian: value['australian'],
          font: value['font'],
        );
      });
    }
  }

  Dashboard copyWith({ticksToday, spreak, problems, grades}) => Dashboard(
        ticksToday: ticksToday ?? this.ticksToday,
        spread: spread ?? this.spread,
        problems: problems ?? this.problems,
        grades: grades ?? this.grades,
      );

/*
  Dashboard.fromJson(Map<String, dynamic> json) {
    mysettings = json['mysettings'] != null ? new Mysettings.fromJson(json['mysettings']) : null;
    if (json['locations'] != null) {
      locations = new List<Locations>();
      json['locations'].forEach((v) {
        locations.add(new Locations.fromJson(v));
      });
    }
    climber = json['climber'] != null ? new Climber.fromJson(json['climber']) : null;
    locinfo = json['locinfo'] != null ? new Locinfo.fromJson(json['locinfo']) : null;
    climbinfo = json['climbinfo'] != null ? new Climbinfo.fromJson(json['climbinfo']) : null;
    grades = new HashMap<String, Grade>();
    json['grades'].forEach((key, value) {
      grades[value['id']] = Grade(
        id: value['id'],
        name: value['name'],
        sort: value['sort'],
        tapecolour: value['tapecolour'],
        vscale: value['vscale'],
        score: value['score'],
        chartcolor: value['chartcolor'],
        southAfrica: value['south_africa'],
        yds: value['yds'],
        uiaa: value['uiaa'],
        australian: value['australian'],
        font: value['font'],
      );
    });

    //json['grades'] != null ? new Grades.fromJson(json['grades']) : null;
    upcoming = new List<CompetitionInfo>();
    if (json['upcoming'] != null) {
      json['upcoming'].forEach((v) {
        upcoming.add(new CompetitionInfo.fromJson(v));
      });
    }
    ongoing = new List<CompetitionInfo>();
    if (json['ongoing'] != null) {
      json['ongoing'].forEach((v) {
        ongoing.add(new CompetitionInfo.fromJson(v));
      });
    }
    pointModifiers =
        json['pointModifiers'] != null ? new PointModifiers.fromJson(json['pointModifiers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mysettings != null) {
      data['mysettings'] = this.mysettings.toJson();
    }
    if (this.locations != null) {
      data['locations'] = this.locations.map((v) => v.toJson()).toList();
    }
    if (this.climber != null) {
      data['climber'] = this.climber.toJson();
    }
    if (this.locinfo != null) {
      data['locinfo'] = this.locinfo.toJson();
    }
    if (this.climbinfo != null) {
      data['climbinfo'] = this.climbinfo.toJson();
    }
    /*
    if (this.grades != null) {
      data['grades'] = this.grades.toJson();
    }
    if (this.upcoming != null) {
      data['upcoming'] = this.upcoming.map((v) => v.toJson()).toList();
    }
    if (this.pointModifiers != null) {
      data['pointModifiers'] = this.pointModifiers.toJson();
    }
    */
    return data;
  }
}

class CompetitionInfo {
  String compname;
  String compid;
  String name;
  String compdate;

  CompetitionInfo({
    this.compname,
    this.compid,
    this.name,
    this.compdate,
  });

  CompetitionInfo.fromJson(Map<String, dynamic> json) {
    compname = json['compname'];
    compid = json['compid'];
    name = json['name'];
    compdate = json['compdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compid'] = this.compid;
    data['compname'] = this.compname;
    data['compdate'] = this.compdate;
    data['name'] = this.name;
    return data;
  }
}

class Mysettings {
  String etunimi;
  String gender;
  String params;
  String publicascents;
  String rankinglocation;
  String showinranking;
  String sportTickAscentType;
  String subsubaction;
  String sukunimi;
  String timezone;
  String version;
  String s;
  String email;

  Mysettings(
      {this.etunimi,
      this.gender,
      this.params,
      this.publicascents,
      this.rankinglocation,
      this.showinranking,
      this.sportTickAscentType,
      this.subsubaction,
      this.sukunimi,
      this.timezone,
      this.version,
      this.s,
      this.email});

  Mysettings.fromJson(Map<String, dynamic> json) {
    etunimi = json['etunimi'];
    gender = json['gender'];
    params = json['params'];
    publicascents = json['publicascents'];
    rankinglocation = json['rankinglocation'];
    showinranking = json['showinranking'];
    sportTickAscentType = json['sport_tick_ascent_type'];
    subsubaction = json['subsubaction'];
    sukunimi = json['sukunimi'];
    timezone = json['timezone'];
    version = json['version'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['etunimi'] = this.etunimi;
    data['gender'] = this.gender;
    data['params'] = this.params;
    data['publicascents'] = this.publicascents;
    data['rankinglocation'] = this.rankinglocation;
    data['showinranking'] = this.showinranking;
    data['sport_tick_ascent_type'] = this.sportTickAscentType;
    data['subsubaction'] = this.subsubaction;
    data['sukunimi'] = this.sukunimi;
    data['timezone'] = this.timezone;
    data['version'] = this.version;
    data['_'] = this.s;
    data['email'] = this.email;
    return data;
  }
}

class Locations {
  String id;
  String name;
  String latitude;
  String longitude;
  String country;
  String continent;
  String city;

  Locations(
      {this.id, this.name, this.latitude, this.longitude, this.country, this.continent, this.city});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    continent = json['continent'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['country'] = this.country;
    data['continent'] = this.continent;
    data['city'] = this.city;
    return data;
  }
}

class Climber {
  String id;
  String sukunimi;
  String etunimi;
  String email;

  Climber({this.id, this.sukunimi, this.etunimi, this.email});

  Climber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sukunimi = json['sukunimi'];
    etunimi = json['etunimi'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sukunimi'] = this.sukunimi;
    data['etunimi'] = this.etunimi;
    data['email'] = this.email;
    return data;
  }
}

class Locinfo {
  String id;
  String name;
  String country;
  List<String> problemcount;

  Locinfo({this.id, this.name, this.country, this.problemcount});

  Locinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    /*
    if (json['problemcount'] != null) {
      problemcount = new List<Null>();
      json['problemcount'].forEach((v) {
        problemcount.add(new Null.fromJson(v));
      });
    }
    */
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    /*
    if (this.problemcount != null) {
      data['problemcount'] = this.problemcount.map((v) => v.toJson()).toList();
    }
    */
    return data;
  }
}

class Climbinfo {
  ClimbStats today;
  ClimbStats month;
  ClimbStats alltime;
  Ascentsingyms ascentsingyms;

  Climbinfo({this.today, this.month, this.alltime, this.ascentsingyms});

  Climbinfo.fromJson(Map<String, dynamic> json) {
    today = json['today'] != null ? new ClimbStats.fromJson(json['today']) : null;
    month = json['month'] != null ? new ClimbStats.fromJson(json['month']) : null;
    alltime = json['alltime'] != null ? new ClimbStats.fromJson(json['alltime']) : null;
    ascentsingyms =
        json['ascentsingyms'] != null ? new Ascentsingyms.fromJson(json['ascentsingyms']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today.toJson();
    }
    if (this.month != null) {
      data['month'] = this.month.toJson();
    }
    if (this.alltime != null) {
      data['alltime'] = this.alltime.toJson();
    }
    if (this.ascentsingyms != null) {
      data['ascentsingyms'] = this.ascentsingyms.toJson();
    }
    return data;
  }
}

class ClimbStats {
  ClimbStatsPoints boulder;
  ClimbStatsPoints sport;
  int ascentscombined;

  ClimbStats({this.boulder, this.sport, this.ascentscombined});

  ClimbStats.fromJson(Map<String, dynamic> json) {
    boulder = json['boulder'] != null ? new ClimbStatsPoints.fromJson(json['boulder']) : null;
    sport = json['sport'] != null ? new ClimbStatsPoints.fromJson(json['sport']) : null;
    ascentscombined = json['ascentscombined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.boulder != null) {
      data['boulder'] = this.boulder.toJson();
    }
    if (this.sport != null) {
      data['sport'] = this.sport.toJson();
    }
    data['ascentscombined'] = this.ascentscombined;
    return data;
  }
}

class ClimbStatsPoints {
  int ascents;
  int points;
  String avgrade;

  ClimbStatsPoints({this.ascents, this.points, this.avgrade});

  ClimbStatsPoints.fromJson(Map<String, dynamic> json) {
    ascents = int.tryParse(json['ascents'].toString() ?? 0) ?? 0;
    points = int.tryParse(json['points'].toString() ?? 0) ?? 0;
    avgrade = json['avgrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ascents'] = this.ascents;
    data['points'] = this.points;
    data['avgrade'] = this.avgrade;
    return data;
  }
}

/*
class Boulder {
  String ascents;
  int points;
  String avgrade;

  Boulder({this.ascents, this.points, this.avgrade});

  Boulder.fromJson(Map<String, dynamic> json) {
    ascents = json['ascents'];
    points = json['points'];
    avgrade = json['avgrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ascents'] = this.ascents;
    data['points'] = this.points;
    data['avgrade'] = this.avgrade;
    return data;
  }
}
*/

class Ascentsingyms {
  GymAscents boulder;
  GymAscents sport;

  Ascentsingyms({this.boulder, this.sport});

  Ascentsingyms.fromJson(Map<String, dynamic> json) {
    boulder = json['boulder'] != null ? new GymAscents.fromJson(json['boulder']) : null;
    sport = json['sport'] != null ? new GymAscents.fromJson(json['sport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.boulder != null) {
      data['boulder'] = this.boulder.toJson();
    }
    if (this.sport != null) {
      data['sport'] = this.sport.toJson();
    }
    return data;
  }
}

class AscentAmountsPerGym {
  final String gymid;
  final String ascents;

  AscentAmountsPerGym({this.gymid, this.ascents});
}

class GymAscents {
  //List<AscentAmountsPerGym> ascentAmountsPerGym;
  HashMap ascentAmountsPerGym = new HashMap<String, String>();

  GymAscents({this.ascentAmountsPerGym});

  GymAscents.fromJson(Map<String, dynamic> json) {
    ascentAmountsPerGym = new HashMap<String, String>();
    json.forEach((key, value) {
      ascentAmountsPerGym[key] = value;
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class SingleGrade {
  String id;
  String name;
  String sort;
  String tapecolour;
  String vscale;
  String score;
  String chartcolor;
  String southAfrica;
  String yds;
  String uiaa;
  String australian;
  String font;
  String modifierTries;

  SingleGrade(
      {this.id,
      this.name,
      this.sort,
      this.tapecolour,
      this.vscale,
      this.score,
      this.chartcolor,
      this.southAfrica,
      this.yds,
      this.uiaa,
      this.australian,
      this.font,
      this.modifierTries});

  SingleGrade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
    tapecolour = json['tapecolour'];
    vscale = json['vscale'];
    score = json['score'];
    chartcolor = json['chartcolor'];
    southAfrica = json['south_africa'];
    yds = json['yds'];
    uiaa = json['uiaa'];
    australian = json['australian'];
    font = json['font'];
    modifierTries = json['modifier_tries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sort'] = this.sort;
    data['tapecolour'] = this.tapecolour;
    data['vscale'] = this.vscale;
    data['score'] = this.score;
    data['chartcolor'] = this.chartcolor;
    data['south_africa'] = this.southAfrica;
    data['yds'] = this.yds;
    data['uiaa'] = this.uiaa;
    data['australian'] = this.australian;
    data['font'] = this.font;
    data['modifier_tries'] = this.modifierTries;
    return data;
  }
}

class Upcoming {
  String compname;
  String compid;
  String name;
  String compdate;

  Upcoming({this.compname, this.compid, this.name, this.compdate});

  Upcoming.fromJson(Map<String, dynamic> json) {
    compname = json['compname'];
    compid = json['compid'];
    name = json['name'];
    compdate = json['compdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compname'] = this.compname;
    data['compid'] = this.compid;
    data['name'] = this.name;
    data['compdate'] = this.compdate;
    return data;
  }
}

class BoulderModifiers {
  String s1;
  String s2;
  String s3;

  BoulderModifiers({this.s1, this.s2, this.s3});

  BoulderModifiers.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    return data;
  }
}

class SportModifiers {
  String s1;
  String s2;
  String s3;
  String toprope;

  SportModifiers({this.s1, this.s2, this.s3, this.toprope});

  SportModifiers.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    toprope = json['toprope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['toprope'] = this.toprope;
    return data;
  }
}

class PointModifiers {
  HashMap<String, double> boulder;
  HashMap<String, double> sport;

  PointModifiers({this.boulder, this.sport});

  PointModifiers.fromJson(Map<String, dynamic> json) {
    boulder = new HashMap<String, double>();
    sport = new HashMap<String, double>();
    if (json['boulder'] != null) {
      json['boulder'].forEach((key, value) {
        boulder[key] = double.tryParse(value);
      });
    }
    if (json['sport'] != null) {
      json['sport'].forEach((key, value) {
        sport[key] = double.tryParse(value);
      });
    }
  }
  */
}

class Spread {
  List<SpreadPoint> points;

  Spread({this.points});
}

class SpreadPoint {
  String grade;
  int amount;

  SpreadPoint({this.grade, this.amount});
}
