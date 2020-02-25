  import 'package:equatable/equatable.dart';
  import 'package:meta/meta.dart';
  import 'package:problemator/repository/repository.dart';

  @immutable
  class Problem extends Equatable {
    final String gradeid;
    final String problemid;
    final String id;
    final String gradename;
    final String locationId;
    final String wallchar;
    final String walldesc;
    final String colour;
    final String added;
    final String tag;
    final String author;
    final String routetype;
    final String startdefinition;
    final String enddefinition;
    final String addt;
    final String cLike;
    final String cLove;
    final String cDislike;
    final String vscale;
    final String score;
    final String ascentcount;
    final String addedrelative;
    final String addedformatted;
    final int mytickcount;
    final int tagshort;
    final String ticked;

    Problem(
        {this.gradeid,
        this.problemid,
        this.id,
        this.gradename,
        this.locationId,
        this.wallchar,
        this.walldesc,
        this.colour,
        this.added,
        this.tag,
        this.author,
        this.routetype,
        this.startdefinition,
        this.enddefinition,
        this.addt,
        this.cLike,
        this.cLove,
        this.cDislike,
        this.vscale,
        this.score,
        this.ascentcount,
        this.tagshort,
        this.addedformatted,
        this.addedrelative,
        this.mytickcount,
        this.ticked,
        });

        @override
    List<Object> get props => [cLike, id, cLove, cDislike,ticked];


    Problem copyWith({
        gradeid,
        problemid,
        id,
        gradename,
        locationId,
        wallchar,
        walldesc,
        colour,
        added,
        tag,
        author,
        routetype,
        startdefinition,
        enddefinition,
        addt,
        cLike,
        cLove,
        cDislike,
        vscale,
        score,
        ascentcount,
        tagshort,
        addedformatted,
        addedrelative,
        mytickcount,
        ticked,

    }) {
      return Problem(
        gradeid: gradeid,
        id: id,
        problemid: problemid,
        gradename: gradename,
        locationId: locationId,
        wallchar: wallchar,
        walldesc: walldesc,
        colour: colour,
        added: added,
        tag: tag,
        author: author,
        routetype: routetype,
        startdefinition: startdefinition,
        enddefinition: enddefinition,
        addt: addt,
        cLike: cLike,
        cLove: cLove,
        cDislike: cDislike,
        vscale: vscale,
        score: score,
        ascentcount: ascentcount,
        tagshort: tagshort,
        addedformatted: added,
        addedrelative: addedrelative,
        mytickcount: mytickcount,
        ticked: ticked
      );
    }

    static Problem fromEntity(ProblemEntity problemEntity) {
      return Problem( 
        gradeid: problemEntity.gradeid,
        id: problemEntity.id,
        problemid: problemEntity.problemid,
        gradename: problemEntity.gradename,
        locationId: problemEntity.locationId,
        wallchar: problemEntity.wallchar,
        walldesc: problemEntity.walldesc,
        colour: problemEntity.colour,
        added: problemEntity.added,
        tag: problemEntity.tag,
        author: problemEntity.author,
        routetype: problemEntity.routetype,
        startdefinition: problemEntity.startdefinition,
        enddefinition: problemEntity.enddefinition,
        addt: problemEntity.addt,
        cLike: problemEntity.cLike,
        cLove: problemEntity.cLove,
        cDislike: problemEntity.cDislike,
        vscale: problemEntity.vscale,
        score: problemEntity.score,
        ascentcount: problemEntity.ascentcount,
        tagshort: problemEntity.tagshort,
        addedformatted: problemEntity.added,
        addedrelative: problemEntity.addedrelative,
        mytickcount: problemEntity.mytickcount,
        ticked: problemEntity.ticked
      );
    }

    ProblemEntity toEntity() {
      return ProblemEntity(
        gradeid: gradeid,
        id: id,
        problemid: problemid,
        gradename: gradename,
        locationId: locationId,
        wallchar: wallchar,
        walldesc: walldesc,
        colour: colour,
        added: added,
        tag: tag,
        author: author,
        routetype: routetype,
        startdefinition: startdefinition,
        enddefinition: enddefinition,
        addt: addt,
        cLike: cLike,
        cLove: cLove,
        cDislike: cDislike,
        vscale: vscale,
        score: score,
        ascentcount: ascentcount,
        tagshort: tagshort,
        addedformatted: added,
        addedrelative: addedrelative,
        mytickcount: mytickcount,
        ticked: ticked,
      );
    }



  }
