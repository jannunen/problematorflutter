class ProblemEntity {
   String gradeid;
   String problemid;
   String id;
   String gradename;
   String locationId;
   String wallchar;
   String walldesc;
   String colour;
   String added;
   String tag;
   String author;
   String routetype;
   String startdefinition;
   String enddefinition;
   String addt;
   String cLike;
   String cLove;
   String cDislike;
   String vscale;
   String score;
   String ascentcount;
   String addedrelative;
   String addedformatted;
   String ticked;
   int mytickcount;
   int tagshort;

  ProblemEntity(
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


  ProblemEntity.fromJson(Map<String, dynamic> json) {
    gradeid = json['gradeid'];
    problemid = json['problemid'];
    id = json['id'];
    gradename = json['gradename'];
    locationId = json['location_id'];
    wallchar = json['wallchar'];
    walldesc = json['walldesc'];
    colour = json['colour'];
    added = json['added'];
    tag = json['tag'];
    author = json['author'];
    routetype = json['routetype'];
    startdefinition = json['startdefinition'];
    enddefinition = json['enddefinition'];
    addt = json['addt'];
    cLike = json['c_like'];
    cLove = json['c_love'];
    cDislike = json['c_dislike'];
    vscale = json['vscale'];
    score = json['score'];
    ascentcount = json['ascentcount'];
    ticked = json['ticked'];
    /*
    if (json['gradedist'] != null) {
      gradedist = new List<Gradedist>();
      json['gradedist'].forEach((v) {
        gradedist.add(new Gradedist.fromJson(v));
      });
    }
    tagshort = json['tagshort'];
    addedformatted = json['addedformatted'];
    addedrelative = json['addedrelative'];
    mytickcount = json['mytickcount'];
    opinions = json['opinions'] != null
        ? new Opinions.fromJson(json['opinions'])
        : null;
        */
  }

 @override
  String toString() {
    return 'ProblemEntity{tag: $tagshort, id: $id}';
  }

}

/*

class Gradedist {
  String gradeamount;
  String gradename;

  Gradedist({this.gradeamount, this.gradename});

  Gradedist.fromJson(Map<String, dynamic> json) {
    gradeamount = json['gradeamount'];
    gradename = json['gradename'];
  }

}

class Opinions {
  int i6B;
  int i6C;

  Opinions({this.i6B, this.i6C});

  Opinions.fromJson(Map<String, dynamic> json) {
    i6B = json['6B+'];
    i6C = json['6C'];
  }

}


*/