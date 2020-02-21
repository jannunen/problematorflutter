class ProblemListResponse {
  int totalProblems;
  List<Problem> problems;

  ProblemListResponse.fromJson(Map<String, dynamic> json) {

    if (json['problems'] != null) {
      problems = new List<Problem>();
      json['problems'].forEach((v) {
        problems.add(new Problem.fromJson(v));
      });
    }
  }
}

class Problem {
  String id;
  String gradeid;
  String author;
  String problemid;
  String gradename;
  String wallchar;
  String walldesc;
  String sort;
  String gymid;
  String wallid;
  String colour;
  String colourid;
  String visible;
  String tag;
/*
stars: null
routetype: "boulder"
startdefinition: "Two holds"
enddefinition: "Last hold"
addt: ""
c_like: "0"
c_love: "0"
c_dislike: "0"
c_dirty: "0"
c_dangerous: "0"
soontoberemoved: "0"
hidedate: null
attr_technical: "0"
attr_powerful: "0"
attr_complex: "0"
attr_mantle: "0"
attr_slopers: "0"
attr_sensitive: "0"
attr_hooks: "0"
attr_crimpers: "0"
attr_pockets: "0"
attr_volumes: "0"
attr_pinches: "0"
attr_jugs: "0"
attr_dyno: "0"
attr_fingery: "0"
attr_compression: "0"
attr_bodytension: "0"
attr_coordination: "0"
attr_mini: "0"
ext_id: null
attr_endurance: "0"
slider_risk: "0"
slider_complexity: "0"
slider_intensity: "0"
crag_route_id: null
name: "Pink"
tapecolour: "#FFFF00"
vscale: "V5"
score: "600"
chartcolor: "#3498DB"
south_africa: null
yds: "5.11b"
uiaa: "VII+"
australian: "22"
font: "6c"
color133: "red"
code: "#FF0066"
textcolor: "#000"
htmlcode: "#FF0066"
addedformatted: "04.02.2020"
addedrelative: "2 weeks ago"
tagshort: "Z2013"
colourcode: "#FF0066"
lastWall: "Boulder 2"
tick: null
*/

  Problem.fromJson(Map<String, dynamic> json) {
    id = (json['id']);
    gradeid = (json['gradeid']);
    author = json['author'];
    problemid = (json['problemid']);
    gradename = json['gradename'];
    wallchar = json['wallchar'];
    walldesc = json['walldesc'];
    sort = (json['sort']);
    gymid = (json['gymid']);
    wallid = (json['wallid']);
    colour = json['colour'];
    colourid = (json['colourid']);
    visible = (json['visible']);
    tag = json['tag'];
  }
}
