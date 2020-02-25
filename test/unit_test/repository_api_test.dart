import 'dart:convert';
import 'dart:io';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:http/http.dart' as http;
import 'package:problemator/api/responses/dashboard_response.dart';
import 'package:problemator/repository/dashboard_entity.dart';

void main() {
  group("API tests", () {

    test("Test that fetchDashboard parses the DashboardEntity correctly", () async {

      ProblemsRepositoryFlutter repo = ProblemsRepositoryFlutter();

      String _json = '{"mysettings":{"etunimi":"Jarmo","gender":"m","params":"","publicascents":"1","rankinglocation":"","showinranking":"1","sport_tick_ascent_type":"0","subsubaction":"savesettings","sukunimi":"Annunen","timezone":"Europe\/Helsinki","version":"v02","_":"1486462248124","email":"jarmo@annunen.fi"},"locationsbycontinent":null,"locations":[{"id":"121","name":"LoeBloc","latitude":null,"longitude":null,"country":"Germany","continent":null,"city":"Grenzach-Wyhlen"},{"id":"124","name":"Oulun Cave","latitude":null,"longitude":null,"country":"Finland","continent":null,"city":"Oulu"},{"id":"125","name":"Kolding klatreklub","latitude":null,"longitude":null,"country":"Denmark","continent":null,"city":"kolding"},{"id":"126","name":"BlockWorks","latitude":null,"longitude":null,"country":"England","continent":"Europe","city":"London"},{"id":"127","name":"Skånes Klätterklubb","latitude":null,"longitude":null,"country":"Sweden","continent":null,"city":"Lund"},{"id":"131","name":"Berta Block ","latitude":null,"longitude":null,"country":"Germany","continent":null,"city":"Berlin"},{"id":"133","name":"Blocs and Walls","latitude":null,"longitude":null,"country":"Denmark","continent":null,"city":"København"},{"id":"134","name":"Rocklands - Riihimäen kiipeilykeskus","latitude":null,"longitude":null,"country":"Finland","continent":null,"city":"Riihimäki"},{"id":"135","name":"Hämeenlinnan kiipeilykeskus Hänkki","latitude":null,"longitude":null,"country":"Finland","continent":null,"city":"Hämeenlinna"},{"id":"136","name":"Malmö Klätterklubb","latitude":null,"longitude":null,"country":"Sweden","continent":null,"city":"Malmö"},{"id":"139","name":"Uprising Boulder Gym","latitude":null,"longitude":null,"country":"New Zealand","continent":null,"city":"Christchurch"},{"id":"140","name":"Solna Klätterklubb","latitude":null,"longitude":null,"country":"Sweden","continent":null,"city":"Solna"},{"id":"146","name":"DuvarX","latitude":null,"longitude":null,"country":"Turkey","continent":null,"city":"Istanbul"},{"id":"149","name":"Rock Over Climbing","latitude":null,"longitude":null,"country":"United Kingdom","continent":null,"city":"Manchester"},{"id":"150","name":"Whetstone Climbing ","latitude":null,"longitude":null,"country":"United States of America","continent":null,"city":"Fort Collins"},{"id":"151","name":"Cirque Climbing","latitude":null,"longitude":null,"country":"United States of America","continent":null,"city":"Lacey"},{"id":"152","name":"Chimera","latitude":null,"longitude":null,"country":"United Kingdom","continent":null,"city":"HIGH BROOMS IND EST"},{"id":"154","name":"Gravity Vault","latitude":null,"longitude":null,"country":"United States of America","continent":null,"city":"Middletown"},{"id":"155","name":"RockSolid","latitude":null,"longitude":null,"country":"Mexico","continent":null,"city":"Mexico City DF"},{"id":"156","name":"Petosen Pianri","latitude":null,"longitude":null,"country":"Finland","continent":null,"city":"Kuopio"},{"id":"157","name":"Armadillo Boulders","latitude":null,"longitude":null,"country":"United States of America","continent":null,"city":"San Antonio"},{"id":"158","name":"Push Climbing","latitude":null,"longitude":null,"country":"Finland","continent":null,"city":"Ho Chi Minh"},{"id":"1","name":"BK Pasila","latitude":"60.1962380","longitude":"24.9320980","country":"Finland","continent":"Europe","city":null},{"id":"2","name":"BK Konala","latitude":"60.2366750","longitude":"24.8588240","country":"Finland","continent":"Europe","city":null},{"id":"3","name":"BK Isatis","latitude":"60.2039570","longitude":"25.0475910","country":"Finland","continent":"Europe","city":null},{"id":"132","name":"BK Espoo","latitude":"60.1660048","longitude":"24.6325519","country":"Finland","continent":"Europe","city":"Espoo"},{"id":"8","name":"Klättercentret Telefonplan","latitude":"59.2990868","longitude":"17.9893354","country":"Sweden","continent":"Europe","city":null},{"id":"4","name":"Tampereen Kiipeilykeskus","latitude":"61.4808440","longitude":"23.7841900","country":"Finland","continent":"Europe","city":null},{"id":"138","name":"TK lielahti","latitude":"61.4808440","longitude":"23.7841900","country":"Finland","continent":"Europe","city":"Tampere"},{"id":"6","name":"Voema","latitude":"62.8792830","longitude":"27.6332080","country":"Finland","continent":"Europe","city":null},{"id":"9","name":"Bouldertehdas","latitude":"60.4523490","longitude":"22.2995780","country":"Finland","continent":"Europe","city":null},{"id":"10","name":"Helsingin Kiipeilykeskus","latitude":"60.2652570","longitude":"25.0165560","country":"Finland","continent":"Europe","city":null},{"id":"11","name":"Oulun Kiipeilykeskus","latitude":"65.0452730","longitude":"25.4341650","country":"Finland","continent":"Europe","city":null},{"id":"14","name":"Ronimisministeerium","latitude":"59.4259410","longitude":"24.7802870","country":"Finland","continent":"Europe","city":null},{"id":"15","name":"Boulderpaja","latitude":"62.2578450","longitude":"25.7777580","country":"Finland","continent":"Europe","city":null},{"id":"16","name":"Klätreverket Oslo","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":null},{"id":"17","name":"DemoGym","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":null},{"id":"99","name":"Your gym here?","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":null},{"id":"111","name":"Karbin Klätterhall","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":null},{"id":"112","name":"Virtual Boulder","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":"Helsinki"},{"id":"113","name":"Jönköpings Klätterklubb","latitude":null,"longitude":null,"country":"Sweden","continent":"Europe","city":"Jönköping"},{"id":"114","name":"City Adventure Center","latitude":null,"longitude":null,"country":"Austria","continent":"Europe","city":"Graz"},{"id":"116","name":"Karbin","latitude":null,"longitude":null,"country":"Sweden","continent":null,"city":"Hagersten"},{"id":"118","name":"Rockfish Climbing","latitude":null,"longitude":null,"country":"United States","continent":"America","city":"Whitefish"},{"id":"119","name":"Klatreverket Drammen","latitude":null,"longitude":null,"country":"Norway","continent":null,"city":"Drammen"},{"id":"120","name":"Kiipeilyareena","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":"Helsinki"},{"id":"142","name":"REDI","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":"Helsinki"},{"id":"143","name":"OTE - Kiipeilykeskus","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":"Joensuu"},{"id":"144","name":"Bouldersaimaa","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":"Lappeenranta"},{"id":"145","name":"Ladeo","latitude":null,"longitude":null,"country":"Finland","continent":"Europe","city":"Lahti"}],"climber":{"id":"246","sukunimi":"Annunen","etunimi":"Jarmo","email":"jarmo@annunen.fi","heiaheiatoken":null},"locinfo":{"id":"11","name":"Oulun Kiipeilykeskus","country":"Finland","problemcount":[]},"climbinfo":{"today":{"boulder":{"ascents":0,"points":0,"avgrade":"N\/A"},"sport":{"ascents":0,"points":0,"avgrade":"N\/A"},"ascentscombined":0},"month":{"boulder":{"ascents":0,"points":0,"avgrade":"N\/A"},"sport":{"ascents":0,"points":0,"avgrade":"N\/A"},"ascentscombined":0},"alltime":{"boulder":{"ascents":"1213","points":8650,"avgrade":"7c"},"sport":{"ascents":"20","points":6595,"avgrade":"7a"},"ascentscombined":1233},"ascentsingyms":{"boulder":{"17":"2","112":"1","142":"1","11":"0"},"sport":{"11":"0"}}},"grades":{"0":{"id":"0","name":"3","sort":null,"tapecolour":"#fff","vscale":"V0","score":"100","chartcolor":"#c0c0c0","south_africa":null,"yds":"5.4","uiaa":"IV-","australian":"9","font":"3","color133":null,"modifier_tries":null},"1":{"id":"1","name":"4","sort":null,"tapecolour":"#fff","vscale":"V0","score":"200","chartcolor":"#d0d0d0","south_africa":null,"yds":"5.6","uiaa":"IV+","australian":"12","font":"4","color133":"green","modifier_tries":null},"2":{"id":"2","name":"4+","sort":null,"tapecolour":"#fff","vscale":"V0","score":"250","chartcolor":"#e0e0e0","south_africa":null,"yds":"5.7","uiaa":"V","australian":"14","font":"4+","color133":null,"modifier_tries":null},"3":{"id":"3","name":"5","sort":null,"tapecolour":"#fff","vscale":"V1","score":"300","chartcolor":"#fafafa","south_africa":null,"yds":"5.8","uiaa":"V+","australian":"16","font":"5","color133":"yellow","modifier_tries":null},"4":{"id":"4","name":"5+","sort":null,"tapecolour":"#fff","vscale":"V2","score":"350","chartcolor":"#121212","south_africa":null,"yds":"5.9","uiaa":"VI","australian":"17","font":"5+","color133":null,"modifier_tries":null},"5":{"id":"5","name":"6a","sort":null,"tapecolour":"#FFFF00","vscale":"V3","score":"400","chartcolor":"#BDC3C7","south_africa":null,"yds":"5.10a","uiaa":"VI+","australian":"19","font":"6a","color133":"blue","modifier_tries":null},"6":{"id":"6","name":"6a+","sort":null,"tapecolour":"#FFFF00","vscale":"V3","score":"450","chartcolor":"#9B59B6","south_africa":null,"yds":"5.10c","uiaa":"VII-","australian":"20","font":"6a+","color133":null,"modifier_tries":null},"7":{"id":"7","name":"6b","sort":null,"tapecolour":"#FFFF00","vscale":"V4","score":"500","chartcolor":"#455C73","south_africa":null,"yds":"5.10d","uiaa":"VII","australian":"20\/21","font":"6b","color133":null,"modifier_tries":null},"8":{"id":"8","name":"6b+","sort":null,"tapecolour":"#FFFF00","vscale":"V4","score":"550","chartcolor":"#26B99A","south_africa":null,"yds":"5.11a","uiaa":"VII","australian":"21","font":"6b+","color133":null,"modifier_tries":null},"9":{"id":"9","name":"6c","sort":null,"tapecolour":"#FFFF00","vscale":"V5","score":"600","chartcolor":"#3498DB","south_africa":null,"yds":"5.11b","uiaa":"VII+","australian":"22","font":"6c","color133":"red","modifier_tries":null},"10":{"id":"10","name":"6c+","sort":null,"tapecolour":"#FFFF00","vscale":"V5","score":"650","chartcolor":"#CFD4D8","south_africa":null,"yds":"5.11c","uiaa":"VIII-","australian":"23","font":"6c+","color133":null,"modifier_tries":null},"11":{"id":"11","name":"7a","sort":null,"tapecolour":"#FF0000","vscale":"V6","score":"700","chartcolor":"#B370CF","south_africa":null,"yds":"5.11d","uiaa":"VIII","australian":"24","font":"7a","color133":"black","modifier_tries":null},"12":{"id":"12","name":"7a+","sort":null,"tapecolour":"#FF0000","vscale":"V7","score":"750","chartcolor":"#34495E","south_africa":null,"yds":"5.12a","uiaa":"VIII+","australian":"25","font":"7a+","color133":null,"modifier_tries":null},"13":{"id":"13","name":"7b","sort":null,"tapecolour":"#FF0000","vscale":"V8","score":"800","chartcolor":"#36CAAB","south_africa":null,"yds":"5.12b","uiaa":"VIII+","australian":"26","font":"7b","color133":"grey","modifier_tries":null},"14":{"id":"14","name":"7b+","sort":null,"tapecolour":"#FF0000","vscale":"V8","score":"850","chartcolor":"#49A9EA","south_africa":null,"yds":"5.12c","uiaa":"IX-","australian":"27","font":"7b+","color133":null,"modifier_tries":null},"15":{"id":"15","name":"7c","sort":null,"tapecolour":"#FF9900","vscale":"V9","score":"900","chartcolor":"#ef4545","south_africa":null,"yds":"5.12d","uiaa":"IX","australian":"28","font":"7c","color133":null,"modifier_tries":null},"16":{"id":"16","name":"7c+","sort":null,"tapecolour":"#FF9900","vscale":"V10","score":"950","chartcolor":"#641264","south_africa":null,"yds":"5.13a","uiaa":"IX+","australian":"29","font":"7c+","color133":null,"modifier_tries":null},"17":{"id":"17","name":"8a","sort":null,"tapecolour":"#FF9900","vscale":"V11","score":"1000","chartcolor":"#050505","south_africa":null,"yds":"5.13b","uiaa":"IX+\/X-","australian":"30","font":"8a","color133":null,"modifier_tries":null},"18":{"id":"18","name":"8a+","sort":null,"tapecolour":"#FF9900","vscale":"V12","score":"1050","chartcolor":null,"south_africa":null,"yds":"5.13c","uiaa":"X-","australian":"31","font":"8a+","color133":null,"modifier_tries":null},"19":{"id":"19","name":"8b","sort":null,"tapecolour":"#FF9900","vscale":"V13","score":"1100","chartcolor":null,"south_africa":null,"yds":"5.13c","uiaa":"X","australian":"32","font":"8b","color133":null,"modifier_tries":null},"20":{"id":"20","name":"8b+","sort":null,"tapecolour":"#ff9900","vscale":"V14","score":"1150","chartcolor":null,"south_africa":null,"yds":"5.14a","uiaa":"X+","australian":"33","font":"8b+","color133":null,"modifier_tries":null},"21":{"id":"21","name":"8c","sort":null,"tapecolour":"#ff9900","vscale":"V15","score":"1200","chartcolor":null,"south_africa":null,"yds":"5.14b","uiaa":"XI-","australian":"34","font":"8c","color133":null,"modifier_tries":null},"23":{"id":"23","name":"8c+","sort":null,"tapecolour":"#ff9900","vscale":"V16","score":"1250","chartcolor":null,"south_africa":null,"yds":"5.14c","uiaa":"XI-\/XI","australian":"35","font":"8c+","color133":null,"modifier_tries":null},"24":{"id":"24","name":"9a","sort":null,"tapecolour":"#ff9900","vscale":"V17","score":"1300","chartcolor":null,"south_africa":null,"yds":"5.14d","uiaa":"XI","australian":"36","font":"9a","color133":null,"modifier_tries":null},"30":{"id":"30","name":"project","sort":null,"tapecolour":"#fff","vscale":"V99","score":"0","chartcolor":null,"south_africa":"project","yds":"project","uiaa":"project","australian":"project","font":"project","color133":null,"modifier_tries":null}},"upcoming":[{"compname":"Boulderliiga Joensuun kiipeilykeskus OTE","compid":"162","name":"Tampereen Kiipeilykeskus","compdate":"2020-02-29 10:00:00"},{"compname":"Boulderliiga Joensuu OTE finaalit","compid":"168","name":"Tampereen Kiipeilykeskus","compdate":"2020-02-29 16:00:00"},{"compname":"Boulderliiga TK Lielahti","compid":"163","name":"Tampereen Kiipeilykeskus","compdate":"2020-03-14 10:00:00"},{"compname":"Boulderliiga TK Lielahti finaali","compid":"169","name":"Tampereen Kiipeilykeskus","compdate":"2020-03-14 16:00:00"},{"compname":"Boulder SM 2020 - Oulu","compid":"194","name":"Oulun Kiipeilykeskus","compdate":"2020-04-18 08:00:00"}],"ongoing":[],"pointModifiers":{"boulder":{"1":"100","2":"50","3":"10"},"sport":{"1":"150","2":"50","3":"10","toprope":"-100"}}}';
      var responseJson = json.decode(_json);

      DashboardEntity dashboardEntity = DashboardResponse.fromJson(responseJson).dashboard;

      expect(dashboardEntity, isInstanceOf<DashboardEntity>());
      print(dashboardEntity.toString());

      expect(dashboardEntity.mysettings.email ,'jarmo@annunen.fi');
      expect(dashboardEntity.locations[0].id,'121');
      expect(dashboardEntity.climber.id, '246');
      expect(dashboardEntity.locinfo.id, '11');
      //expect(dashboardEntity.climbinfo.today.boulder.ascents, '0');
      expect(dashboardEntity.climbinfo,isNull() );

    });
  });
}