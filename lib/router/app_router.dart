import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/card_bloc.dart';
import 'package:flutter_flashcards/bloc/deck_bloc.dart';
import 'package:flutter_flashcards/data/card_provider.dart';
import 'package:flutter_flashcards/data/deck_provider.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/models/flashcard.dart';
import 'package:flutter_flashcards/pages/flashcard_overview_page.dart';
import 'package:flutter_flashcards/pages/deck_list_page.dart';
import 'package:flutter_flashcards/pages/deck_preview_page.dart';
import 'package:flutter_flashcards/pages/error_page.dart';
import 'package:flutter_flashcards/pages/flashcard_edit_page.dart';
import 'package:flutter_flashcards/pages/learn_page.dart';
import 'package:flutter_flashcards/pages/settings_page.dart';
import 'package:flutter_flashcards/pages/statistics_page.dart';

class AppRouter {
  final DeckBloc _deckBloc = new DeckBloc(DeckProvider());
  final CardBloc _cardBloc = new CardBloc(CardProvider());

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
      case '/deck':
        if(routeSettings.arguments is Deck) {
          return MaterialPageRoute(
            builder: (_) => DeckPreviewPage(
              deck: routeSettings.arguments
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
                  child: DeckCardsOverviewPage(
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