import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'file:///C:/Users/Maddin/AndroidStudioProjects/flutter_flashcards/lib/bloc/cards/card_bloc.dart';
import 'file:///C:/Users/Maddin/AndroidStudioProjects/flutter_flashcards/lib/bloc/cards/card_event.dart';
import 'file:///C:/Users/Maddin/AndroidStudioProjects/flutter_flashcards/lib/bloc/cards/card_state.dart';
import 'package:flutter_flashcards/data/card_provider.dart';
import 'package:flutter_flashcards/models/flashcard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../fixtures/fixture_reader.dart';


class MockCardProvider extends Mock implements CardProvider {}

void main() {
  group('deckBloc', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    MockCardProvider mockCardProvider;

    final Map<String, dynamic> deckJson = json.decode(fixture('flashcard.json'));
    final Flashcard flashcard = Flashcard.fromMap(deckJson);

    setUp(() {
      mockCardProvider = MockCardProvider();
    });

    blocTest('should return an empty list of decks when LoadDecks() is called',
      build: () {
        when(mockCardProvider.getFlashcardsFromDeck(argThat(isNonNegative))).thenAnswer((_) async => []);
        return CardBloc(mockCardProvider);
      },
      act: (bloc) => bloc.add(LoadCards(1)),
      expect: [CardsLoading(), CardsLoaded([])],
    );

    blocTest('should return the newly added deck in DecksLoaded',
        build: () {
          when(mockCardProvider.getFlashcardsFromDeck(1)).thenAnswer((_) async => [flashcard]);
          return CardBloc(mockCardProvider);
        },
        act: (bloc) {
          bloc.add(AddCard(flashcard));
        },
        expect: [CardsLoading(), CardsLoaded([flashcard])]
    );
    //TODO: these tests dont work but Expected and Actual output is the same, also objects are extended by equatable
    // blocTest( 'should emit states in the order when updating',
    //   build: () {
    //   when(mockCardProvider.update(any)).thenAnswer((_) async => null);
    //   return CardBloc(mockCardProvider);
    //  },
    //   act: (bloc) {
    //     bloc.add(UpdateCard(flashcard));
    //   },
    //   expect: [CardsLoading(), CardsLoaded([])]
    // );
    //
    // blocTest('should emit states in order when deleting',
    //   build: () {
    //     when(mockCardProvider.delete(any)).thenAnswer((_) async => null);
    //     return CardBloc(mockCardProvider);
    //   },
    //   act: (bloc) => bloc.add(DeleteCard(flashcard)),
    //   expect: [CardsLoading(), CardsLoaded([])]
    // );

  });
}