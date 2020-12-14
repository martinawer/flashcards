import 'package:flutter/widgets.dart';

class Keys {
  ///Models
  static final deck = const Key('deckItem');
  static final flashcard = const Key('flashcardItem');

  static final addNewDeckFloatingActionButton = const Key('__floatingActionButton__');
  static final leadingHeaderButton = const Key('__leadingHeaderButton');
  static final decksPageSettingsButton = const Key('__decksPageSettingsButton__');
  static final decksPageStatisticsButton = const Key('__decksPageStatisticsButton__');
  static final decksPageListView = const Key('__decksPageListView__');

  static final loadingIndicatorWidget = const Key('__loadingIndicatorWidget__');
  static final errorIndicatorWidget = const Key('__errorIndicatorWidget');
  static final decksPageDeleteDeckDialog = const Key('__decksPageDeleteDeckDialog__');
  static final decksPageAddNewDeckDialog = const Key('__decksPageAddNewDeckDialog__');
}