// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'localizations/messages_all.dart';

class ArchSampleLocalizations {
  ArchSampleLocalizations(this.locale);

  final Locale locale;

  static Future<ArchSampleLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return ArchSampleLocalizations(locale);
    });
  }

  static ArchSampleLocalizations of(BuildContext context) {
    return Localizations.of<ArchSampleLocalizations>(
        context, ArchSampleLocalizations);
  }

  String get problems => Intl.message(
        'Problems',
        name: 'problems',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'Show All',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showActive => Intl.message(
        'Show Active',
        name: 'showActive',
        args: [],
        locale: locale.toString(),
      );

  String get showCompleted => Intl.message(
        'Show Completed',
        name: 'showCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get newProblemHint => Intl.message(
        'What needs to be done?',
        name: 'newProblemHint',
        args: [],
        locale: locale.toString(),
      );

  String get markAllComplete => Intl.message(
        'Mark all complete',
        name: 'markAllComplete',
        args: [],
        locale: locale.toString(),
      );

  String get markAllIncomplete => Intl.message(
        'Mark all incomplete',
        name: 'markAllIncomplete',
        args: [],
        locale: locale.toString(),
      );

  String get clearCompleted => Intl.message(
        'Clear completed',
        name: 'clearCompleted',
        args: [],
        locale: locale.toString(),
      );

  String get addProblem => Intl.message(
        'Add Problem',
        name: 'addProblem',
        args: [],
        locale: locale.toString(),
      );

  String get editProblem => Intl.message(
        'Edit Problem',
        name: 'editProblem',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get filterProblems => Intl.message(
        'Filter Problems',
        name: 'filterProblems',
        args: [],
        locale: locale.toString(),
      );

  String get deleteProblem => Intl.message(
        'Delete Problem',
        name: 'deleteProblem',
        args: [],
        locale: locale.toString(),
      );

  String get problemDetails => Intl.message(
        'Problem Details',
        name: 'problemDetails',
        args: [],
        locale: locale.toString(),
      );

  String get emptyProblemError => Intl.message(
        'Please enter some text',
        name: 'emptyProblemError',
        args: [],
        locale: locale.toString(),
      );

  String get notesHint => Intl.message(
        'Additional Notes...',
        name: 'notesHint',
        args: [],
        locale: locale.toString(),
      );

  String get completedProblems => Intl.message(
        'Completed Problems',
        name: 'completedProblems',
        args: [],
        locale: locale.toString(),
      );

  String get activeProblems => Intl.message(
        'Active Problems',
        name: 'activeProblems',
        args: [],
        locale: locale.toString(),
      );

  String problemDeleted(String task) => Intl.message(
        'Deleted "$task"',
        name: 'problemDeleted',
        args: [task],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String get deleteProblemConfirmation => Intl.message(
        'Delete this problem?',
        name: 'deleteProblemConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: locale.toString(),
      );
}

class ArchSampleLocalizationsDelegate
    extends LocalizationsDelegate<ArchSampleLocalizations> {
  @override
  Future<ArchSampleLocalizations> load(Locale locale) =>
      ArchSampleLocalizations.load(locale);

  @override
  bool shouldReload(ArchSampleLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");
}