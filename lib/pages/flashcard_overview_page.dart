import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/cards/cards.dart';
import 'package:flutter_flashcards/bloc/decks/deck_bloc.dart';
import 'package:flutter_flashcards/bloc/decks/deck_event.dart';
import 'package:flutter_flashcards/models/models.dart';
import 'package:flutter_flashcards/tag_search.dart';
import 'package:flutter_flashcards/widgets/flashcard_item.dart';
import 'package:flutter_flashcards/widgets/leading_header_button.dart';

class FlashcardsOverviewPage extends StatefulWidget {
  final Deck deck;
  FlashcardsOverviewPage({@required this.deck});

  @override
  _FlashcardsOverviewPageState createState() => _FlashcardsOverviewPageState();
}

class _FlashcardsOverviewPageState extends State<FlashcardsOverviewPage> {
  bool _inEditMode = false;
  bool _isEditableInViewMode = false;
  Set<Flashcard> cards = {};
  CardBloc cardBloc;
  DeckBloc deckBloc;
  int deckSize;

  @override
  void initState() {
    super.initState();
    cardBloc = BlocProvider.of<CardBloc>(context);
    cardBloc.add(LoadCards(widget.deck.id));
    deckBloc = BlocProvider.of<DeckBloc>(context);
    deckSize = widget.deck.size;
  }


  @override
  Widget build(BuildContext context) {
    _isEditableInViewMode = deckSize > 0 ? true : false;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(deckSize > 0 ? true : false);
        return true;
      },
      child: Scaffold(
        appBar: _inEditMode ? _buildEditModeHeader() : _buildOverviewModeHeader(),
        body: BlocBuilder<CardBloc, CardState>(
          builder: (BuildContext context, CardState state) {
            if (state is CardInitial) {
              cardBloc.add(LoadCards(widget.deck.id));
              return Container();
            } else if(state is CardsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if(state is CardsLoaded) {
              return _buildCardsView(context, state);
            } else {
              return Container(child: Text('Error'));
            }
          }
        ),
        floatingActionButton: _inEditMode ? null : _buildFAB()
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed('/editCard', arguments: Flashcard(deckId: widget.deck.id)).then((newCard) {
          if(newCard != null) {
            cardBloc.add(AddCard(newCard));
            setState(() {
              deckBloc.add(UpdateDeck(widget.deck.copyWith(size: ++deckSize)));
            });
          }
        });
      },
    );
  }

  Widget _buildCardsView(BuildContext context, CardState state) {
    if(state is CardsLoaded) {
      return GridView.builder(
        itemCount: state.cards.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          Flashcard item = state.cards[index];
          FlashcardItem value = FlashcardItem(item,
            onTap: () {
              if(!_inEditMode) {
                return _updateCard(item);
              } else {
                if(cards.contains(item)) {
                  setState(() {
                    cards.remove(item);
                  });
                } else {
                  setState(() {
                    cards.add(item);
                  });
                }
                return null;
              }
            },
          );
          return value;
        },
      );
    } else {
      throw StateError;
    }
  }

  bool _updateCard(Flashcard item) {
    Navigator.of(context).pushNamed('/editCard', arguments: item).then((updatedCard) {
      if(updatedCard != null && updatedCard is Flashcard) {
        cardBloc.add(UpdateCard(updatedCard));
      }
    });
    return true;
  }

  Widget _buildOverviewModeHeader() {
    return AppBar(
      title: Text(widget.deck.title, style: Theme.of(context).appBarTheme.textTheme.headline1),
      leading: LeadingHeaderButton(
        onPressed: () => Navigator.of(context).pop(deckSize > 0 ? true : false),
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.edit),
            color: Colors.blue,
            onPressed: _isEditableInViewMode ? _changeMode : null
        ),
      ],
    );
  }

  Widget _buildEditModeHeader() {
    return AppBar(
      title: Text(widget.deck.title, style: Theme.of(context).appBarTheme.textTheme.headline1),
      leading: LeadingHeaderButton(
        onPressed: () {
          setState(() {
            _inEditMode = false;
            cardBloc.add(LoadCards(widget.deck.id));
          });
        }
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.label_outline),
          color: Colors.blue,
          onPressed: cards.isNotEmpty ?  openSearch : null
        ),
        IconButton(
          icon: Icon(Icons.delete),
          color: Colors.blue,
          onPressed: cards.isNotEmpty ? deleteCards : null
        ),
      ],
    );
  }

  void _changeMode() {
    setState(() {
      _inEditMode = true;
    });
  }

  Future<void> openSearch() async {
    var result = await showSearch(
        context: context,
        delegate: TagSearch(widget.deck.tags)
    );
    if (!widget.deck.tags.contains(result)) {
      _attachTag(result);
    }
  }

  void _attachTag(Tag tag) {
    if(tag != null) {
      cards.forEach((card) {
        card.tags.add(tag);
        cardBloc.add(UpdateCard(card));
      });

      widget.deck.tags.add(tag);
      deckBloc.add(UpdateDeck(widget.deck));
    }
  }

  void deleteCards() {
    setState(() {
      cards.forEach((element) {
        cardBloc.add(DeleteCard(element));
        deckSize -= 1;
      });
      deckBloc.add(UpdateDeck(widget.deck.copyWith(size: deckSize)));
      cards.clear();
    });
  }
}