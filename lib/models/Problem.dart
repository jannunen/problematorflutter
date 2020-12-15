import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Problem extends Equatable {
  final String gradeid;
  final bool fresh;
  final String problemid;
  final String id;
  final String ageInWeeks;
  final String soonToBeRemoved;
  final String htmlcolour;
  final String gradename;
  final String locationId;
  final bool partOfCircuit;
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
  final int cLike;
  final int cDislike;
  final String cLove;
  final String vscale;
  final String score;
  final String ascentcount;
  final String addedrelative;
  final String addedformatted;
  final int mytickcount;
  final String tagshort;
  final bool ticked;
  final String wallid;
  final List<dynamic> attributes;

  Problem({
    this.gradeid,
    this.ageInWeeks,
    this.partOfCircuit,
    this.problemid,
    this.fresh,
    this.id,
    this.gradename,
    this.locationId,
    this.soonToBeRemoved,
    this.htmlcolour,
    this.wallchar,
    this.walldesc,
    this.wallid,
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
    this.attributes,
    this.tagshort,
    this.addedformatted,
    this.addedrelative,
    this.mytickcount,
    this.ticked,
  });

  @override
  List<Object> get props =>
      [cLike, id, cLove, cDislike, ticked, wallid, tagshort, fresh, partOfCircuit, ageInWeeks];

  Problem copyWith({
    gradeid,
    partOfCircuit,
    problemid,
    fresh,
    id,
    gradename,
    locationId,
    ageInWeeks,
    wallchar,
    soonToBeRemoved,
    walldesc,
    colour,
    added,
    tag,
    attributes,
    wallid,
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
        soonToBeRemoved: soonToBeRemoved,
        fresh: fresh,
        ageInWeeks: ageInWeeks,
        wallchar: wallchar,
        walldesc: walldesc,
        colour: colour,
        added: added,
        tag: tag,
        partOfCircuit: partOfCircuit,
        author: author,
        routetype: routetype,
        startdefinition: startdefinition,
        enddefinition: enddefinition,
        addt: addt,
        cLike: cLike,
        cLove: cLove,
        cDislike: cDislike,
        vscale: vscale,
        attributes: attributes,
        score: score,
        ascentcount: ascentcount,
        tagshort: tagshort,
        addedformatted: added,
        addedrelative: addedrelative,
        mytickcount: mytickcount,
        wallid: wallid,
        ticked: ticked);
  }

  static Problem fromJson(Map<String, dynamic> json) {
    Problem prob = new Problem(
      attributes: json['attributes'] ?? [],
      gradeid: json['gradeid'],
      problemid: json['problemid'],
      ageInWeeks: json['age_in_weeks'],
      partOfCircuit: json['part_of_circuit'],
      fresh: json['fresh'],
      id: json['id'],
      gradename: json['gradename'],
      locationId: json['location_id'],
      wallchar: json['wallchar'],
      walldesc: json['walldesc'],
      colour: json['colour'],
      added: json['added'],
      tag: json['tag'],
      soonToBeRemoved: json['soontoberemoved'],
      tagshort: json['tagshort'],
      author: json['author'],
      routetype: json['routetype'],
      startdefinition: json['startdefinition'],
      enddefinition: json['enddefinition'],
      addt: json['addt'],
      htmlcolour: json['htmlcolour'],
      cLike: int.tryParse(json['c_like']),
      cLove: json['c_love'],
      cDislike: int.tryParse(json['c_dislike']),
      vscale: json['vscale'],
      score: json['score'],
      ascentcount: json['ascentcount'],
      addedrelative: json['addedrelative'],
      ticked: json['ticked'],
      wallid: json['wallid'],
    );
    return prob;
  }
}
