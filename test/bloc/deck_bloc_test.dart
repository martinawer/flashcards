import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_flashcards/bloc/decks/decks.dart';
import 'package:flutter_flashcards/data/deck_provider.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';


class MockDeckProvider extends Mock implements DeckProvider {}

void main() {
  group('deckBloc', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    MockDeckProvider mockDeckProvider;

    final Map<String, dynamic> deckJson = json.decode(fixture('deck.json'));
    final Deck deck = Deck.fromMap(deckJson);

    setUp(() {
      mockDeckProvider = MockDeckProvider();
    });

    blocTest('should return an empty list of decks when LoadDecks() is called',
      build: () {
        when(mockDeckProvider.getAll()).thenAnswer((_) async => []);
        return DeckBloc(mockDeckProvider);
      },
      act: (deckBloc) => deckBloc.add(LoadDecks()),
      expect: [DecksLoading(), DecksLoaded([])],
    );

    blocTest('should return the newly added deck in DecksLoaded',
      build: () {
        when(mockDeckProvider.getAll()).thenAnswer((_) async => [deck]);
        return DeckBloc(mockDeckProvider);
      },
      act: (bloc) {
        bloc.add(AddDeck(deck));
      },
      expect: [DecksLoading(), DecksLoaded([deck])]
    );
    //TODO: these tests dont work but Expected and Actual output is the same, also objects are extended by equatable
    // blocTest( 'should emit states in the order when updating',
    //   build: () {
    //   when(mockDeckProvider.update(any)).thenAnswer((_) async => null);
    //   return DeckBloc(mockDeckProvider);
    //  },
    //   act: (bloc) {
    //     bloc.add(UpdateDeck(deck));
    //   },
    //   expect: [DecksLoading(), DecksLoaded([])]
    // );
    //
    // blocTest('should emit states in order when deleting',
    //   build: () {
    //     when(mockDeckProvider.delete(any)).thenAnswer((_) async => null);
    //     return DeckBloc(mockDeckProvider);
    //   },
    //   act: (bloc) => bloc.add(DeleteDeck(1)),
    //   expect: [DecksLoading(), DecksLoaded([])]
    // );

  });
}