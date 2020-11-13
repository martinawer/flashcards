import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/card_bloc.dart';
import 'package:flutter_flashcards/bloc/card_event.dart';
import 'package:flutter_flashcards/bloc/card_state.dart';
import 'package:flutter_flashcards/components/flash_card.dart';
import 'package:flutter_flashcards/components/leading_header_button.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class DeckCardsOverviewPage extends StatefulWidget {
  final Deck deck;
  DeckCardsOverviewPage({@required this.deck});

  @override
  _DeckCardsOverviewPageState createState() => _DeckCardsOverviewPageState();
}

class _DeckCardsOverviewPageState extends State<DeckCardsOverviewPage> {
  CardBloc cardBloc;

  @override
  void initState() {
    super.initState();
    cardBloc = BlocProvider.of<CardBloc>(context);
    cardBloc.add(LoadCards(widget.deck.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.deck.title, style: Theme.of(context).appBarTheme.textTheme.headline1),
          leading: LeadingHeaderButton()
      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (BuildContext context, CardState state) {
          if (state is CardInitial) {
            cardBloc.add(LoadCards(widget.deck.id));
            return _buildInitialView();
          } else if(state is CardsLoading) {
            return _buildLoadingView();
          } else if(state is CardsLoaded) {
            return _buildCardsView(context, state);
          } else if(state is CardError) {
            return _buildErrorView();
          } else {
            return _buildErrorView();
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/editCard', arguments: new Flashcard()).then((newCard) {
            if(newCard != null && newCard is Flashcard) {
              newCard.deckId = this.widget.deck.id;
              cardBloc.add(AddCard(newCard));
            }
          });
        },
      ),
    );
  }

  _showOptionsDialog(Flashcard item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Delete Card'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Delete Card'),
              onPressed: () {
                Navigator.of(context).pop('/edit');
                cardBloc.add(DeleteCard(item));
              },
            )
          ],
        );
      },
    );
  }

  Widget _buildInitialView() {
    return Container();
  }

  Widget _buildErrorView() {
    return Container(
      child: Text('Error')
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget _buildCardsView(BuildContext context, CardState state) {
    if(state is CardsLoaded) {
      return GridView.builder(
        itemCount: state.cards.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          Flashcard item = state.cards[index];
          return InkWell(
              child: FlashCardComponent(item),
              onLongPress: () {
                _showOptionsDialog(item);
              },
              onTap: () {
                Navigator.of(context).pushNamed('/editCard', arguments: item).then((updatedCard) {
                  if(updatedCard != null && updatedCard is Flashcard) {
                    cardBloc.add(UpdateCard(updatedCard));
                  }
                });
              },
          );
        },
      );
    } else {
      throw StateError;
    }
  }
}

