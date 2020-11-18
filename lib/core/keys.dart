// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';

class ArchSampleKeys {
  // Home Screens
  static final homeScreen = const Key('__homeScreen__');
  static final addProblemFab = const Key('__addProblemFab__');
  static final snackbar = const Key('__snackbar__');

  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Problems
  static final problemList = const Key('__problemList__');
  static final problemsLoading = const Key('__problemsLoading__');
  static final problemItem = (String id) => Key('ProblemItem__${id}');
  static final problemItemCheckbox = (String id) => Key('ProblemItem__${id}__Checkbox');
  static final problemItemTask = (String id) => Key('ProblemItem__${id}__Task');
  static final problemItemNote = (String id) => Key('ProblemItem__${id}__Note');

  // Tabs
  static final tabs = const Key('__tabs__');
  static final homeTab = const Key('__homeTab__');
  static final competitionsTab = const Key('__competitionsTab');
  static final problemTab = const Key('__problemTab__');
  static final statsTab = const Key('__statsTab__');
  static final circuitsTab = const Key('__circuitsTab__');
  static final calendarTab = const Key('__calendarTab__');
  static final groupsTab = const Key('__groupsTab__');

  // Extra Actions
  static final extraActionsButton = const Key('__extraActionsButton__');
  static final toggleAll = const Key('__markAllDone__');
  static final clearCompleted = const Key('__clearCompleted__');

  // Filters
  static final filterButton = const Key('__filterButton__');
  static final allFilter = const Key('__allFilter__');
  static final activeFilter = const Key('__activeFilter__');
  static final completedFilter = const Key('__completedFilter__');

  // Stats
  static final statsCounter = const Key('__statsCounter__');
  static final statsLoading = const Key('__statsLoading__');
  static final statsNumActive = const Key('__statsActiveItems__');
  static final statsNumCompleted = const Key('__statsCompletedItems__');

  // Details Screen
  static final editProblemFab = const Key('__editProblemFab__');
  static final deleteProblemButton = const Key('__deleteProblemFab__');
  static final problemDetailsScreen = const Key('__problemDetailsScreen__');
  static final detailsProblemItemCheckbox = Key('DetailsProblem__Checkbox');
  static final detailsProblemItemTask = Key('DetailsProblem__Task');
  static final detailsProblemItemNote = Key('DetailsProblem__Note');

  // Add Screen
  static final addProblemScreen = const Key('__addProblemScreen__');
  static final saveNewProblem = const Key('__saveNewProblem__');
  static final taskField = const Key('__taskField__');
  static final noteField = const Key('__noteField__');

  // Edit Screen
  static final editProblemScreen = const Key('__editProblemScreen__');
  static final saveProblemFab = const Key('__saveProblemFab__');
}
