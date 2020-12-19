class Grade {
  String id;
  String name;
  String sort;
  String tapecolour;
  String vscale;
  int score;
  String chartcolor;
  String southAfrica;
  String yds;
  String uiaa;
  String australian;
  String font;

  Grade({
    this.id,
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
  });

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
    tapecolour = json['tapecolour'];
    vscale = json['vscale'];
    score = int.tryParse(json['score']);
    chartcolor = json['chartcolor'];
    southAfrica = json['south_africa'];
    yds = json['yds'];
    uiaa = json['uiaa'];
    australian = json['australian'];
    font = json['font'];
  }
}
