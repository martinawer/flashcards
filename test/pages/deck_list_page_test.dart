import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/decks/decks.dart';
import 'package:flutter_flashcards/data/deck_provider.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/pages/deck_list_page.dart';
import 'package:flutter_flashcards/styles/themes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';

class MockDeckBloc extends MockBloc<DeckState> implements DeckBloc {}
class MockDeckProvider extends Mock implements DeckProvider {}

void main() {

  group('DeckListPage', () {
    final Map<String, dynamic> deckJson = json.decode(fixture('deck.json'));
    final Deck deck = Deck.fromMap(deckJson);
    DeckBloc deckBloc;
    DeckProvider mockDeckProvider;

    setUp(() {
      mockDeckProvider = MockDeckProvider();
      deckBloc = DeckBloc(mockDeckProvider);
    });

    tearDown(() {
      deckBloc.close();
    });

    testWidgets('should display deckList when the page is fully loaded', (WidgetTester tester) async {
      when(mockDeckProvider.create(deck)).thenAnswer((_) async => null);
      when(mockDeckProvider.getAll()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        BlocProvider.value(
          value: deckBloc,
          child: MaterialApp(
            home: DeckListPage(),
            theme: FlashCardTheme.standard,
          )
        )
      );

      await tester.pumpAndSettle();
      final deckList = find.byKey(Key('deckList'));
      final deckElement = find.byKey(Key('1'));
      expect(deckList, findsNothing);
      expect(deckElement, findsNothing);

      when(mockDeckProvider.getAll()).thenAnswer((_) async => [deck]);
    });
  });

}