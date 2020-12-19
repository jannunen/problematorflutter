import 'package:problemator/models/grade.dart';

enum RouteSortOption {
  hardest_first,
  hardest_last,
  sectors_asc,
  sectors_desc,
  newest_first,
  newest_last,
  most_ascents,
  least_ascents,
  most_liked,
  least_liked,
  routesetter,
  tag_asc,
  tag_desc,
}

class GradeSortScoreSpan {
  final int min;
  final int max;
  GradeSortScoreSpan(this.min, this.max);

  @override
  String toString() {
    return "{GradeSortScoreSpan(min: " +
        this.min.toString() +
        ", max: " +
        this.max.toString() +
        "}";
  }
}

class RouteFilteringOptions {
  // the numbers correspond to grade score
  static final Map<String, GradeSortScoreSpan> gradeFilterOptions = {
    "Up to 4+": GradeSortScoreSpan(0, 250),
    "Up to 5": GradeSortScoreSpan(250, 300),
    "5 to 5+": GradeSortScoreSpan(300, 350),
    "6a to 6c+": GradeSortScoreSpan(400, 650),
    "7a to 7c": GradeSortScoreSpan(700, 900),
    "7c+ and harder": GradeSortScoreSpan(950, 9999),
  };

  static final Map<RouteSortOption, String> sortOptions = {
    RouteSortOption.newest_first: "Newest first",
    RouteSortOption.newest_last: "Newest last",
    RouteSortOption.most_ascents: "Most ascents",
    RouteSortOption.least_ascents: "Least ascents",
    RouteSortOption.hardest_first: "Hardest first",
    RouteSortOption.hardest_last: "Hardest last",
    RouteSortOption.most_liked: "Most liked",
    RouteSortOption.least_liked: "Least liked",
    RouteSortOption.routesetter: "Routesetter",
    RouteSortOption.tag_asc: "Tag ASC",
    RouteSortOption.tag_desc: "Tag DESC",
    RouteSortOption.sectors_asc: "Sectors ASC",
    RouteSortOption.sectors_desc: "Sectors DESC",
  };
}
