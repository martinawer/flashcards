import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/cards/card_bloc.dart';
import 'package:flutter_flashcards/bloc/decks/deck_bloc.dart';
import 'package:flutter_flashcards/data/deck_provider.dart';
import 'package:flutter_flashcards/data/card_provider.dart';
import 'package:flutter_flashcards/models/models.dart';
import 'package:flutter_flashcards/pages/pages.dart';

class AppRouter {
  final DeckBloc _deckBloc = DeckBloc(DeckProvider());
  final CardBloc _cardBloc = CardBloc(CardProvider());
  //TODO: can do separate module for DI with get it
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => BlocProvider.value(
          value: _deckBloc,
          child: DeckListPage(),
        ));
        break;
      case '/statistics':
        return MaterialPageRoute(builder: (_) => StatisticPage());
        break;
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
        break;
      case '/learn':
        if(routeSettings.arguments is Deck) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _cardBloc,
              child: LearnPage(
                deck: routeSettings.arguments
              )
            )
          );
        } else {
          return _errorRoute();
        }
        break;
      case '/learn_overview':
        return MaterialPageRoute(builder: (_) => LearnOverviewPage());
        break;
      case '/deck':
        if(routeSettings.arguments is int) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _deckBloc,
              child: DeckPreviewPage(
                deckId: routeSettings.arguments,
              )
            )
          );
        } else {
          return _errorRoute();
        }
        break;
      case '/edit':
        if(routeSettings.arguments is Deck) {
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _cardBloc,
                    ),
                    BlocProvider.value(
                      value: _deckBloc,
                    )
                  ],
                  child: FlashcardsOverviewPage(
                    deck: routeSettings.arguments,
                  )
              )
          );
        } else {
          return _errorRoute();
        }
        break;
      case '/editCard':
        if(routeSettings.arguments is Flashcard) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _cardBloc,
              child: FlashcardEditPage(
                card: routeSettings.arguments,
              )
            )
          );
        } else {
         return _errorRoute();
        }
        break;
      default:
        return _errorRoute();
    }
  }

  MaterialPageRoute _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Error404Page()
    );
  }

  void dispose() {
    _cardBloc.close();
    _deckBloc.close();
  }
}