import 'package:problemator/repository/dashboard_entity.dart';

class DashboardResponse {
  DashboardEntity dashboard;

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      dashboard = new DashboardEntity.fromJson(json);
    }
  }
}
